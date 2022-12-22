import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:keyboard/application/consumer/dio_consumer.dart';
import 'package:keyboard/application/database/hive_database.dart';
import 'package:keyboard/application/database/sql_database.dart';
import 'package:keyboard/application/services/auth_service.dart';
import 'package:keyboard/application/services/prediction_service.dart';
import 'package:keyboard/application/services/user_service.dart';
import 'package:keyboard/core/abstracts/consumer.dart';
import 'package:keyboard/core/abstracts/local_database.dart';
import 'package:keyboard/core/repository/auth_repository.dart';
import 'package:keyboard/core/repository/prediction_repository.dart';
import 'package:keyboard/core/repository/users_repository.dart';

GetIt locator = GetIt.instance;

Future<void> setup() async {
  final Consumer consumer = DioConsumer();
  await consumer.init();

  final LocalDatabase  localDatabase = HiveDatabase();

  await localDatabase.init();

  final IUserRepository userRepository = UserService(consumer);
  final IPredictionRepository predictionRepository = PredictionService(consumer);
  final IAuthRepository authRepository = AuthService(localDatabase, userRepository);

  locator.registerLazySingleton<Consumer>(() => consumer);
  locator.registerLazySingleton<LocalDatabase>(() => localDatabase);
  locator.registerLazySingleton<IUserRepository>(() => userRepository);
  locator.registerLazySingleton<IPredictionRepository>(() => predictionRepository);
  locator.registerLazySingleton<IAuthRepository>(() => authRepository);
}
