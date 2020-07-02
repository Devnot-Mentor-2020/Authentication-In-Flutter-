import 'package:flutter/material.dart';
import 'package:naptin/model/user.dart';
import 'package:naptin/viewmodels/usermodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final User user;
  HomePage({Key key,@required this.user}) : super(key: key);
  
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: 
        Text("HomePage"),
        actions:<Widget> [
            FlatButton( 
              onPressed:()=>_cikisYap(context),
              child:Text("Log Out",
              style: TextStyle(color: Colors.white),
            ),
            ),
        ],
      
      ),
      body: Center(child: Text("Welcome ${user.userID}")),
      
    );
    
  }
  Future<bool> _cikisYap(BuildContext context) async{
     final _userModel=Provider.of<UserModel>(context,listen: false );
     bool sonuc=await _userModel.singOut();
     return sonuc;
    }
}

