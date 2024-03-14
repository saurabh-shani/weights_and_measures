import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:weights/screens/compalint_screen.dart';
import 'package:weights/screens/departmental_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenWidget extends StatelessWidget {
  final _mobileNumberController = TextEditingController();
  final _OTPController = TextEditingController();

  Future<void> phone(BuildContext context) async {
    // ignore: non_constant_identifier_names
    final String OTPNumber = _OTPController.text;
    if (OTPNumber == '1234' || OTPNumber == '0000') {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('mobilenumber', _mobileNumberController.text);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => ComplaintScreen(),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: ' Dummy OTP is 1234 or 0000');
      Fluttertoast.showToast(msg: 'Please enter correct OTP');
    }
  }

  Future<void> _alert(BuildContext context) async {
    final mobileNumber = _mobileNumberController.text;
    if (mobileNumber.isEmpty || mobileNumber.length != 10) {
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
                  elevation: 2,
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
                  'You have entered incorrect mobile number.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: <Widget>[
                  Card(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
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
                        'Verification Code ',
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
                'Please enter the OTP sent to your device',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                controller: _OTPController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 4,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.mobile_friendly,
                    color: Colors.green,
                  ),
                  labelText: 'Enter recieved OTP',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Card(
                    color: Colors.green[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    margin: const EdgeInsets.all(10),
                    child: FlatButton(
                      onPressed: () {},
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
                  Card(
                    color: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    margin: const EdgeInsets.all(10),
                    child: FlatButton(
                      onPressed: () {
                        phone(context);
                        Navigator.of(context).pop();
                        // Fluttertoast.showToast(
                        //     msg: 'Max try attempted. Please login again');
                      },
                      child: const Text(
                        'Resend OTP',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          maxLength: 10,
          keyboardType: TextInputType.phone,
          controller: _mobileNumberController,
          decoration: InputDecoration(
            prefixText: '+91 ',
            prefixIcon: Icon(
              Icons.mobile_friendly,
            ),
            labelText: 'Enter Mobile Number',
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
          margin: EdgeInsets.symmetric(horizontal: 50),
          height: 50,
          width: double.infinity,
          child: RaisedButton(
            elevation: 10,
            color: Colors.amber,
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => DepartmentalLoginScreen(),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text(
              'Departmental Login',
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
