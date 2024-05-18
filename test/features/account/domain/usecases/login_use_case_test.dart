import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/account/data/remote/models/params/login_params.dart';
import 'package:todoapp/features/account/data/remote/models/responses/user_model.dart';
import 'package:todoapp/features/account/data/repositories/account_repository.dart';
import 'package:todoapp/features/account/domain/entities/login_entity.dart';
import 'package:todoapp/features/account/domain/use_cases/login_use_case.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  late LogInUseCase usecase;
  late MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    usecase = LogInUseCase(mockAccountRepository);
  });
  final userModel = UserModel(
      id: 15,
      username: "kminchelle",
      email: "kminchelle@qq.com",
      token:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoia21pbmNoZWxsZSIsImVtYWlsIjoia21pbmNoZWxsZUBxcS5jb20iLCJmaXJzdE5hbWUiOiJKZWFubmUiLCJsYXN0TmFtZSI6IkhhbHZvcnNvbiIsImdlbmRlciI6ImZlbWFsZSIsImltYWdlIjoiaHR0cHM6Ly9yb2JvaGFzaC5vcmcvSmVhbm5lLnBuZz9zZXQ9c2V0NCIsImlhdCI6MTcxNjAzNjU5NCwiZXhwIjoxNzE3MTQ3Nzk0fQ.lpyKvi2oKsl3khnS91I_9SoZnh2ly67Bne7wXmzOdz4',
      firstName: 'Jeanne',
      gender: 'female',
      image: "https://robohash.org/Jeanne.png?set=set4",
      lastName: ' "Halvorson"');

  final loginEntity = LogInEntity(userModel: userModel);

  test(
    'should login  ',
    () async {
      when(mockAccountRepository.logIn(LogInParams(
              body: LogInParamsBody(
                  username: userModel.username, password: '0lelplR'))))
          .thenAnswer((_) async => Right(loginEntity));
      final result = await usecase(LogInParams(
          body: LogInParamsBody(
              username: userModel.username, password: '0lelplR')));
      expect(result, Right(loginEntity));
      verify(mockAccountRepository.logIn(LogInParams(
          body: LogInParamsBody(
              username: userModel.username, password: '0lelplR'))));
      verifyNoMoreInteractions(mockAccountRepository);
    },
  );
}
