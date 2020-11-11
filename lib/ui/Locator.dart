import 'package:get_it/get_it.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';
import 'package:mobilitem2miage/core/services/LocationService.dart';
import 'package:mobilitem2miage/core/services/MapService.dart';
import 'package:mobilitem2miage/core/services/PlaceService.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';
import 'package:mobilitem2miage/core/viewmodels/HomeModel.dart';
import 'package:mobilitem2miage/core/viewmodels/LoginModel.dart';

GetIt locator = GetIt();

void setupLocator() {

  /// Services
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => PlaceService());
  locator.registerLazySingleton(() => MapService());

  /// Dao
  locator.registerLazySingleton(() => UserDao());

  /// Model
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => HomeModel());
}