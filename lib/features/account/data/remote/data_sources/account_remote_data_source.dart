import 'package:hive/hive.dart';

import '../../../../../core/data_sources/remote_data_source.dart';
import '../models/params/login_params.dart';
import '../models/responses/login_model.dart';

abstract class IAccountRemoteDataSource extends RemoteDataSource {
  Future<LogInModel> logIn(LogInParams model);
}

class AccountRemoteDataSource extends IAccountRemoteDataSource {
  final HiveInterface? hiveInterface;

  AccountRemoteDataSource(this.hiveInterface);

  @override
  Future<LogInModel> logIn(LogInParams params) async {
    var res;

    res = await this.post(params, withToken: false);
    return Future.value(LogInModel.fromJson(res));
  }
}
