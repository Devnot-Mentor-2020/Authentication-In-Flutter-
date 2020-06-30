import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final Color buttonColor;
  final Widget buttonIcon;
  final VoidCallback onPressed;

  const SocialLoginButton(
      {Key key, this.buttonColor, this.buttonIcon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.055,
          width: MediaQuery.of(context).size.width * 0.13,
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              onPressed: onPressed,
              color: buttonColor,
              child: buttonIcon),
        ),);
  }
}
