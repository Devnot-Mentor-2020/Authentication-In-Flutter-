import 'package:flutter/cupertino.dart';
import 'package:naptin/locator.dart';
import 'package:naptin/model/user.dart';
import 'package:naptin/services/auth_base.dart';
import 'package:naptin/services/fake_auth_service.dart';
import 'package:naptin/services/firebase_auth_services.dart';
import 'package:naptin/services/firestore_db_services.dart';

enum AppMode{DEBUG,RELEASE}

class UserRepository implements AuthBase {
  FireBaseAuthService _firebaseauthservice =locator<FireBaseAuthService>();
  FakeAuthService _fakeAuthService=locator<FakeAuthService>();
  FirestoreDbServices _firestoreDbServices=locator<FirestoreDbServices>();

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
     else {
       User _user = await _firebaseauthservice.singInAnonymously();//user kaydedildi
      bool result=await _firestoreDbServices.saveUser(_user);//dbye gönderildi
      if (result==true) {
        return _user;
      }else return null;
     }
    
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
     else {
       User _user = await _firebaseauthservice.singInWithGoogle();//user kaydedildi
       debugPrint("google :  "+ _user.email.toString());
      bool result=await _firestoreDbServices.saveUser(_user);//dbye gönderildi
      if (result==true) {
        return _user;
      }else return null;
     }
  }

  @override
  Future<User> singInWithFacebook() async{
    if (appMode==AppMode.DEBUG) { 
     return await _fakeAuthService.singInWithFacebook();
    }
     else {
       User _user = await _firebaseauthservice.singInWithFacebook();//user kaydedildi
       debugPrint("face :  "+ _user.email.toString());
      bool result=await _firestoreDbServices.saveUser(_user);//dbye gönderildi
      if (result==true) {
        return _user;
      }else return null;
     }
  }

  @override
  Future<User> createUserWithEmail(String email, String password) async {
    if (appMode==AppMode.DEBUG) { 
     return await _fakeAuthService.createUserWithEmail(email,password);
    }
    else {
      User _user = await _firebaseauthservice.createUserWithEmail(email,password);//user kaydedildi
      bool result=await _firestoreDbServices.saveUser(_user);//dbye gönderildi
      if (result==true) {
        return _user;
      }else return null;
    }
    
      
  }

  @override
  Future<User> singInWithEmail(String email, String password) async {
    if (appMode==AppMode.DEBUG) { 
     return await _fakeAuthService.singInWithEmail(email,password);
    }
     else return await _firebaseauthservice.singInWithEmail(email,password);
  } 
}