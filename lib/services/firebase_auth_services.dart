import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:naptin/model/userModel.dart';
import 'package:naptin/services/auth_base.dart';

class FireBaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> currentUser() async {
    try {
      FirebaseUser user = await _firebaseAuth.currentUser(); //firebase user
      return _userFromFirebase(user);
    } catch (e) {
      print("object" + e.toString());
      return null;
    }
  }

  User _userFromFirebase(FirebaseUser user) {
    // firebase user, kendi user türüme donuşturucek
    if (user == null) return null;
    return User(userID: user.uid);
  }

  @override
  Future<User> singInAnonymously() async {
    try {
      AuthResult sonuc = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(sonuc.user);
    } catch (e) {
      print("AnonimHata" + e.toString());
      return null;
    }
  }

  @override
  Future<bool> singOut() async {
    try {
      final _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();

      final _facebookLogin = FacebookLogin();
      await _facebookLogin.logOut();

      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("singouthHata" + e.toString());
      return false;
    }
  }

  @override
  Future<User> singInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        AuthResult sonuc = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.getCredential(
                idToken: _googleAuth.idToken,
                accessToken: _googleAuth.accessToken));
        FirebaseUser _user = sonuc.user;
        return _userFromFirebase(_user);
      } else
        return null;
    } else
      return null;
  }

  @override
  Future<User> singInWithFacebook() async {
    final _facebookLogin = FacebookLogin();
    FacebookLoginResult _facebookResult =
        await _facebookLogin.logIn(["public_profile", "email"]);
    switch (_facebookResult.status) {
      case FacebookLoginStatus.loggedIn:
        if (_facebookResult.accessToken != null &&
            _facebookResult.accessToken.isValid()) {
          AuthResult _firebaseResult = await _firebaseAuth.signInWithCredential(
              FacebookAuthProvider.getCredential(
                  accessToken: _facebookResult.accessToken.token));
          FirebaseUser _user = _firebaseResult.user;
          return _userFromFirebase(_user);
        } else {}
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("giriş iptal");
        break;
      case FacebookLoginStatus.error:
        print("hata" + _facebookResult.errorMessage);
        break;
    }
    return null;
  }

  @override
  Future<User> createUserWithEmail(String email, String password) async {
    try {
      AuthResult sonuc = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);

      return _userFromFirebase(sonuc.user);
    } catch (e) {
      print("Create Hata " + e.toString());
      return null;
    }
  }

  @override
  Future<User> singInWithEmail(String email, String password) async {
    try {
      AuthResult sonuc = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(), password: password);

      return _userFromFirebase(sonuc.user);
    } catch (e) {
      print("Sing In Hata " + e.toString());
      return null;
    }
  }
}
