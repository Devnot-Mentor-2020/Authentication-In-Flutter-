
import 'package:flutter/material.dart';
import 'package:naptin/app/homePage.dart';
import 'package:naptin/app/sing_in/sing_in_page.dart';
import 'package:naptin/viewmodels/usermodel.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _userModel=Provider.of<UserModel>(context);

    if (_userModel.state==ViewState.Idle) {
      if (_userModel.user==null) {//oturum açılmaydıysa
        return SingInPage();
      }else return HomePage(user: _userModel.user);//oturum açılmıssa homapagege user gönder
    }else return Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
   
  }

  
  
}