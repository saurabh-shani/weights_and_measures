import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weights/screens/compalint_screen.dart';
import 'package:weights/screens/login_screen.dart';
import 'package:app_settings/app_settings.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkGps();
  }

  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      print('await');
      if (Theme.of(context).platform == TargetPlatform.android ||
          Theme.of(context).platform == TargetPlatform.iOS) {
        print('not');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Can't get gurrent location"),
              content:
                  const Text('Please make sure you enable GPS and try again'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    exit(0);
                  },
                ),
              ],
            );
          },
        );
      }
    } else if ((await Geolocator().isLocationServiceEnabled())) {
      _mockCheckForSession().whenComplete(() async {
        Timer(Duration(seconds: 5),
            () => finalKeys == null ? _navigateToLogin() : _navigateToHome());
      });
    }
  }

  String finalKeys;
  Future _mockCheckForSession() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var checkMobileNumber = sharedPreferences.getString('mobilenumber');
    setState(() {
      finalKeys = checkMobileNumber;
    });
    print(checkMobileNumber);
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => ComplaintScreen(),
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => LoginScreen(),
      ),
    );
  }

  double round = 20.0, elevate = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.2,
          width: MediaQuery.of(context).size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Icon(
                  Icons.monitor_weight_outlined,
                  size: 100,
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Weights and Measures Department',
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 100,
                ),
                Image.asset(
                  'assets/images/nic.png',
                  height: 250,
                  width: 250,
                ),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blue,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
