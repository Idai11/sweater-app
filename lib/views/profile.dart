/*
FILE: profile.dart
 */

import 'package:flutter/material.dart';
import 'package:sweater/utils/server.dart';
import 'dashboard/user_settings.dart';

/*
This widget describes SCREEN 3
 */
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<Map> userData() {
    return Fetcher.fetchWithToken("""
    {
      me {
        firstName
      }
    }
    """);
  }

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
              child: FutureBuilder( // WIDGET 2
                future: userData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      snapshot.data["data"]["me"]["firstName"],
                      style: TextStyle(
                          fontSize: 46
                      ),
                    );
                  } else {
                    return Text(
                      "...",
                      style: TextStyle(
                        fontSize: 46
                      ),
                    );
                  }
                },
              ),
            ),
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))
            ),
          ),
          Expanded(
            child: UserSettings(), // WIDGET 3 is inside of this widget (for organization reasons)
          )
        ],
      ),
    );
  }
}
