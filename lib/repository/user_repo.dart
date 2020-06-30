import 'package:naptin/locator.dart';
import 'package:naptin/model/userModel.dart';
import 'package:naptin/services/auth_base.dart';
import 'package:naptin/services/fake_auth_service.dart';
import 'package:naptin/services/firebase_auth_services.dart';

enum AppMode{DEBUG,RELEASE}

class UserRepository implements AuthBase {
  FireBaseAuthService _firebaseauthservice =locator<FireBaseAuthService>();
  FakeAuthService _fakeAuthService=locator<FakeAuthService>();
  AppMode appMode=AppMode.RELEASE; // farklı bir yapı kullanılacağı zaman burada tanımlanıp o yapıya geçilebilir
  @override
  Future<User> currentUser() async {

    if (appMode==AppMode.DEBUG) { 
     return await _fakeAuthService.currentUser(); // fake datadakicurrent user
    }
     else return await _firebaseauthservice.currentUser();//firabasedeki current user
  }

  @override
  Future<User> singInAnonymously() async {
    if (appMode==AppMode.DEBUG) { 
     return await _fakeAuthService.singInAnonymously();
    }
     else return await _firebaseauthservice.singInAnonymously();
    
  }

  @override
  Future<bool> singOut() async {
    if (appMode==AppMode.DEBUG) {
      return await _fakeAuthService.singOut();
    }
    else return await _firebaseauthservice.singOut();

  }

  @override
  Future<User> singInWithGoogle() async {
    if (appMode==AppMode.DEBUG) { 
     return await _fakeAuthService.singInWithGoogle();
    }
     else return await _firebaseauthservice.singInWithGoogle();
  }

  @override
  Future<User> singInWithFacebook() async{
    if (appMode==AppMode.DEBUG) { 
     return await _fakeAuthService.singInWithFacebook();
    }
     else return await _firebaseauthservice.singInWithFacebook();
  }

  @override
  Future<User> createUserWithEmail(String email, String password) async {
    if (appMode==AppMode.DEBUG) { 
     return await _fakeAuthService.createUserWithEmail(email,password);
    }
     else return await _firebaseauthservice.createUserWithEmail(email,password);
  }

  @override
  Future<User> singInWithEmail(String email, String password) async {
    if (appMode==AppMode.DEBUG) { 
     return await _fakeAuthService.singInWithEmail(email,password);
    }
     else return await _firebaseauthservice.singInWithEmail(email,password);
  } 
}