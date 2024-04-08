import 'dart:convert';

import "package:flutter_test/flutter_test.dart";
import 'package:todoapp/features/account/data/remote/models/responses/user_model.dart';

import '../../../../fixtures/fixture.dart';

void main() {
   final userModel = UserModel(id: '1', email: "Email test", password:  "password test", token: "Token test");

  test(
    'should be a subclass of user model',
    () async {
      // assert
      expect(userModel, isA<UserModel>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        //arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('user.json'));
        //act
        final result = UserModel.fromJson(jsonMap);

        // assert
        expect(result, userModel);
      },
    );

  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        //act
        final result = userModel.toJson();

        // assert
        final expectedJsonMap = {

          "email": "Email test",
          "password": "password test",
          "token": "Token test",
          "id": "1"
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
