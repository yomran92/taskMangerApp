import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/remote/models/params/login_params.dart';
import '../entities/login_entity.dart';

abstract class IAccountRepository {
  Future<Either<Failure, LogInEntity>> logIn(LogInParams model);
}
