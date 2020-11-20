import 'package:get_it/get_it.dart';
import 'package:mobilitem2miage/core/services/AuthService.dart';
import 'package:mobilitem2miage/core/services/LocationService.dart';
import 'package:mobilitem2miage/core/services/MapService.dart';
import 'package:mobilitem2miage/core/services/PlaceService.dart';
import 'package:mobilitem2miage/core/services/RemoveBgService.dart';
import 'package:mobilitem2miage/core/services/dao/PointOfInterestDao.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';
import 'package:mobilitem2miage/core/services/state/AppState.dart';
import 'package:mobilitem2miage/core/viewmodels/AccountModel.dart';
import 'package:mobilitem2miage/core/viewmodels/HomeModel.dart';
import 'package:mobilitem2miage/core/viewmodels/MapModel.dart';
import 'package:mobilitem2miage/core/viewmodels/LoginModel.dart';
import 'package:mobilitem2miage/core/viewmodels/PlaceDetailsModel.dart';
import 'package:mobilitem2miage/core/viewmodels/PlaceModel.dart';
import 'package:mobilitem2miage/core/viewmodels/SearchUsersModel.dart';
import 'package:mobilitem2miage/core/viewmodels/SignUpModel.dart';
import 'package:mobilitem2miage/core/viewmodels/UserProfilModel.dart';
import 'package:mobilitem2miage/core/viewmodels/widgets/WTextFieldModel.dart';

GetIt locator = GetIt();

void setupLocator() {

  /// Services
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => PlaceService());
  locator.registerLazySingleton(() => MapService());
  locator.registerLazySingleton(() => RemoveBgService());

  /// Dao
  locator.registerLazySingleton(() => PointOfInterestDao());
  locator.registerLazySingleton(() => UserDao());

  /// Model
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => SignUpModel());
  locator.registerFactory(() => AccountModel());
  locator.registerFactory(() => MapModel());
  locator.registerFactory(() => PlaceModel());
  locator.registerFactory(() => PlaceDetailsModel());
  locator.registerFactory(() => SearchUsersModel());
  locator.registerFactory(() => UserProfilModel());

  /// State
  locator.registerLazySingleton(() => AppState());

  /// Widget
  locator.registerFactory(() => WTextFieldModel());
}