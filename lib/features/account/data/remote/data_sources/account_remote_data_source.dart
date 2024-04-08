import 'package:hive/hive.dart';
import 'package:todoapp/core/state/appstate.dart';
import 'package:todoapp/core/utils/helper_function.dart';
import 'package:todoapp/features/account/data/remote/models/responses/user_model.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/data_sources/remote_data_source.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/utils/hive_keys.dart';
import '../../../../../service_locator.dart';
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
    var responseJson;
    final userBox = await hiveInterface!.box(HiveKeys.userBox,
    );

UserModel user=new UserModel(password: params.body!.password,
    email:params.body!.password ,id:Uuid().v1()  ,token:Uuid().v1());
    await userBox.put( user.id,user);
    //save User
    sl<AppStateModel>().setUser(user);
    try {
      var res =  await this.post(params);

      if (res == null) throw FetchDataException();
      responseJson = HelperFunction().returnResponse(res);
      print('post response: $responseJson');
    } on Exception catch (e) {
      throw e;
    }

    return Future.value(LogInModel.fromJson(responseJson));
  }
}
