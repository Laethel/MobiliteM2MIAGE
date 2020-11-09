import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobilitem2miage/core/services/AnalyticsService.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';
import 'package:mobilitem2miage/ui/Locator.dart';
import 'package:mobilitem2miage/ui/Router.dart';
import 'package:provider/provider.dart';

import 'core/services/AuthService.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  setupLocator();
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
        ChangeNotifierProvider(create: (_) => locator<UserDao>()),
        ChangeNotifierProvider(create: (_) => locator<AuthService>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        navigatorObservers: <NavigatorObserver>[AnalyticsService.observer],
        onGenerateRoute: Router.generateRoute,
      )
    );
  }
}