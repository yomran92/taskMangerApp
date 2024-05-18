import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/core/error/error_entity.dart';
import 'package:todoapp/core/utils/network_info.dart';
import 'package:todoapp/features/account/data/remote/data_sources/account_remote_data_source.dart';
import 'package:todoapp/features/account/data/remote/models/params/login_params.dart';
import 'package:todoapp/features/account/data/remote/models/responses/login_model.dart';
import 'package:todoapp/features/account/data/remote/models/responses/user_model.dart';
import 'package:todoapp/features/account/data/repositories/account_repository.dart';

class MockRemoteDataSource extends Mock implements AccountRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late AccountRepository repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockRemoteDataSource();
    repository = AccountRepository(mockRemoteDataSource);
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.initialize()).thenAnswer((_) async => true);
      });
      body();
    });
  }

  group('login', () {
    final UserModel userModel = UserModel(
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
      'should check if the device is online',
      () async {
        //arrange
        when(mockNetworkInfo.initialize()).thenAnswer((_) async => true);
        //act
        repository.logIn(LogInParams(
            body: LogInParamsBody(
                username: userModel.username, password: '0lelplR')));
        // assert
        verify(mockNetworkInfo.initialize());
      },
    );

    runTestOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          //arrange
          when(mockRemoteDataSource.logIn(LogInParams(
                  body: LogInParamsBody(
                      username: userModel.username, password: '0lelplR'))))
              .thenAnswer((_) async => LogInModel(
                    userModel: userModel,
                  ));
          //acts
          final result = await repository.logIn(LogInParams(
              body: LogInParamsBody(
                  username: userModel.username, password: '0lelplR')));

          // assert
          verify(mockRemoteDataSource.logIn(LogInParams(
              body: LogInParamsBody(
                  username: userModel.username, password: '0lelplR'))));
          expect(result, equals(Right(userModel)));
        },
      );

      test(
        'should return AppException when the call to remote data source is unsuccessful',
        () async {
          //arrange
          when(mockRemoteDataSource.logIn(LogInParams(
              body: LogInParamsBody(
                  username: userModel.username, password: ''))));
          // .thenThrow(ServerException());
          //acts
          final result = await repository.logIn(LogInParams(
              body:
                  LogInParamsBody(username: userModel.username, password: '')));

          // assert
          verify(mockRemoteDataSource.logIn(LogInParams(
              body: LogInParamsBody(
                  username: userModel.username, password: ''))));
          expect(result, equals(Left(ErrorEntity(''))));
          verifyNoMoreInteractions(mockRemoteDataSource);
        },
      );
    });
  });
}
