import 'dart:convert';

import "package:flutter_test/flutter_test.dart";
import 'package:todoapp/features/task/data/models/get_all_task_model.dart';
import 'package:todoapp/features/task/data/models/task_model.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  final GetAllTaskModel tasksModel = GetAllTaskModel(
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
          id: 91, completed: false, userId: 15, todo: "Prepare a 72-hour kit"),
      TaskModel(
          id: 126, completed: false, userId: 15, todo: "Take a bubble bath"),
      TaskModel(
          id: 128,
          completed: false,
          userId: 15,
          todo: "Paint the first thing I see"),
    ],
  );

  test(
    'should be a subclass  ',
    () async {
      // assert
      expect(tasksModel, isA<GetAllTaskModel>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model ',
      () async {
        //arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('tasks.json'));
        //act
        final result = GetAllTaskModel.fromJson(jsonMap);

        // assert
        expect(result, tasksModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        //act
        final result = tasksModel.toJson();

        // assert
        final expectedJsonMap = {
          "todos": [
            {
              "id": 28,
              "todo": "Go to the gym",
              "completed": false,
              "userId": 15
            },
            {
              "id": 30,
              "todo": "Take cat on a walk",
              "completed": false,
              "userId": 15
            },
            {"id": 42, "todo": "Wash car", "completed": false, "userId": 15},
            {
              "id": 56,
              "todo": "Go on a fishing trip with some friends",
              "completed": false,
              "userId": 15
            },
            {
              "id": 91,
              "todo": "Prepare a 72-hour kit",
              "completed": true,
              "userId": 15
            },
            {
              "id": 126,
              "todo": "Take a bubble bath",
              "completed": true,
              "userId": 15
            },
            {
              "id": 128,
              "todo": "Paint the first thing I see",
              "completed": false,
              "userId": 15
            }
          ],
          "total": 7,
          "skip": 0,
          "limit": 7
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
