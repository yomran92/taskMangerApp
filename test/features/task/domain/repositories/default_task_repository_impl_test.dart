import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/core/error/error_entity.dart';
import 'package:todoapp/core/utils/network_info.dart';
import 'package:todoapp/features/task/data/data_sources/remote/remote_data_source.dart';
import 'package:todoapp/features/task/data/models/get_all_task_model.dart';
import 'package:todoapp/features/task/data/models/param/add_new_task_param.dart';
import 'package:todoapp/features/task/data/models/param/get_all_task_param.dart';
import 'package:todoapp/features/task/data/models/param/update_task_param.dart';
import 'package:todoapp/features/task/data/models/task_model.dart';
import 'package:todoapp/features/task/data/repositories/default_task_repository.dart';

class MockRemoteDataSource extends Mock implements TaskRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late DefaultTaskRepository repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

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
    final taskModel =
        TaskModel(id: 28, todo: "Go to the gym", completed: true, userId: 15);

    test(
      'should check if the device is online',
      () async {
        //arrange
        when(mockNetworkInfo.initialize()).thenAnswer((_) async => true);
        //act
        repository.addNewTask(AddTaskParams(
            body: AddTaskParamsBody(
          completed: taskModel.completed,
          todo: taskModel.todo,
          userId: taskModel.userId,
        )));
        // assert
        verify(mockNetworkInfo.initialize());
      },
    );

    runTestOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          //arrange
          when(mockRemoteDataSource.addNewTask(AddTaskParams(
              body: AddTaskParamsBody(
            completed: taskModel.completed,
            todo: taskModel.todo,
            userId: taskModel.userId,
          )))).thenAnswer((_) async => taskModel);
          //acts
          final result = await repository.addNewTask(AddTaskParams(
              body: AddTaskParamsBody(
            completed: taskModel.completed,
            todo: taskModel.todo,
            userId: taskModel.userId,
          )));

          // assert
          verify(mockRemoteDataSource.addNewTask(AddTaskParams(
              body: AddTaskParamsBody(
            completed: taskModel.completed,
            todo: taskModel.todo,
            userId: taskModel.userId,
          ))));
          expect(result, equals(Right(taskModel)));
        },
      );

      test(
        'should return serverFailure when the call to remote data source is unsuccessful',
        () async {
          //arrange
          when(mockRemoteDataSource.addNewTask(AddTaskParams(
              body: AddTaskParamsBody(
            completed: taskModel.completed,
            todo: taskModel.todo,
            userId: taskModel.userId,
          ))));
          // .thenThrow(ServerException());
          //acts
          final result = await repository.addNewTask(AddTaskParams(
              body: AddTaskParamsBody(
            completed: taskModel.completed,
            todo: taskModel.todo,
            userId: taskModel.userId,
          )));

          // assert
          verify(mockRemoteDataSource.addNewTask(AddTaskParams(
              body: AddTaskParamsBody(
            completed: taskModel.completed,
            todo: taskModel.todo,
            userId: taskModel.userId,
          ))));
          expect(result, equals(Left(ErrorEntity(''))));
          // verifyNoMoreInteractions(mockLocalDataSource);
        },
      );
    });
  });
  group('update Task ', () {
    final taskModel =
        TaskModel(id: 28, todo: "Go to the gym", completed: true, userId: 15);

    test(
      'should check if the device is online',
      () async {
        //arrange
        when(mockNetworkInfo.initialize()).thenAnswer((_) async => true);
        //act
        repository.updateTask(UpdateTaskParams(
            body: UpdateTaskParamsBody(
          completed: true,
          taskId: taskModel.id ?? 0,
        )));
        // assert
        verify(mockNetworkInfo.initialize());
      },
    );

    runTestOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          //arrange
          when(mockRemoteDataSource.updateTask(UpdateTaskParams(
              body: UpdateTaskParamsBody(
            completed: true,
            taskId: taskModel.id ?? 0,
          )))).thenAnswer((_) async => taskModel);
          //acts
          final result = await repository.updateTask(UpdateTaskParams(
              body: UpdateTaskParamsBody(
            completed: true,
            taskId: taskModel.id ?? 0,
          )));

          // assert
          verify(mockRemoteDataSource.updateTask(UpdateTaskParams(
              body: UpdateTaskParamsBody(
            completed: true,
            taskId: taskModel.id ?? 0,
          ))));
          expect(result, equals(Right(taskModel)));
        },
      );

      test(
        'should return serverFailure when the call to remote data source is unsuccessful',
        () async {
          //arrange
          when(mockRemoteDataSource.updateTask(UpdateTaskParams(
              body: UpdateTaskParamsBody(completed: true, taskId: 0))));
          // .thenThrow(ServerException());
          //acts
          final result = await repository.updateTask(UpdateTaskParams(
              body: UpdateTaskParamsBody(completed: true, taskId: 0)));

          // assert
          verify(mockRemoteDataSource.updateTask(UpdateTaskParams(
              body: UpdateTaskParamsBody(completed: true, taskId: 0))));
          expect(result, equals(Left(ErrorEntity(''))));
          // verifyNoMoreInteractions(mockLocalDataSource);
        },
      );
    });
  });
  group('delete Task ', () {
    final taskModel =
        TaskModel(id: 28, todo: "Go to the gym", completed: true, userId: 15);

    test(
      'should check if the device is online',
      () async {
        //arrange
        when(mockNetworkInfo.initialize()).thenAnswer((_) async => true);
        //act
        repository.updateTask(UpdateTaskParams(
            body: UpdateTaskParamsBody(
          completed: true,
          taskId: taskModel.id ?? 0,
        )));
        // assert
        verify(mockNetworkInfo.initialize());
      },
    );

    runTestOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          //arrange
          when(mockRemoteDataSource.updateTask(UpdateTaskParams(
              body: UpdateTaskParamsBody(
            completed: true,
            taskId: taskModel.id ?? 0,
          )))).thenAnswer((_) async => taskModel);
          //acts
          final result = await repository.updateTask(UpdateTaskParams(
              body: UpdateTaskParamsBody(
            completed: true,
            taskId: taskModel.id ?? 0,
          )));

          // assert
          verify(mockRemoteDataSource.updateTask(UpdateTaskParams(
              body: UpdateTaskParamsBody(
            completed: true,
            taskId: taskModel.id ?? 0,
          ))));
          expect(result, equals(Right(taskModel)));
        },
      );

      test(
        'should return serverFailure when the call to remote data source is unsuccessful',
        () async {
          //arrange
          when(mockRemoteDataSource.updateTask(UpdateTaskParams(
              body: UpdateTaskParamsBody(completed: true, taskId: 0))));
          // .thenThrow(ServerException());
          //acts
          final result = await repository.updateTask(UpdateTaskParams(
              body: UpdateTaskParamsBody(completed: true, taskId: 0)));

          // assert
          verify(mockRemoteDataSource.updateTask(UpdateTaskParams(
              body: UpdateTaskParamsBody(completed: true, taskId: 0))));
          expect(result, equals(Left(ErrorEntity(''))));
          // verifyNoMoreInteractions(mockLocalDataSource);
        },
      );
    });
  });
  group('Get All Task ', () {
    final taskModel =
        TaskModel(id: 28, todo: "Go to the gym", completed: true, userId: 15);

    GetAllTaskModel tasksModel = GetAllTaskModel(
      skip: 2,
      total: 7,
      limit: 7,
      todos: [
        TaskModel(id: 28, completed: false, userId: 15, todo: "Go to the gym"),
        TaskModel(
            id: 30, completed: false, userId: 15, todo: "Take cat on a walk"),
        TaskModel(id: 42, completed: false, userId: 15, todo: "Wash car"),
        TaskModel(
            id: 56,
            completed: false,
            userId: 15,
            todo: "Go on a fishing trip with some friends"),
        TaskModel(
            id: 91,
            completed: false,
            userId: 15,
            todo: "Prepare a 72-hour kit"),
        TaskModel(
            id: 126, completed: false, userId: 15, todo: "Take a bubble bath"),
        TaskModel(
            id: 128,
            completed: false,
            userId: 15,
            todo: "Paint the first thing I see"),
      ],
    );

    int limit = 7;
    int skip = 7;

    test(
      'should check if the device is online',
      () async {
        //arrange
        when(mockNetworkInfo.initialize()).thenAnswer((_) async => true);
        //act
        repository.getAllTask(GetAllTaskParams(
            body: GetAllTaskParamsBody(
          skip: skip,
          limit: limit,
        )));
        // assert
        verify(mockNetworkInfo.initialize());
      },
    );

    runTestOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          //arrange
          when(mockRemoteDataSource.getAllTask(GetAllTaskParams(
              body: GetAllTaskParamsBody(
            skip: skip,
            limit: limit,
          )))).thenAnswer((_) async => tasksModel);
          //acts
          final result = await repository.getAllTask(GetAllTaskParams(
              body: GetAllTaskParamsBody(
            skip: skip,
            limit: limit,
          )));

          // assert
          verify(mockRemoteDataSource.getAllTask(GetAllTaskParams(
              body: GetAllTaskParamsBody(
            skip: skip,
            limit: limit,
          ))));
          expect(result, equals(Right(taskModel)));
        },
      );

      test(
        'should return serverFailure when the call to remote data source is unsuccessful',
        () async {
          //arrange
          when(mockRemoteDataSource.getAllTask(GetAllTaskParams(
              body: GetAllTaskParamsBody(
            skip: skip,
            limit: limit,
          ))));
          // .thenThrow(ServerException());
          //acts
          final result = await repository.getAllTask(GetAllTaskParams(
              body: GetAllTaskParamsBody(
            skip: skip,
            limit: limit,
          )));

          // assert
          verify(mockRemoteDataSource.getAllTask(GetAllTaskParams(
              body: GetAllTaskParamsBody(
            skip: skip,
            limit: limit,
          ))));
          expect(result, equals(Left(ErrorEntity(''))));
          // verifyNoMoreInteractions(mockLocalDataSource);
        },
      );
    });
  });
}
