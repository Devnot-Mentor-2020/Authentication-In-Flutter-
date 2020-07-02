import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class User{

 final String userID;
 String email;
 DateTime createdAt;

 User( {@required this.userID, @required this.email});

 Map<String, dynamic> toMap(){
   return{
      "userID":userID,
      "email":email,
      "createdAt":createdAt?? FieldValue.serverTimestamp(),
   };
 }
 User.fromMap(Map<String, dynamic>map): // değerleri geri okumak için user nesnesi döndürür
  userID=map["userID"],
  email=map["email"],
  createdAt=(map["createdAt"]as Timestamp).toDate();

  @override
  String toString() {
    return 'User{userID: $userID, email: $email, createdAt: $createdAt}';
  }

}