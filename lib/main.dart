import 'package:flutter/material.dart';
import 'package:naptin/app/landingPage.dart';
import 'package:naptin/locator.dart';
import 'package:naptin/viewmodels/usermodel.dart';
import 'package:provider/provider.dart';


void main() {
setupLocator();//getIt
runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
       create: (context)=>UserModel(),
      child: MaterialApp(
        title: "Naptin",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: LandingPage()
        
      ),
    );
  }
}
