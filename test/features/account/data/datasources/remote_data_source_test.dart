import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:todoapp/core/constants.dart';
import 'package:todoapp/core/error/app_exceptions.dart';
import 'package:todoapp/features/account/data/remote/data_sources/account_remote_data_source.dart';
import 'package:todoapp/features/account/data/remote/models/params/login_params.dart';
import 'package:todoapp/features/account/data/remote/models/responses/user_model.dart';import '../../../../fixtures/fixture.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late AccountRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;
  late HiveInterface? hiveInterface = Hive;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = AccountRemoteDataSource(hiveInterface);
  });

  void setUpMockHttpClientSuccess200(String endPoint) {
    when(mockHttpClient.post(Uri.parse(BaseUrl + endPoint), headers: {
      'Content-Type': 'application/json',
    })).thenAnswer((_) async => http.Response(fixture('user.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.post(Uri.parse(''),

            // any,
            headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('login', () {
    final user = UserModel(
        id: 15,
        username: "kminchelle",
        email: "kminchelle@qq.com",
        token:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoia21pbmNoZWxsZSIsImVtYWlsIjoia21pbmNoZWxsZUBxcS5jb20iLCJmaXJzdE5hbWUiOiJKZWFubmUiLCJsYXN0TmFtZSI6IkhhbHZvcnNvbiIsImdlbmRlciI6ImZlbWFsZSIsImltYWdlIjoiaHR0cHM6Ly9yb2JvaGFzaC5vcmcvSmVhbm5lLnBuZz9zZXQ9c2V0NCIsImlhdCI6MTcxNjAzNjU5NCwiZXhwIjoxNzE3MTQ3Nzk0fQ.lpyKvi2oKsl3khnS91I_9SoZnh2ly67Bne7wXmzOdz4',
        firstName: 'Jeanne',
        gender: 'female',
        image: "https://robohash.org/Jeanne.png?set=set4",
        lastName: ' "Halvorson"');

    test(
      'should return login when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200('auth/login');
        // act
        final result = dataSource.logIn(LogInParams(
            body:
                LogInParamsBody(username: "kminchelle", password: '0lelplR')));

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
        final call = dataSource.logIn(
            LogInParams(body: LogInParamsBody(username: '', password: '')));
        ;
        // assert
        expect(() => call, throwsA(isA<AppException>()));
      },
    );
  });
}
