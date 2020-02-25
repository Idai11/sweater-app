import 'package:flutter/material.dart';
import 'dashboard/dashboard_item.dart';
import 'dashboard/dashboard_briefing.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DashboardItem(
            title: "Electricity usage",
            value: "0kWh",
            icon: Icons.flash_on,
            iconColor: Colors.yellow,
          ),
          DashboardItem(
            title: "Water usage",
            value: "0L",
            icon: Icons.cloud,
            iconColor: Colors.blue,
          ),
          Expanded(
            child: DashboardBriefing(),
          )
        ],
      ),
    );
  }
}
