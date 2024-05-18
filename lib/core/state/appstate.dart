import 'package:flutter/material.dart';
import 'package:todoapp/core/utils/hive_keys.dart';
import '../../service_locator.dart';
import '../utils/hive_paramter.dart';

class AppStateModel with ChangeNotifier {

  AppStateModel() {}




  Future<void> logOut() async {
    sl<HiveParamter>().hive.box(HiveKeys.userBox).clear();
    sl<HiveParamter>().hive.box(HiveKeys.taskBox).clear();

    notifyListeners();
  }
}
