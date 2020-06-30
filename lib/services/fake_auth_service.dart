import 'package:naptin/model/userModel.dart';
import 'package:naptin/services/auth_base.dart';

class FakeAuthService implements AuthBase{
  String userID="123123123";
  @override
  Future<User> currentUser() async {
    return User(userID: userID);
  }

  @override
  Future<User> singInAnonymously()async {
    return await Future.delayed(Duration(seconds: 2),()=>User(userID: userID));//
  }

  @override
  Future<bool> singOut() {
    return Future.value(true);
  }

  @override
  Future<User> singInWithGoogle() {
    // TODO: implement singInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<User> singInWithFacebook() {
    // TODO: implement singInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<User> createUserWithEmail(String email, String password) {
    // TODO: implement createUserWithEmail
    throw UnimplementedError();
  }

  @override
  Future<User> singInWithEmail(String email, String password) {
    // TODO: implement singInWithEmail
    throw UnimplementedError();
  }

}