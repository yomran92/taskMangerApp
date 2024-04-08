import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:todoapp/core/error/exceptions.dart';
import 'package:todoapp/core/error/failures.dart';
import 'package:todoapp/core/utils/network_info.dart';
import 'package:todoapp/features/task/data/data_sources/remote/remote_data_source.dart';
import 'package:todoapp/features/task/data/models/param/add_new_task_param.dart';
import 'package:todoapp/features/task/data/models/param/update_task_param.dart';
import 'package:todoapp/features/task/data/models/task_model.dart';
import 'package:todoapp/features/task/data/repositories/default_task_repository.dart';
import 'package:todoapp/features/task/domain/entities/get_task_entity.dart';

class MockRemoteDataSource extends Mock
    implements TaskRemoteDataSource {}


class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
 late DefaultTaskRepository repository;
 late MockRemoteDataSource mockRemoteDataSource;
  late  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
     mockRemoteDataSource = MockRemoteDataSource();
    repository = DefaultTaskRepository(

  mockRemoteDataSource,
    );
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.initialize()).thenAnswer((_) async => true);
      });
      body();
    });
  }



  group('add Task ', () {
    final taskModel = TaskModel(id: '12', title: 't1', synced: false, content: 'c1');
    final gettaskEntity = GetTaskEntity( id:'' ,title: '',content: '',synced: false);


    test(
      'should check if the device is online',
      () async {
        //arrange
        when(mockNetworkInfo.initialize()).thenAnswer((_) async => true);
        //act
        repository.addNewTask(AddTaskParams(body: AddTaskParamsBody(task:taskModel)));
        // assert
        verify(mockNetworkInfo.initialize());
      },
    );

    runTestOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          //arrange
          when(mockRemoteDataSource.addNewTask(AddTaskParams(body: AddTaskParamsBody(task:taskModel))))
              .thenAnswer((_) async =>  taskModel);
          //acts
          final result = await repository.addNewTask(AddTaskParams(body: AddTaskParamsBody(task:taskModel)));

          // assert
          verify(mockRemoteDataSource.addNewTask(AddTaskParams(body: AddTaskParamsBody(task:taskModel))));
          expect(result, equals(Right(taskModel)));
        },
      );


      test(
        'should return serverFailure when the call to remote data source is unsuccessful',
        () async {
          //arrange
          when(mockRemoteDataSource.addNewTask(AddTaskParams(body: AddTaskParamsBody(task: taskModel))))
              .thenThrow(ServerException());
          //acts
          final result = await repository.addNewTask(AddTaskParams(body: AddTaskParamsBody(task: taskModel)) );

          // assert
          verify(mockRemoteDataSource.addNewTask(AddTaskParams(body: AddTaskParamsBody(task: taskModel))));
          expect(result, equals(Left(ServerFailure())));
          // verifyNoMoreInteractions(mockLocalDataSource);
        },
      );
    });

   });
  group('update Task ', () {
    final taskModel = TaskModel(id: '12', title: 't1', synced: false, content: 'c1');


    test(
      'should check if the device is online',
      () async {
        //arrange
        when(mockNetworkInfo.initialize()).thenAnswer((_) async => true);
        //act
        repository.updateTask(UpdateTaskParams(body: UpdateTaskParamsBody(task:taskModel)));
        // assert
        verify(mockNetworkInfo.initialize());
      },
    );

    runTestOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          //arrange
          when(mockRemoteDataSource.updateTask(UpdateTaskParams(body: UpdateTaskParamsBody(task:taskModel))))
              .thenAnswer((_) async =>  taskModel);
          //acts
          final result = await repository.updateTask(UpdateTaskParams(body: UpdateTaskParamsBody(task:taskModel)));

          // assert
          verify(mockRemoteDataSource.updateTask(UpdateTaskParams(body: UpdateTaskParamsBody(task:taskModel))));
          expect(result, equals(Right(taskModel)));
        },
      );


      test(
        'should return serverFailure when the call to remote data source is unsuccessful',
        () async {
          //arrange
          when(mockRemoteDataSource.updateTask(UpdateTaskParams(body: UpdateTaskParamsBody(task: taskModel))))
              .thenThrow(ServerException());
          //acts
          final result = await repository.updateTask(
              UpdateTaskParams(body: UpdateTaskParamsBody(task: taskModel)) );

          // assert
          verify(mockRemoteDataSource.updateTask(UpdateTaskParams(body: UpdateTaskParamsBody(task: taskModel))));
          expect(result, equals(Left(ServerFailure())));
          // verifyNoMoreInteractions(mockLocalDataSource);
        },
      );
    });

   });

 }
