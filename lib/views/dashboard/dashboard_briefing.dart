/*
FILE: dashboard_briefing.dart
 */

import 'package:flutter/material.dart';

class DashboardBriefing extends StatefulWidget {
  @override
  _DashboardBriefingState createState() => _DashboardBriefingState();
}

class _DashboardBriefingState extends State<DashboardBriefing> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.inbox),
                Text(
                  " Briefing",
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      size: 80,
                      color: Colors.green,
                    ),
                    Text(
                      "All is good",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.green
                      ),
                    )
                  ],
                ),
              ),
            )
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
