import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/core/data_sources/remote_data_source.dart';

import 'package:todoapp/core/error/exceptions.dart';
import 'package:todoapp/core/error/failures.dart';
import 'package:todoapp/core/utils/network_info.dart';
import 'package:todoapp/features/account/data/remote/data_sources/account_remote_data_source.dart';
import 'package:todoapp/features/account/data/remote/models/params/login_params.dart';
import 'package:todoapp/features/account/data/remote/models/responses/login_model.dart';
import 'package:todoapp/features/account/data/remote/models/responses/user_model.dart';
import 'package:todoapp/features/account/data/repositories/account_repository.dart';

class MockRemoteDataSource extends Mock
    implements AccountRemoteDataSource {}


class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
 late AccountRepository  repository;
 late MockRemoteDataSource mockRemoteDataSource;
  late  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
     mockRemoteDataSource = MockRemoteDataSource();
    repository = AccountRepository(

         mockRemoteDataSource
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

  // void runTestOffline(Function body) {
  //   group('device is online', () {
  //     setUp(() {
  //       when(mockNetworkInfo.initialize()).thenAnswer((_) async => false);
  //     });
  //     body();
  //   });
  // }

  group('add concrete number trivia', () {
    final UserModel userModel = UserModel(id: '1', email: "Email test", password:  "password test", token: "Token test");


    test(
      'should check if the device is online',
      () async {
        //arrange
        when(mockNetworkInfo.initialize()).thenAnswer((_) async => true);
        //act
        repository.logIn(
            LogInParams(body: LogInParamsBody(email: userModel.password,password: userModel.password)));
        // assert
        verify(mockNetworkInfo.initialize());
      },
    );

    runTestOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          //arrange
          when(mockRemoteDataSource.logIn(
              LogInParams(body:
              LogInParamsBody(email: userModel.password,password: userModel.password))))
              .thenAnswer((_) async =>
              LogInModel(userModel: userModel, success: true));
          //acts
          final result = await repository.logIn(
              LogInParams(body:
              LogInParamsBody(email: userModel.password,password: userModel.password))
          );

          // assert
          verify(mockRemoteDataSource.logIn(
          LogInParams(body:
          LogInParamsBody(email:
          userModel.password,password: userModel.password))
          )
          );
          expect(result, equals(Right(userModel)));
        },
      );



      test(
        'should return serverFailure when the call to remote data source is unsuccessful',
        () async {
          //arrange
          when(mockRemoteDataSource.logIn(LogInParams(body:
          LogInParamsBody(email: userModel.password,password: ''))))
              .thenThrow(ServerException());
          //acts
          final result = await repository.logIn(LogInParams(body:
          LogInParamsBody(email: userModel.password,password: '')));

          // assert
          verify(mockRemoteDataSource.logIn(LogInParams(body:
          LogInParamsBody(email: userModel.password,password: ''))));
          expect(result, equals(Left(ServerFailure())));
          verifyNoMoreInteractions(mockRemoteDataSource);
        },
      );
    });

   });

 }
