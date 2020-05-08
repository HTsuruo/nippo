import 'package:firebase_auth/firebase_auth.dart';
import 'package:nippo/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;

  User _getUserData(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    print('sign in [ ${user.email} ], [ ${user.displayName} ]');
    return User(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoUrl,
      lastSignInTime: user.metadata.lastSignInTime.toString(),
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

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    print('signout success.');
  }
}