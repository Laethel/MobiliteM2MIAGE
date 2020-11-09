

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobilitem2miage/core/models/client/User.dart' as model;
import 'package:mobilitem2miage/core/models/server/Response.dart';
import 'package:mobilitem2miage/core/services/AnalyticsService.dart';
import 'package:mobilitem2miage/core/services/FireStoreService.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';

import 'dao/UserDao.dart';

class AuthService extends ChangeNotifier {

  static final AuthService _singleton = AuthService._internal();

  factory AuthService() {

    return _singleton;
  }

  AuthService._internal();

  AnalyticsService analytics = AnalyticsService();
  UserDao userDao = UserDao();

  GoogleSignInAccount _googleSignInAccount;
  FirebaseAuth _auth;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<Response> emailSignUp(model.User user, String password) async {

    /// Initialize FirebaseApp (Very important, else Firebase Auth didn't work)
    await Firebase.initializeApp();

    Response response;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.mail,
          password: password
      );

      AnalyticsService.analytics.logSignUp(signUpMethod: "EmailSignUp");

      response = Response(RESPONSE_TYPE.VALIDE, "User account well created.");
      response.isNewUser =  userCredential.additionalUserInfo.isNewUser;

      if (response.isNewUser) {
        userDao.add(user);
        print("Account created");
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        response = Response(RESPONSE_TYPE.ERROR, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        response = Response(RESPONSE_TYPE.ERROR, "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }

    return response;
  }

  Future<Response> emailSignIn(String email, String password) async {

    /// Initialize FirebaseApp (Very important, else Firebase Auth didn't work)
    await Firebase.initializeApp();

    this._auth = FirebaseAuth.instance;
    Response response;

    try {

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      AnalyticsService.analytics.logLogin(loginMethod: "EmailSignIn");
      response = Response(RESPONSE_TYPE.VALIDE, "User well authentificated.");

      if (response.isNewUser) {
        userDao.add(
            model.User(
                name: this.user.displayName.split(" ")[1],
                firstName: this.user.displayName.split(" ")[0],
                mail: this.user.email
            )
        );

        print("Account created");
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        response = Response(RESPONSE_TYPE.ERROR, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        response = Response(RESPONSE_TYPE.ERROR, "Wrong password provided for that user.");
      }
    }

    return response;
  }

  Future<Response> googleSignIn() async {

    /// Initialize FirebaseApp (Very important, else Firebase Auth didn't work)
    await Firebase.initializeApp();

    this._auth = FirebaseAuth.instance;
    Response response;

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {

      UserCredential userCredential = await this._auth.signInWithCredential(credential);

      AnalyticsService.analytics.logLogin(loginMethod: "GoogleSignIn");
      response = Response(RESPONSE_TYPE.VALIDE, "User well authentificated");

      if (response.isNewUser) {
        userDao.add(
            model.User(
                name: this.user.displayName.split(" ")[1],
                firstName: this.user.displayName.split(" ")[0],
                mail: this.user.email
            )
        );
      }

    } catch (error) {

      response = Response(RESPONSE_TYPE.ERROR, "Error with google connexion methode.");
    }

    return response;
  }

  void signOut() {

    _auth.signOut();
  }

  User get user {
    return this._auth.currentUser;
  }

  Future<bool> get isLogged async {

    bool res = false;

    await FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user != null) {
        res = true;
        print(res);
      }
    });

    print(res);
    return res;
  }
}