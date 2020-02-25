import 'package:flutter/material.dart';
import 'views/homepage.dart';
import 'views/user/signup.dart';
import 'views/user/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sweater',
      theme: ThemeData(
        primarySwatch: Colors.green,
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))
          ),
          textTheme: ButtonTextTheme.primary
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          )
        )
      ),
      routes: {
        "/": (ctx) => HomePage(),
        "/login": (ctx) => Login(),
        "/signup": (ctx) => SignUp()
      },
    );
  }
}