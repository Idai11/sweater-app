import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../utils/server.dart';
import 'dashboard.dart';
import 'profile.dart';
import 'pots_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  @override
  void initState() {
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
          if (_currentPage == 0) {
            return Dashboard();
          } else {
            return Profile();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.local_florist),
        onPressed: () {
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
