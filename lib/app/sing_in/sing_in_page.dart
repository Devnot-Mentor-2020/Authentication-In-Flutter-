import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:naptin/app/sing_in/e-mail_password.dart';
import 'package:naptin/core/components/button/login_button/social_login_button.dart';
import 'package:naptin/core/components/gradient/gradient_Text.dart';
import 'package:naptin/core/components/painter/curve_paniter.dart';
import 'package:naptin/viewmodels/usermodel.dart';
import 'package:provider/provider.dart';

class SingInPage extends StatefulWidget {
  @override
  _SingInPageState createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  void _misafirGirisi(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    await _userModel.singInAnonymously();
  }

  void _googleGiris(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    await _userModel.singInWithGoogle();
  }

  void _facebookGiris(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    try {
      await _userModel.singInWithFacebook();
    } on PlatformException catch (e) {
      print("FACEBOOK HATA YAKALANDI :" + e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: _userModel.state == ViewState.Idle
            ? Center(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.07),
                  width: MediaQuery.of(context).size.width,
                  child: CustomPaint(
                    painter: CurvePainter1(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 40, top: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GradientText(
                                'Login',
                                gradient: LinearGradient(colors: [
                                  Colors.blue.shade900,
                                  Colors.blue.shade100,
                                ]),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              EmailPassword(),
                              SizedBox( height:MediaQuery.of(context).size.height * 0.05, ),
                              Text("Or Login with",style: TextStyle(color: Colors.black54,),),
                              SizedBox(height:MediaQuery.of(context).size.height * 0.03,),
                              orderLoginButton(context)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  Row orderLoginButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SocialLoginButton(
          buttonIcon: FaIcon(
            FontAwesomeIcons.facebookF,
            color: Colors.white,
          ),
          buttonColor: Colors.blue,
          onPressed: () => _facebookGiris(context),
        ),
        SocialLoginButton(
          buttonIcon: FaIcon(
            FontAwesomeIcons.user,
            color: Colors.white,
          ),
          buttonColor: Colors.blue,
          onPressed: () => _misafirGirisi(context),
        ),
        SocialLoginButton(
          buttonIcon: FaIcon(
            FontAwesomeIcons.googlePlusG,
            color: Colors.white,
          ),
          buttonColor: Colors.red.shade200,
          onPressed: () => _googleGiris(context),
        ),
      ],
    );
  }
}
