import 'package:flutter/material.dart';
import 'package:sweater/utils/local.dart';

class UserSettings extends StatefulWidget {
  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.settings),
                Text(
                  " User Settings",
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ],
            ),
            Divider(),
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Change Name"),
                  leading: Icon(Icons.person),
                  onTap: () {

                  },
                ),
                Divider(),
                ListTile(
                  title: Text("Change Email"),
                  leading: Icon(Icons.alternate_email),
                  onTap: () {

                  },
                ),
                Divider(),
                ListTile(
                  title: Text("Change Password"),
                  leading: Icon(Icons.https),
                  onTap: () {

                  },
                ),
                Divider(),
                ListTile(
                  title: Text("Logout"),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () {
                    LocalSave.setString("token", "");
                    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                  },
                )
              ],
            ),
          ],
        ),
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24))
      ),
    );
  }
}
