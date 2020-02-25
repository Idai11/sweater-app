import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'small/camera.dart';

class PotView extends StatefulWidget {
  final Map pot;
  final Directory dir;

  PotView({this.pot, this.dir});

  @override
  _PotViewState createState() => _PotViewState();
}

class _PotViewState extends State<PotView> {
  Map validity = {
    "plant": true,
    "moisture": false,
    "lightHours": true
  };

  double _makeAvg(List list) {
    double sum = 0;

    list.forEach((number) { sum += number; });

    return ((sum / list.length) * 20).round() / 20;
  }

  Widget _getImgFromData(Map pot) {
    String path = join(widget.dir.path, pot["_id"] + ".jpg");
    File file = File(path);

    if (!file.existsSync()) {
      return AspectRatio(
        aspectRatio: 1,
        child: Container(
          color: Colors.black12,
          child: Center(
            child: Icon(Icons.add_a_photo, color: Colors.black54, size: 36,),
          ),
        ),
      );
    } else {
      return AspectRatio(
          aspectRatio: 1,
          child: Image.file(file, fit: BoxFit.cover,)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            child: FractionallySizedBox(
              child: Stack(
                children: <Widget>[
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Hero(
                      tag: "potimage" + widget.pot["id"].toString(),
                      child: _getImgFromData(widget.pot),
                    ),
                  ),
                  Positioned(
                    child: Hero(
                      tag: "potname" + widget.pot["id"].toString(),
                      child: Text(
                        widget.pot["name"],
                        style: TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),
                    bottom: 4,
                    left: 4,
                  )
                ],
              ),
              heightFactor: .6,
              widthFactor: 1,
            ),
          ),
          LinearProgressIndicator(
            value: 0,
          ),
          ListTile(
            leading: Icon(Icons.local_florist, color: validity["plant"] ? Colors.grey : Colors.orangeAccent,),
            title: Text("Plant"),
            subtitle: Text(widget.pot["plant"]),
            trailing: Builder(
              builder: (context) {
                if (validity["plant"]) {
                  return Icon(
                    Icons.calendar_today,
                    color: Colors.green,
                  );
                } else {
                  return Tooltip(
                    message: "This is not the fitting time of year for this plant",
                    child: Icon(
                      Icons.priority_high,
                      color: Colors.orangeAccent,
                    ),
                  );
                }
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.invert_colors, color: validity["moisture"] ? Colors.grey : Colors.orangeAccent,),
            title: Text("Humidity"),
            subtitle: Text(widget.pot["moisture"].toString() + "%"),
            trailing: Builder(
              builder: (context) {
                if (validity["moisture"]) {
                  return Icon(
                    Icons.check,
                    color: Colors.green,
                  );
                } else {
                  return Tooltip(
                    message: "Humidity out of valid range, watering...",
                    child: Icon(
                      Icons.arrow_downward,
                      color: Colors.orangeAccent,
                    ),
                  );
                }
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.wb_incandescent, color: validity["lightHours"] ? Colors.grey : Colors.orangeAccent,),
            title: Text("Light"),
            subtitle: Text(_makeAvg(widget.pot["lightHours"]).toString() + "h/d"),
            trailing: Builder(
              builder: (context) {
                if (validity["lightHours"]) {
                  return Icon(
                    Icons.check,
                    color: Colors.green,
                  );
                } else {
                  return Tooltip(
                    message: "Light level out of valid range",
                    child: Icon(
                      Icons.priority_high,
                      color: Colors.orangeAccent,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TakePicture(id: widget.pot["_id"]);
          }));
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
