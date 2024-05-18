import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../data/remote/models/params/login_params.dart';
import '../entities/login_entity.dart';

abstract class IAccountRepository {
  Future<Either<ErrorEntity, LogInEntity>> logIn(LogInParams model);
}
