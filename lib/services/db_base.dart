import 'package:naptin/model/user.dart';

abstract class DbBase {

  Future<bool> saveUser(User user);
}