import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naptin/model/user.dart';
import 'package:naptin/services/db_base.dart';

class FirestoreDbServices implements DbBase {
  @override
  Future<bool> saveUser(User user) async {
    
    final Firestore _firebaseAuth = Firestore.instance;

    
    await _firebaseAuth
        .collection("users")
        .document(user.userID)
        .setData(user.toMap());

        DocumentSnapshot _readUser= await Firestore.instance.document("users/${user.userID}").get();
        print(user.userID);
        Map _readUserMap=_readUser.data;
        User  _readUserMapObject=User.fromMap(_readUserMap);
        print("readObJECJT: "+ _readUserMapObject.toString());
    return true;
  }
}
