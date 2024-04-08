import 'dart:convert';


import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
 import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;
import 'package:todoapp/core/constants.dart';
import 'package:todoapp/core/error/exceptions.dart';
import 'package:todoapp/features/account/data/remote/data_sources/account_remote_data_source.dart';
import 'package:todoapp/features/account/data/remote/models/params/login_params.dart';
import 'package:todoapp/features/account/data/remote/models/responses/user_model.dart';


import '../../../../fixtures/fixture.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
 late AccountRemoteDataSource dataSource;
 late  MockHttpClient mockHttpClient;
 late HiveInterface? hiveInterface=Hive;

  setUp(() {
    mockHttpClient = MockHttpClient();
     dataSource = AccountRemoteDataSource(hiveInterface);
  });

  void setUpMockHttpClientSuccess200(String endPoint) {
    when(mockHttpClient.post(
       Uri.parse(BaseUrl+endPoint),
        headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('user.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.post(
        Uri.parse(''),

        // any,
        headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('login', () {

    final user = UserModel(id: '1', email: "Email test", password:  "password test", token: "Token test");



    test(
      'should return login when the response code is 200 (success)',
          () async {
        // arrange
        setUpMockHttpClientSuccess200('/api/login');
        // act
        final result =
              dataSource.logIn(LogInParams(body: LogInParamsBody(email: user.email,password: user.password)));

         // assert
        expect(result, equals(user));
      },
    );

    test(
      'should throw a ServerException   404  ',
          () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call =
        dataSource.logIn(LogInParams(body: LogInParamsBody(email: user.email,password: user.password)));
        ;
        // assert
        expect(() => call , throwsA(isA<ServerException>()));
      },
    );
  });

 }


