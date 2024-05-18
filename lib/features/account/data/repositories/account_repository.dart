import 'package:dartz/dartz.dart';

import '../../../../core/error/app_exceptions.dart';
import '../../../../core/error/error_entity.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/iaccount_repository.dart';
import '../remote/data_sources/account_remote_data_source.dart';
import '../remote/models/params/login_params.dart';
import '../remote/models/responses/login_model.dart';

class AccountRepository implements IAccountRepository {
  AccountRemoteDataSource remoteDataSource;

  AccountRepository(this.remoteDataSource);

  @override
  Future<Either<ErrorEntity, LogInEntity>> logIn(LogInParams model) async {
    try {
      final LogInModel remote = await remoteDataSource.logIn(model);
      return Right(remote.toEntity());
    } on AppException catch (e) {
      print(e);
      return Left(ErrorEntity.fromException(e));
    } catch (e) {
      print(e);
      return Left(ErrorEntity(e.toString()));
    }
  }
}
