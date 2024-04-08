import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/iaccount_repository.dart';
import '../remote/data_sources/account_remote_data_source.dart';
import '../remote/models/params/login_params.dart';
import '../remote/models/responses/login_model.dart';

class AccountRepository implements IAccountRepository {
  AccountRemoteDataSource remoteDataSource;

  AccountRepository(this.remoteDataSource);

  @override
  Future<Either<Failure, LogInEntity>> logIn(LogInParams model) async {
    try {
      final LogInModel remote = await remoteDataSource.logIn(model);
      return Right(remote.toEntity());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
