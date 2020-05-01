/*
FILE: login.dart
 */

import 'package:flutter/material.dart';
import 'package:sweater/utils/server.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password"
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 48),
                child: RaisedButton(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        fontSize: 24
                    ),
                  ),
                  onPressed: () {
                    // See fetcher class
                    Fetcher.authenticate(emailController.text, passwordController.text).then((success) {
                      if (success) {
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
              FlatButton(
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
