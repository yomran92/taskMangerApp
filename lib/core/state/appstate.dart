import 'package:flutter/material.dart';
import 'package:todoapp/core/utils/hive_keys.dart';

import '../../features/account/data/remote/models/responses/user_model.dart';
import '../../service_locator.dart';
import '../utils/hive_paramter.dart';

class AppStateModel with ChangeNotifier {

  UserModel? _user;


  AppStateModel() {
   }


  UserModel? get user => _user;


  void setUser(UserModel? user) {
    _user = user;
  }


  Future<void> saveLogin(String ID, String email, String phone, String name,
      String password) async {

    notifyListeners();
  }


  Future<void> logOut() async {
    sl<HiveParamter>().hive.box(HiveKeys.userBox).clear();
    sl<HiveParamter>().hive.box(HiveKeys.taskBox).clear();


    notifyListeners();
  }

}
