import 'package:flutter/material.dart';
import 'package:naptin/core/components/button/login_button/login_button_widget.dart';
import 'package:naptin/model/userModel.dart';
import 'package:naptin/viewmodels/usermodel.dart';
import 'package:provider/provider.dart';

enum FormType { Register, Login }

class EmailPassword extends StatefulWidget {
  @override
  _EmailPasswordState createState() => _EmailPasswordState();
}

class _EmailPasswordState extends State<EmailPassword> {
  String _email, _password;

  String _buttonText, _linkText;

  var _formType = FormType.Login;

  final _formKey = GlobalKey<FormState>();
  void _formSubmit(BuildContext context) async {
    _formKey.currentState.save();
    final _userModel = Provider.of<UserModel>(context, listen: false);
    if (_formType == FormType.Login) {
      User _loginUser = await _userModel.singInWithEmail(_email, _password);
      if (_loginUser != null) print("outurum açan" + _loginUser.userID);
    } else {
      User _createUser =
          await _userModel.createUserWithEmail(_email, _password);
      if (_createUser != null) print("outurum açan" + _createUser.userID);
    }
  }

  void _stateChange() {
    setState(() {
      _formType =
          _formType == FormType.Login ? FormType.Register : FormType.Login;
    });
  }

  @override
  Widget build(BuildContext context) {
    _buttonText = _formType == FormType.Login ? "Login" : "Register";
    _linkText = _formType == FormType.Login
        ? "Don't have an account? Create your account"
        : " Do you have an account?";
    final _userModel = Provider.of<UserModel>(context);
    if (_userModel.user != null) {
      Future.delayed(Duration(milliseconds: 2000));
      Navigator.of(context).pop(); // giriş sayfasını kapatır
    }
    return Form(
      key: _formKey,
      child: Column(
        children: [
          registerOrLogin(),
          buildSizedBox(context),
          emailInput(_userModel),
          buildSizedBox(context),
          passwordInput(_userModel),
          buildSizedBox(context),
          buildLoginButton(context),
        ],
      ),
    );
  }

  LoginButton buildLoginButton(BuildContext context) {
    return LoginButton(
          backGroundColor: Colors.blue.shade700,
          onPressed: () => _formSubmit(context),
          text: _buttonText,
          textColor: Colors.white,
        );
  }

  TextFormField passwordInput(UserModel _userModel) {
    return TextFormField(
          onSaved: (String input) {
            _password = input;
          },
          obscureText: true,
          decoration: InputDecoration(
              errorText: _userModel.passwordError != null
                  ? _userModel.passwordError
                  : null,
              hintText: "Password",
              suffixIcon: Icon(
                Icons.lock_outline,
                color: Colors.blue,
              )),
        );
  }

  TextFormField emailInput(UserModel _userModel) {
    return TextFormField(
          keyboardType: TextInputType.emailAddress,
          onSaved: (String input) {
            _email = input;
          },
          decoration: InputDecoration(
              errorText: _userModel.emailError != null
                  ? _userModel.emailError
                  : null,
              hintText: "Email",
              suffixIcon: Icon(
                Icons.person_outline,
                color: Colors.blue,
              )),
        );
  }

  Row registerOrLogin() {
    return Row(
          children: [
            FlatButton(
                onPressed: () => _stateChange(),
                child: Text(
                  _linkText,
                  style: TextStyle(color: Colors.red.shade600),
                )),
          ],
        );
  }

  SizedBox buildSizedBox(BuildContext context) =>
      SizedBox(height: MediaQuery.of(context).size.height * 0.03);
}
