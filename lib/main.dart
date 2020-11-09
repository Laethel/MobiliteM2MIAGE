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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<UserDao>()),
        ChangeNotifierProvider(create: (_) => locator<AuthService>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        navigatorObservers: <NavigatorObserver>[AnalyticsService.observer],
        onGenerateRoute: Router.generateRoute,
      )
    );
  }
}