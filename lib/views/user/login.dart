/*
FILE: login.dart
 */

import 'package:flutter/material.dart';
import 'package:sweater/utils/server.dart';

/*
This widget describes SCREEN 1
 */
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController(); // CONTROLLER FOR WIDGET 1
  final passwordController = TextEditingController(); // CONTROLLER FOR WIDGET 2
  String errorMessage;


  @override
  void initState() {
    errorMessage = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: TextFormField( // WIDGET 1
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: TextFormField( // WIDGET 2
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password"
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 48),
                child: RaisedButton( // WIDGET 3
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        fontSize: 24
                    ),
                  ),
                  onPressed: () {
                    // Gets input from widget 1, 2 using controllers declared above
                    Fetcher.authenticate(emailController.text, passwordController.text).then((success) {
                      if (success) {
                        // Navigate from SCREEN 1 to SCREEN 2
                        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
                      } else {
                        setState(() {
                          errorMessage = "Login failed!";
                        });
                      }
                    });
                  },
                ),
              ),
              FlatButton( // WIDGET 4
                child: Text("or Sign Up"),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, "/signup", (Route<dynamic> route) => false);
                },
              ),
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
