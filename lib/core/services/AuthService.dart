import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobilitem2miage/core/models/client/User.dart' as model;
import 'package:mobilitem2miage/core/models/server/Response.dart';
import 'package:mobilitem2miage/core/services/AnalyticsService.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';

class AuthService extends ChangeNotifier {

  static final AuthService _singleton = AuthService._internal();

  factory AuthService() {

    return _singleton;
  }

  AuthService._internal();

  AnalyticsService analytics = AnalyticsService();
  UserDao userDao = UserDao();
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

      /// Attempt to create an new account
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.mail,
          password: password
      );

      userDao.add(user);

      /// Notify firebase of an account creation
      AnalyticsService.analytics.logSignUp(signUpMethod: "EmailSignUp");
      response = Response(RESPONSE_TYPE.VALIDE, "User account well created.");

      /// SignIn automatically after SignUp
      this.emailSignIn(user.mail, password);

    } on FirebaseAuthException catch (e) {

      /// Firebase Auth error response put in Response object
      /// ex. : "Password should be at least 6 characters"
      response = Response(RESPONSE_TYPE.ERROR, e.message);
    }

    return response;
  }

  Future<Response> emailSignIn(String email, String password) async {

    /// Initialize FirebaseApp (Very important, else Firebase Auth didn't work)
    await Firebase.initializeApp();

    this._auth = FirebaseAuth.instance;
    Response response;

    try {

      /// Attempt connexion with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      /// Notify firebase of an user connexion
      AnalyticsService.analytics.logLogin(loginMethod: "EmailSignIn");
      response = Response(RESPONSE_TYPE.VALIDE, "User well authentificated.");

    }  on FirebaseAuthException catch (e) {

      /// Firebase Auth error response put in Response object
      /// ex. : "No user found for that email"
      response = Response(RESPONSE_TYPE.ERROR, e.message);
    }

    return response;
  }

  Future<Response> googleSignIn() async {

    this._auth = FirebaseAuth.instance;
    Response response;

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {

      /// Attempt connexion by google
      UserCredential userCredential = await this._auth.signInWithCredential(credential);

      /// Notify firebase of an user connexion
      AnalyticsService.analytics.logLogin(loginMethod: "GoogleSignIn");
      response = Response(RESPONSE_TYPE.VALIDE, "User well authentificated");

      /// If is a new user, then we create a new User in firestore
      if (userCredential.additionalUserInfo.isNewUser) {
        userDao.add(
            model.User(
                name: this.user.displayName.split(" ")[1],
                firstName: this.user.displayName.split(" ")[0],
                mail: this.user.email
            )
        );
      }

    }  on FirebaseAuthException catch (e) {

      /// Firebase Auth error response put in Response object
      response = Response(RESPONSE_TYPE.ERROR, e.message);
    }

    return response;
  }

  void signOut() {

    _auth.signOut();
  }

  User get user {
    return this._auth.currentUser;
  }

  bool get isLogged {
    return this.user != null ? true : false;
  }
}