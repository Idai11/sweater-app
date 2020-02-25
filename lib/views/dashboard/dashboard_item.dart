import 'package:flutter/material.dart';

class DashboardItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final String value;

  DashboardItem({this.title, this.icon, this.iconColor, this.value});

  @override
  _DashboardItemState createState() => _DashboardItemState();
}

class _DashboardItemState extends State<DashboardItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.data_usage),
                Text(
                  " " + widget.title,
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
                Text(
                  " - this month",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey
                  ),
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  widget.icon,
                  size: 60,
                  color: widget.iconColor,
                ),
                Text(
                  widget.value,
                  style: TextStyle(
                    fontSize: 56
                  ),
                )
              ],
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
