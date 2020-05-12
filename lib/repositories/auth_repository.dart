import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:nippo/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nippo/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nippo/constant.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;

  User _getUserData(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    print('firebse user sign in [ ${user.email} ], [ ${user.displayName} ]');
    _setSharedPreference();
    return User(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoUrl,
      lastSignInTime:
          formatDateFromDateTime(datetime: user.metadata.lastSignInTime),
      providerData: _getProviderData(user),
    );
  }

  String _getProviderData(FirebaseUser user) {
    String providerId;
    for (final profile in user.providerData) {
      providerId = profile.providerId;
    }
    return providerId;
  }

  Future<void> _setSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Pref.IS_TUTORIAL_DONE, 1);
  }

  Future<bool> isLogin() async {
    final user = await currentUser();
    print('current user is [ ${user != null || false} ]');
    return user != null || false;
  }

  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _getUserData(user);
  }

  Future<User> signInWithGoogle() async {
    final _googleSignIn = GoogleSignIn();
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }
    final googleAuth = await googleUser.authentication;
    if (googleAuth.idToken == null || googleAuth.accessToken == null) {
      return null;
    }
    final result = await _firebaseAuth.signInWithCredential(
        GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken));
    return _getUserData(result.user);
  }

  Future<Map<String, Object>> signUpWithEmail(
      {@required String email, @required String password}) async {
    final map = <String, Object>{'user': null, 'result': false, 'message': ''};
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      map['user'] = _getUserData(result.user);
      map['result'] = true;
    } on PlatformException catch (e) {
      print(e);
      map['message'] = e.toString();
    }
    return map;
  }

  Future<Map<String, Object>> signInWithEmail(
      {@required String email, @required String password}) async {
    final map = <String, Object>{'user': null, 'result': false, 'message': ''};
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      map['user'] = _getUserData(result.user);
      map['result'] = true;
    } on PlatformException catch (e) {
      print(e);
      map['message'] = e.toString();
    }
    return map;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    print('signout success.');
  }
}
