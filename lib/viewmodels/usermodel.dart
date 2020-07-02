import 'package:flutter/cupertino.dart';
import 'package:naptin/locator.dart';
import 'package:naptin/model/user.dart';
import 'package:naptin/repository/user_repo.dart';
import 'package:naptin/services/auth_base.dart';

enum ViewState{Idle,Busy}
class UserModel with ChangeNotifier implements AuthBase{

ViewState _state= ViewState.Idle;
UserRepository _userRepository =locator<UserRepository>();
User _user;
String emailError;
String passwordError;
User get user =>_user;

ViewState get state =>_state;

set state (ViewState value){ // state kullanıcı verisi
  _state= value;
  notifyListeners(); // enum ne zaman değişirse arayüze bilgi verilir.
}
UserModel(){
  currentUser();
}
  @override
  Future<User> currentUser() async{
    try {
      state =ViewState.Busy;
       _user=await _userRepository.currentUser();
       return _user;
    } catch(e){
      debugPrint ("viewmodel currentt user hata"+ e.toString());
      return null;
    } finally{
      state=ViewState.Idle;
    }
  }

  @override
  Future<User> singInAnonymously() async {
     try {
      state =ViewState.Busy;
      _user=await _userRepository.singInAnonymously();
      return _user;
    } catch(e){
      debugPrint ("Misafir girişi hata"+ e.toString());
      return null;
    } finally{
      state=ViewState.Idle;
    }
  }

  @override
  Future<bool> singOut() async {
     try {
      state =ViewState.Busy;
      bool sonuc=await _userRepository.singOut();
      _user=null;
      return  sonuc;
    } catch(e){
      debugPrint ("SingOutHata"+ e.toString());
      return false;
    } finally{
      state=ViewState.Idle;
    }

  }

  @override
  Future<User> singInWithGoogle()async {
   try {
      state =ViewState.Busy;
      _user=await _userRepository.singInWithGoogle();
      return _user;
    } catch(e){
      debugPrint ("Google Girişi Hata"+ e.toString());
      return null;
    } finally{
      state=ViewState.Idle;
    }
  }

  @override
  Future<User> singInWithFacebook() async {
    try {
      state =ViewState.Busy;
      _user=await _userRepository.singInWithFacebook();
      return _user;
    } catch(e){
      debugPrint ("Facebook Girişi Hata"+ e.toString());
      return null;
    } finally{
      state=ViewState.Idle;
    }
  }

  @override
  Future<User> createUserWithEmail(String email, String password) async {
    try { 
      if (_emailPasswordControl(email, password)) {
        state =ViewState.Busy;
      _user=await _userRepository.createUserWithEmail(email,password);
      return _user;
      }else return null;
      
    } catch(e){
      debugPrint ("Email Kayıt hata"+ e.toString());
      return null;
    } finally{
      state=ViewState.Idle;
    }
  }

  @override
  Future<User> singInWithEmail(String email, String password) async {
    try {
      if (_emailPasswordControl(email, password)) {
      state =ViewState.Busy;
      _user=await _userRepository.singInWithEmail(email,password);
      return _user;
      }else return null;
      
    } catch(e){
      debugPrint ("Email Girişi hata"+ e.toString());
      return null;
    } finally{
      state=ViewState.Idle;
    }
  }
  bool _emailPasswordControl(String email,String password){
    var result =true;
    if (password.length<6) {
      passwordError=" şifre En az 6 karakter olmalı";
      result=false;
    } else passwordError=null;
    if (!email.contains("@")) {
      emailError="Geçersiz Email";
      result=false;
    } emailError=null;
    return result;
  }
  }