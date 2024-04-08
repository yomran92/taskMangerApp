import 'dart:io';

 import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:todoapp/core/state/appstate.dart';
 import 'package:todoapp/core/utils/hive_paramter.dart';
import 'package:todoapp/features/account/data/remote/data_sources/account_remote_data_source.dart';
import 'package:todoapp/features/account/data/remote/models/responses/user_model.dart';
import 'package:todoapp/features/account/data/repositories/account_repository.dart';

import 'core/utils/network_info.dart';
import 'features/account/domain/use_cases/login_use_case.dart';
import 'features/account/presentation/blocs/account_bloc.dart';
import 'features/task/data/data_sources/remote/remote_data_source.dart';
import 'features/task/data/models/get_all_task_model.dart';
import 'features/task/data/models/task_model.dart';
import 'features/task/data/repositories/default_task_repository.dart';
import 'features/task/domain/repositories/task_repository.dart';
import 'features/task/domain/usecases/add_new_task_usecase.dart';
import 'features/task/domain/usecases/delete_task_usecase.dart';
import 'features/task/domain/usecases/get_all_task_usecase.dart';
import 'features/task/domain/usecases/update_task_usecase.dart';
import 'features/task/presentation/bloc/task_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();

  // DB
  sl.registerLazySingleton<HiveInterface>(() {
    final HiveInterface hive = Hive;

    hive.init(directory.path);
    hive.registerAdapter<GetAllTaskModel>(GetAllTaskModelAdapter());
    hive.registerAdapter<TaskModel>(TaskModelAdapter());
    hive.registerAdapter<UserModel>(UserModelAdapter());

    return hive;
  });

  sl.registerFactory(
      () => HiveParamter(path: directory.path, hive: sl()));
  sl.registerLazySingleton(() => TaskBloc());
  sl.registerLazySingleton(() => AccountBloc());

  sl.registerLazySingleton(() => NetworkInfo());
  sl.registerLazySingleton(() => AppStateModel());

  // Data sources
   sl.registerLazySingleton(
      () => TaskRemoteDataSource(sl(),));
  sl.registerLazySingleton(
      () => AccountRemoteDataSource(sl()));

  // Repositories
  sl.registerLazySingleton<TaskRepository>(
      () => DefaultTaskRepository(sl()));
  sl.registerLazySingleton(
      () => AccountRepository(sl()));

  // Usecases
  sl.registerLazySingleton(() => UpdateTaskUsecase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUsecase(sl()));
  sl.registerLazySingleton(() => AddNewTaskUsecase(sl()));
  sl.registerLazySingleton(() => GetAllTaskUsecase(sl()));
  sl.registerLazySingleton(() => LogInUseCase(sl()));



}
