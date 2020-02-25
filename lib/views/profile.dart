import 'package:flutter/material.dart';
import 'dashboard/user_settings.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Hello, Idai",
                style: TextStyle(
                  fontSize: 46
                ),
              ),
            ),
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))
            ),
          ),
          Expanded(
            child: UserSettings(),
          )
        ],
      ),
    );
  }
}
