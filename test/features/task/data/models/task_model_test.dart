import 'dart:convert';

import "package:flutter_test/flutter_test.dart";
import 'package:todoapp/features/task/data/models/task_model.dart';

import '../../../../fixtures/fixture.dart';

void main() {
   final taskModel = TaskModel(id: '12', title: 't1', synced: false, content: 'c1');

  test(
    'should be a subclass  ',
    () async {
      // assert
      expect(taskModel, isA<TaskModel>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model ',
      () async {
        //arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('task.json'));
        //act
        final result = TaskModel.fromJson(jsonMap);

        // assert
        expect(result, taskModel);
      },
    );

  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        //act
        final result = taskModel.toJson();

        // assert
        final expectedJsonMap ={
          "id": "1",
          "title": "test title" ,
          "content": "test conten",
          "sync": true
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
