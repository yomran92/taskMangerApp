import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:todoapp/core/state/appstate.dart';
import 'package:todoapp/core/utils/hive_paramter.dart';

import 'core/utils/network_info.dart';
import 'features/account/data/remote/data_sources/account_remote_data_source.dart';
import 'features/account/data/remote/models/responses/user_model.dart';
import 'features/account/data/repositories/account_repository.dart';
import 'features/account/domain/use_cases/login_use_case.dart';
import 'features/account/presentation/blocs/account_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();

  // DB
  sl.registerLazySingleton<HiveInterface>(() {
    final HiveInterface hive = Hive;

    hive.init(directory.path);

    hive.registerAdapter<UserModel>(UserModelAdapter());

    return hive;
  });

  sl.registerFactory(() => HiveParamter(path: directory.path, hive: sl()));
  sl.registerLazySingleton(() => AccountBloc());

  sl.registerLazySingleton(() => NetworkInfo());
  sl.registerLazySingleton(() => AppStateModel());

  // Data sources

  sl.registerLazySingleton(() => AccountRemoteDataSource(sl()));

  // Repositories
  sl.registerLazySingleton(() => AccountRepository(sl()));

  // Usecases

  sl.registerLazySingleton(() => LogInUseCase(sl()));
}
