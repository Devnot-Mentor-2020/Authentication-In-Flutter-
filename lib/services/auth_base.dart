import 'package:naptin/model/userModel.dart';

abstract class AuthBase{
 Future<User> currentUser();
 Future<User> singInAnonymously();
 Future<bool> singOut();
 Future<User> singInWithGoogle();
 Future<User> singInWithFacebook();
 Future<User> singInWithEmail(String email, String password);
 Future<User> createUserWithEmail(String email, String password);
}