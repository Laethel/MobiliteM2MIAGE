import 'package:get_it/get_it.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';
import 'package:mobilitem2miage/core/viewmodels/LoginModel.dart';

GetIt locator = GetIt();

void setupLocator() {

  /// Services
  locator.registerLazySingleton(() => AuthService());

  /// Dao
  locator.registerLazySingleton(() => UserDao());

  /// Model
  locator.registerFactory(() => LoginModel());
}