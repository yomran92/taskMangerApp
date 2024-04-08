
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/account/data/remote/models/params/login_params.dart';
import 'package:todoapp/features/account/data/remote/models/responses/user_model.dart';
import 'package:todoapp/features/account/data/repositories/account_repository.dart';
import 'package:todoapp/features/account/domain/entities/login_entity.dart';
import 'package:todoapp/features/account/domain/use_cases/login_use_case.dart';

class MockAccountRepository extends Mock
    implements AccountRepository {}

void main() {
  late LogInUseCase  usecase;
  late MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    usecase = LogInUseCase(mockAccountRepository);
  });
  final userModel = UserModel(id: '1', email: "Email test", password:  "password test", token: "Token test");

   final loginEntity =  LogInEntity(userModel:userModel );

  test(
    'should login  ',
        () async {

      when(mockAccountRepository.logIn(
          LogInParams(body: LogInParamsBody(email: userModel.email,password: userModel.password))))
          .thenAnswer((_) async => Right(loginEntity));
       final result = await usecase(LogInParams(body: LogInParamsBody(email: userModel.email,password: userModel.password)));
       expect(result, Right(loginEntity));
       verify(mockAccountRepository.logIn(LogInParams(body: LogInParamsBody(email: userModel.email,password: userModel.password))));
       verifyNoMoreInteractions(mockAccountRepository);
    },
  );
}

