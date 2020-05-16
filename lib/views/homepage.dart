/*
FILE: homepage.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../utils/server.dart';
import 'dashboard.dart';
import 'profile.dart';
import 'pots_list.dart';

/*
This widget is a parent to both SCREEN 2 and SCREEN 3
 */
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  @override
  void initState() {
    // If token is not valid navigate back to SCREEN 1
    Fetcher.testToken().then((isToken) {
      if (!isToken) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamedAndRemoveUntil(context, "/login", (Route<dynamic> route) => false);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HOME",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Builder(
        builder: (context) {
          // This handles the switching between SCREEN 2, 3 according to selection made in WIDGET 1
          if (_currentPage == 0) {
            return Dashboard();
          } else {
            return Profile();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar( // WIDGET 1
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text("Dashboard"),
            icon: Icon(Icons.dashboard)
          ),
          BottomNavigationBarItem(
            title: Text("Profile"),
            icon: Icon(Icons.face)
          )
        ],
        currentIndex: _currentPage,
        onTap: (tappedPage) {
          setState(() {
            _currentPage = tappedPage;
          });
        },
      ),
      floatingActionButton: FloatingActionButton( // WIDGET 1
        child: Icon(Icons.local_florist),
        onPressed: () {
          // Navigate to SCREEN 4
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return PotsList();
            }
          ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
