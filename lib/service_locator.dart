import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:todoapp/core/state/appstate.dart';
import 'package:todoapp/core/utils/hive_paramter.dart';

import 'core/utils/network_info.dart';


final sl = GetIt.instance;

Future<void> init() async {
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();

  // DB
  sl.registerLazySingleton<HiveInterface>(() {
    final HiveInterface hive = Hive;

    hive.init(directory.path);


    return hive;
  });

  sl.registerFactory(() => HiveParamter(path: directory.path, hive: sl()));


  sl.registerLazySingleton(() => NetworkInfo());
  sl.registerLazySingleton(() => AppStateModel());


}
