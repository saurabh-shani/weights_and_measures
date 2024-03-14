import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weights/screens/NewScreen.dart';
import 'package:weights/screens/login_screen.dart';
import 'package:weights/screens/try_screen.dart';

class DepartmentalLoginWidget extends StatefulWidget {
  @override
  State<DepartmentalLoginWidget> createState() =>
      _DepartmentalLoginWidgetState();
}

class _DepartmentalLoginWidgetState extends State<DepartmentalLoginWidget> {
  final _usernameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _OTPController = TextEditingController();
  var _visibility = false;
  List zonalIdData = [];
  String zonalIdValue;

  String mobilenumberValue;

  @override
  void initState() {
    super.initState();
    zonalIdDataFromApi();
  }

  Future<dynamic> zonalIdDataFromApi() async {
    var url = 'http://164.100.54.35/DL/AN.svc/GetMasterZonalList';
    try {
      final response = await http.post(Uri.encodeFull(url),
          headers: {"content-type": "application/json"});
      var resbody = json.decode(response.body);
      setState(() {
        zonalIdData = resbody;
      });
      print(zonalIdData);
      print(response.body.runtimeType);
    } catch (e) {
      print('Error' + e.toString());
    }
  }

  Future<void> otpCheck(BuildContext context) async {
    final String otpNumber = _OTPController.text;
    if (otpNumber.length == 4 || otpNumber.isEmpty) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(
        'zonalId',
        zonalIdValue,
      );
      sharedPreferences.setString(
        'mobilenumber',
        _mobileNumberController.text,
      );
      Navigator.of(context)
          .pushReplacementNamed(TryScreen.routeName, arguments: {
        'zoneid': zonalIdValue,
        'mobNumber': _mobileNumberController.text,
      });
    /*  Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );*/


    }
  }

  Future<void> _alert(BuildContext context) async {
    final mobileNumber = _mobileNumberController.text;
    if (zonalIdValue == null && mobileNumber.isEmpty) {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
                backgroundColor: Colors.red[100],
                elevation: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Card(
                  color: Colors.red[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.message_rounded,
                          color: Colors.red,
                          size: 100,
                        ),
                        const Text(
                          '!! An error occured !!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                content: const Text(
                  'You have entered incorrect Zonal ID or Mobile Number.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: <Widget>[
                  Card(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    margin: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text(
                        'Try Again',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ));
    } else {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.green[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          scrollable: true,
          content: Column(
            children: <Widget>[
              Card(
                color: Colors.green[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 10,
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.message_rounded,
                        color: Colors.green,
                        size: 150,
                      ),
                      const Text(
                        'Verification Pin ',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Please enter the 4 digit pin.',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                controller: _OTPController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                maxLength: 4,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.mobile_friendly,
                    color: Colors.green,
                  ),
                  labelText: 'Enter PIN',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Card(
                      color: Colors.green[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      margin: const EdgeInsets.all(10),
                      child: FlatButton(
                        onPressed: () {
                          otpCheck(context);
                        },
                        child: const Text(
                          'Verify',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    // Card(
                    //   color: Colors.amber,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   elevation: 10,
                    //   margin: const EdgeInsets.all(10),
                    //   child: FlatButton(
                    //     onPressed: () {
                    //       Navigator.of(context).pop();
                    //       Fluttertoast.showToast(
                    //           msg: 'Max try attempted. Please login again');
                    //     },
                    //     child: const Text(
                    //       'Resend OTP',
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.black,
                    //         fontSize: 15,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _zonalIdDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: DropdownButton(
        isExpanded: true,
        elevation: 30,
        items: zonalIdData == null
            ? DropdownMenuItem(
                value: 'xyz',
                child: Text('Loading...'),
              )
            : zonalIdData.map((item) {
                return DropdownMenuItem(
                  value: item['zonalid'].toString(),
                  child: Text(item['zonename']),
                );
              }).toList(),
        onChanged: (_value) {
          setState(() {
            zonalIdValue = _value;
          });
          print(zonalIdValue);
        },
        value: zonalIdValue,
        hint: Text('Select Zonal Area'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _zonalIdDropdown(),
        SizedBox(
          height: 20,
        ),
        TextField(
          keyboardType: TextInputType.phone,
          maxLength: 10,
          controller: _mobileNumberController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.mobile_friendly),
            labelText: 'Mobile Number',
            prefixText: '+91',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 3,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onSubmitted: (_) => _alert(context),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 50),
          width: double.infinity,
          child: RaisedButton(
            elevation: 10,
            color: Colors.blue,
            onPressed: () {
              _alert(context);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text(
              'Login',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 50),
          width: double.infinity,
          child: RaisedButton(
            elevation: 10,
            color: Colors.amber,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      LoginScreen(), //ComplaintScreen()
                ),
              );
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text(
              'Complainant Login',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
