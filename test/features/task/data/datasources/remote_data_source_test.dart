import 'dart:convert';


import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
 import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;
import 'package:todoapp/core/constants.dart';
import 'package:todoapp/core/error/exceptions.dart';
 import 'package:todoapp/features/task/data/data_sources/remote/remote_data_source.dart';
import 'package:todoapp/features/task/data/models/param/add_new_task_param.dart';
import 'package:todoapp/features/task/data/models/param/update_task_param.dart';
import 'package:todoapp/features/task/data/models/task_model.dart';


import '../../../../fixtures/fixture.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
 late TaskRemoteDataSource dataSource;
 late  MockHttpClient mockHttpClient;
 late HiveInterface? hiveInterface=Hive;

  setUp(() {
    mockHttpClient = MockHttpClient();
     dataSource = TaskRemoteDataSource(hiveInterface);
  });
 void setUpMockHttpClientSuccess200(String endPoint) {
   when(mockHttpClient.get(
       Uri.parse(BaseUrl+endPoint),
       headers: anyNamed('headers')))
       .thenAnswer((_) async => http.Response(fixture('task.json'), 200));
 }
void setUpMockHttpClientSuccess200Post(String endPoint) {
   when(mockHttpClient.post(
       Uri.parse(BaseUrl+endPoint),
       headers: anyNamed('headers')))
       .thenAnswer((_) async => http.Response(fixture('task.json'), 200));
 }
void setUpMockHttpClientSuccess200PUT(String endPoint) {
   when(mockHttpClient.put(
       Uri.parse(BaseUrl+endPoint),
       headers: anyNamed('headers')))
       .thenAnswer((_) async => http.Response(fixture('task.json'), 200));
 }
void setUpMockHttpClientSuccess200Delete(String endPoint) {
   when(mockHttpClient.put(
       Uri.parse(BaseUrl+endPoint),
       headers: anyNamed('headers')))
       .thenAnswer((_) async => http.Response(fixture('task.json'), 200));
 }


  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(
        Uri.parse(''),


        headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }
  void setUpMockHttpClientFailure404Post() {
    when(mockHttpClient.get(
        Uri.parse(''),


        headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }
  void setUpMockHttpClientFailure404PUT() {
    when(mockHttpClient.put(
        Uri.parse(''),


        headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }
  void setUpMockHttpClientFailure404delete() {
    when(mockHttpClient.put(
        Uri.parse(''),


        headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('addTask', () {
    final taskModel = TaskModel(id: '12', title: 't1', synced: false, content: 'c1');

    final tasks =
    TaskModel.fromJson(json.decode(fixture('task.json')));

    test(
       'should perform a add task  ',
          () async {
        // arrange
        setUpMockHttpClientSuccess200Post('/api/users');
        // act
        dataSource.addNewTask(AddTaskParams(body: AddTaskParamsBody(task: taskModel)));
        // assert
        verify(mockHttpClient.get(
           Uri.parse(BaseUrl+'/api/users'),
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
            setUpMockHttpClientSuccess200Post('/api/users');
        // act
        final result = await dataSource.addNewTask(AddTaskParams(body:
        AddTaskParamsBody(task:taskModel)));
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
        final call = dataSource.addNewTask(
            AddTaskParams(body: AddTaskParamsBody(task:taskModel)));
        // assert
        expect(() => call , throwsA(isA<ServerException>()));
      },
    );
  });
  group('UpdateTask', () {
    final taskModel = TaskModel(id: '12', title: 't1', synced: false, content: 'c1');

    final tasks =
    TaskModel.fromJson(json.decode(fixture('task.json')));

    test(
       'should perform a add task  ',
          () async {
        // arrange
        setUpMockHttpClientSuccess200PUT('/api/users');
        // act
        dataSource.updateTask(UpdateTaskParams( body: UpdateTaskParamsBody(task: taskModel)));
        // assert
        verify(mockHttpClient.get(
           Uri.parse(BaseUrl+'/api/users'),
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
            setUpMockHttpClientSuccess200PUT('/api/users');
        // act
        final result = await dataSource.updateTask(UpdateTaskParams(body:
        UpdateTaskParamsBody(task:taskModel)));
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
        final call = dataSource.updateTask(
            UpdateTaskParams(body: UpdateTaskParamsBody(task:taskModel)));
        // assert
        expect(() => call , throwsA(isA<ServerException>()));
      },
    );
  });

 }


