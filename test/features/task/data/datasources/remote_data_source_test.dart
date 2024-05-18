import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:todoapp/core/constants.dart';
import 'package:todoapp/core/error/app_exceptions.dart';
import 'package:todoapp/features/task/data/data_sources/remote/remote_data_source.dart';
import 'package:todoapp/features/task/data/models/get_all_task_model.dart';
import 'package:todoapp/features/task/data/models/param/add_new_task_param.dart';
import 'package:todoapp/features/task/data/models/param/delete_task_param.dart';
import 'package:todoapp/features/task/data/models/param/get_all_task_param.dart';
import 'package:todoapp/features/task/data/models/param/update_task_param.dart';
import 'package:todoapp/features/task/data/models/task_model.dart';import '../../../../fixtures/fixture.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late TaskRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;
  late HiveInterface? hiveInterface = Hive;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TaskRemoteDataSource(hiveInterface);
  });
  void setUpMockHttpClientSuccess200(String endPoint) {
    when(mockHttpClient.get(Uri.parse(BaseUrl + endPoint),
            headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('task.json'), 200));
  }

  void setUpMockHttpClientSuccess200Post(String endPoint) {
    when(mockHttpClient.post(Uri.parse(BaseUrl + endPoint),
            headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('task.json'), 200));
  }

  void setUpMockHttpClientSuccess200PUT(String endPoint) {
    when(mockHttpClient.put(Uri.parse(BaseUrl + endPoint),
            headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('task.json'), 200));
  }

  void setUpMockHttpClientSuccess200Delete(String endPoint) {
    when(mockHttpClient.put(Uri.parse(BaseUrl + endPoint),
            headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('task.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(Uri.parse(''), headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockHttpClientFailure404Post() {
    when(mockHttpClient.get(Uri.parse(''), headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockHttpClientFailure404PUT() {
    when(mockHttpClient.put(Uri.parse(''), headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockHttpClientFailure404delete() {
    when(mockHttpClient.put(Uri.parse(''), headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('addTask', () {
    final taskModel =
        TaskModel(id: 28, todo: "Go to the gym", completed: false, userId: 15);

    final tasks = TaskModel.fromJson(json.decode(fixture('task.json')));

    test(
      'should perform a add task  ',
      () async {
        // arrange
        setUpMockHttpClientSuccess200Post('todos/add');
        // act
        dataSource.addNewTask(AddTaskParams(
            body: AddTaskParamsBody(
          completed: taskModel.completed,
          todo: taskModel.todo,
          userId: taskModel.userId,
        )));
        // assert
        verify(mockHttpClient.get(
          Uri.parse(BaseUrl + 'todos'),
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      ' should perform a add task (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200Post('todos/add');
        // act
        final result = await dataSource.addNewTask(AddTaskParams(
            body: AddTaskParamsBody(
          completed: tasks.completed,
          todo: tasks.todo,
          userId: tasks.userId,
        )));
        // assert
        expect(result, equals(tasks));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404Post();
        // act
        final call = dataSource.addNewTask(AddTaskParams(
            body: AddTaskParamsBody(
          completed: tasks.completed,
          todo: tasks.todo,
          userId: tasks.userId,
        )));
        // assert
        // expect(() => call , throwsA(isA<ServerException>()));
      },
    );
  });
  group('UpdateTask', () {
    final taskModel =
        TaskModel(id: 28, todo: "Go to the gym", completed: true, userId: 15);
    final tasks = TaskModel.fromJson(json.decode(fixture('task.json')));

    test(
      'should perform a update task  ',
      () async {
        // arrange
        setUpMockHttpClientSuccess200PUT('todos/${taskModel.id}');
        // act
        TaskModel taskModelRes = await dataSource.updateTask(UpdateTaskParams(
            body: UpdateTaskParamsBody(
          taskId: taskModel.id ?? 0,
          completed: true,
        )));
        // assert
        expect(taskModelRes, equals(taskModel));
      },
    );

    test(
      ' should perform a add task (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200PUT('todos/${taskModel.id}');
        // act
        final result = await dataSource.updateTask(UpdateTaskParams(
            body: UpdateTaskParamsBody(
          taskId: taskModel.id ?? 0,
          completed: true,
        )));
        // assert
        expect(result, equals(tasks));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404PUT();
        // act
        final call = dataSource.updateTask(UpdateTaskParams(
            body: UpdateTaskParamsBody(
          taskId: taskModel.id ?? 0,
          completed: true,
        )));
        // assert
        expect(() => call, throwsA(isA<AppException>()));
      },
    );
  });

  group('DeleteTask', () {
    final taskModel =
        TaskModel(id: 28, todo: "Go to the gym", completed: true, userId: 15);
    final tasks = TaskModel.fromJson(json.decode(fixture('task.json')));

    test(
      'should perform a delete task  ',
      () async {
        // arrange
        setUpMockHttpClientSuccess200Delete('todos/${taskModel.id}');
        // act
        TaskModel taskModelRes = await dataSource.deleteTask(DeleteTaskParams(
            body: DeleteTaskParamsBody(
          id: taskModel.id ?? 0,
        )));
        // assert
        expect(taskModelRes, equals(taskModel));
      },
    );

    test(
      ' should perform a add task (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200Delete('todos/${taskModel.id}');
        // act
        final result = await dataSource.deleteTask(DeleteTaskParams(
            body: DeleteTaskParamsBody(
          id: taskModel.id ?? 0,
        )));
        // assert
        expect(result, equals(tasks));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404delete();
        // act
        final call = dataSource.deleteTask(DeleteTaskParams(
            body: DeleteTaskParamsBody(
          id: taskModel.id ?? 0,
        )));
        // assert
        expect(() => call, throwsA(isA<AppException>()));
      },
    );
  });
  group('GetAllTask', () {
    final tasks = GetAllTaskModel.fromJson(json.decode(fixture('tasks.json')));
    int limit = 10;
    int skip = 10;

    test(
      'should perform a get task limit 10 skip 10   ',
      () async {
        // arrange
        setUpMockHttpClientSuccess200('todos?limit=${limit}&skip=${skip}');
        // act
        GetAllTaskModel tasksModelRes =
            await dataSource.getAllTask(GetAllTaskParams(
                body: GetAllTaskParamsBody(
          limit: limit,
          skip: skip,
        )));
        // assert
        expect(tasksModelRes, equals(tasks));
      },
    );
// nest page
    skip = 20;
    test(
      ' should perform a add task (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200('todos?limit=${limit}&skip=${skip}');
        // act
        GetAllTaskModel tasksModelRes =
            await dataSource.getAllTask(GetAllTaskParams(
                body: GetAllTaskParamsBody(
          limit: limit,
          skip: skip,
        )));
        // assert
        expect(tasksModelRes, equals(tasks));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getAllTask(GetAllTaskParams(
            body: GetAllTaskParamsBody(
          limit: limit,
          skip: skip,
        )));
        // assert
        expect(() => call, throwsA(isA<AppException>()));
      },
    );
  });
}
