import 'dart:convert';

import "package:flutter_test/flutter_test.dart";
import 'package:todoapp/features/account/data/remote/models/responses/login_model.dart';
import 'package:todoapp/features/account/data/remote/models/responses/user_model.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  final loginModel = LogInModel(
      userModel: UserModel(
          id: 15,
          username: "kminchelle",
          email: "kminchelle@qq.com",
          firstName: "Jeanne",
          lastName: "Halvorson",
          gender: "female",
          image: "https://robohash.org/Jeanne.png?set=set4",
          token:
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoia21pbmNoZWxsZSIsImVtYWlsIjoia21pbmNoZWxsZUBxcS5jb20iLCJmaXJzdE5hbWUiOiJKZWFubmUiLCJsYXN0TmFtZSI6IkhhbHZvcnNvbiIsImdlbmRlciI6ImZlbWFsZSIsImltYWdlIjoiaHR0cHM6Ly9yb2JvaGFzaC5vcmcvSmVhbm5lLnBuZz9zZXQ9c2V0NCIsImlhdCI6MTcxNjAzNjU5NCwiZXhwIjoxNzE3MTQ3Nzk0fQ.lpyKvi2oKsl3khnS91I_9SoZnh2ly67Bne7wXmzOdz4"));

  test(
    'should be a subclass of user model',
    () async {
      // assert
      expect(loginModel, isA<LogInModel>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model  ',
      () async {
        //arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('user.json'));
        //act
        final result = UserModel.fromJson(jsonMap);

        // assert
        expect(loginModel, LogInModel(userModel: result));
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        //act
        final result = loginModel.toJson();

        // assert
        final expectedJsonMap = {
          "id": 15,
          "username": "kminchelle",
          "email": "kminchelle@qq.com",
          "firstName": "Jeanne",
          "lastName": "Halvorson",
          "gender": "female",
          "image": "https://robohash.org/Jeanne.png?set=set4",
          "token":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoia21pbmNoZWxsZSIsImVtYWlsIjoia21pbmNoZWxsZUBxcS5jb20iLCJmaXJzdE5hbWUiOiJKZWFubmUiLCJsYXN0TmFtZSI6IkhhbHZvcnNvbiIsImdlbmRlciI6ImZlbWFsZSIsImltYWdlIjoiaHR0cHM6Ly9yb2JvaGFzaC5vcmcvSmVhbm5lLnBuZz9zZXQ9c2V0NCIsImlhdCI6MTcxNjAzNjU5NCwiZXhwIjoxNzE3MTQ3Nzk0fQ.lpyKvi2oKsl3khnS91I_9SoZnh2ly67Bne7wXmzOdz4"
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
