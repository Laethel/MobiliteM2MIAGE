import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobilitem2miage/core/services/AnalyticsService.dart';
import 'package:mobilitem2miage/core/services/LocationService.dart';
import 'package:mobilitem2miage/core/services/MapService.dart';
import 'package:mobilitem2miage/core/services/PlaceService.dart';
import 'package:mobilitem2miage/core/services/RemoveBgService.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';
import 'package:mobilitem2miage/core/services/state/AppState.dart';
import 'package:mobilitem2miage/ui/Locator.dart';
import 'package:mobilitem2miage/ui/Router.dart' as localRouter;
import 'package:provider/provider.dart';

import 'core/services/AuthService.dart';
import 'core/services/dao/PointOfInterestDao.dart';

final globalScaffoldKey = GlobalKey<ScaffoldState>();

void main() async {

  /// Allow to use main as async
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize Firebase App to use Firebase Services
  await Firebase.initializeApp();

  /// Initizalize Locator to use Services as depencies injection
  setupLocator();

  /// Gets the user's current location when opening the app
  LocationService locationService = LocationService();
  locationService.currentLocation = await locationService.getCurrentLocation();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final AnalyticsService analytics = AnalyticsService();

  @override
  Widget build(BuildContext context) {

    /// Notify firebase of the opening of the application
    analytics.eventAppOpen();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<PointOfInterestDao>()),
        ChangeNotifierProvider(create: (_) => locator<UserDao>()),
        ChangeNotifierProvider(create: (_) => locator<AuthService>()),
        ChangeNotifierProvider(create: (_) => locator<LocationService>()),
        ChangeNotifierProvider(create: (_) => locator<PlaceService>()),
        ChangeNotifierProvider(create: (_) => locator<MapService>()),
        ChangeNotifierProvider(create: (_) => locator<RemoveBgService>()),
        ChangeNotifierProvider(create: (_) => locator<AppState>())
      ],
      child: MaterialApp(
        key: globalScaffoldKey,
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        navigatorObservers: <NavigatorObserver>[AnalyticsService.observer],
        onGenerateRoute: localRouter.Router.generateRoute,
      )
    );
  }
}