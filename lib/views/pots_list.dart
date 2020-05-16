/*
FILE: pot_list.dart
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'pot_view.dart';
import '../utils/server.dart';

/*
This widget describes SCREEN 4
 */
class PotsList extends StatefulWidget {
  @override
  _PotsListState createState() => _PotsListState();
}

class _PotsListState extends State<PotsList> {
  Directory _saveDir;

  Widget _getImgFromData(Map pot) {
    String path = join(_saveDir.path, pot["_id"] + ".jpg");
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

  /*
  Make a request to the API for:
  All the user's pots and their
    id
    name
    plant
    date planted
    light level history
    moisture level
    water level
   */
  Future<Map> potList() async {
    _saveDir = await getApplicationDocumentsDirectory();
    return Fetcher.fetchWithToken("""
      {
        my_pots {
          _id
          name
          plant
          plantDate
          lightHours
          moisture
          waterLevel
        }
      }
    """);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text(
          "YOUR POTS",
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: potList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) { // Wait for pots from server
            return GridView.builder( // Build a list
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8
                ),
                itemBuilder: (context, index) {
                  if (index < snapshot.data["data"]["my_pots"].length) {
                    return Padding( // WIDGET 1 (for each pot)
                        padding: EdgeInsets.all(16),
                        child: InkWell(
                          onTap: () {
                            // Navigate from SCREEN 4 to SCREEN 5
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return PotView(pot: snapshot.data["data"]["my_pots"][index], dir: _saveDir,);
                                }
                            ));
                          },
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Hero(
                                  tag: "potimage" + snapshot.data["data"]["my_pots"][index]["id"].toString(),
                                  child: _getImgFromData(snapshot.data["data"]["my_pots"][index]), // Picture
                                ),
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Hero(
                                        tag: "potname" + snapshot.data["data"]["my_pots"][index]["id"].toString(),
                                        child: Text( // Pot name
                                          snapshot.data["data"]["my_pots"][index]["name"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24
                                          ),
                                        ),
                                      ),
                                      Text( // Plant type
                                        snapshot.data["data"]["my_pots"][index]["plant"],
                                        style: TextStyle(
                                            fontSize: 10
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 8,
                                      offset: Offset(2, 2)
                                  )
                                ]
                            ),
                          ),
                        )
                    );
                  }
                  return null;
                },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation(Colors.white),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton( // WIDGET 2
        backgroundColor: Colors.white,
        child: Icon(Icons.add, color: Colors.black,),
        onPressed: () {
          // Not functional yet
        },
      ),
    );
  }
}
