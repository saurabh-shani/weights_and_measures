import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weights/screens/compalint_screen.dart';

class MobileOtpScreen extends StatelessWidget {
  final _mobileNumberController = TextEditingController();
  // ignore: non_constant_identifier_names
  final _OTPController = TextEditingController();

  void phone(BuildContext context) {
    // ignore: non_constant_identifier_names
    final String OTPNumber = _OTPController.text;
    if (OTPNumber == '1234' || OTPNumber == '0000') {

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => ComplaintScreen()));
    } else {
      Fluttertoast.showToast(msg: ' Dummy OTP is 1234 or 0000');
      Fluttertoast.showToast(msg: 'Please enter correct OTP');
    }
  }

  Future<dynamic> alert(BuildContext context) {
    final mobileNumber = _mobileNumberController.text;
    if (mobileNumber.length != 10) {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('An error occurred!'),
          content: const Text('You have entered wrong number'),
          actions: <Widget>[
            RaisedButton(
              child: const Text('Try Again'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              color: Colors.blue[400],
              elevation: 20,
            )
          ],
          backgroundColor: Colors.blue[300],
          elevation: 50,
        ),
      );
    } else {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
                titlePadding: EdgeInsets.all(10),
                title: Text('Verify'),
                content: Text('An OTP is sent to your device'),
                actions: <Widget>[
                  TextField(
                    keyboardType: TextInputType.phone,
                    controller: _OTPController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 4,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mobile_friendly),
                        labelText: 'Please enter recieved OTP',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 3),
                          borderRadius: BorderRadius.circular(1),
                        )),
                  ),
                  RaisedButton(
                    elevation: 20,
                    color: Colors.blue[400],
                    onPressed: () => phone(context),
                    child: Text('Verify'),
                  )
                ],
                elevation: 50,
                backgroundColor: Colors.blue[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Center(
        child: Stack(children: <Widget>[
          Card(
            color: Colors.blue[300],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.symmetric(vertical: 80, horizontal: 30),
            elevation: 50,
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.message,
                      size: 150,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Mobile number verification',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 10,
                      controller: _mobileNumberController,
                      decoration: InputDecoration(
                          prefixText: '+91',
                          prefixIcon: Icon(Icons.mobile_friendly),
                          labelText: 'Enter Mobile Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3),
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onSubmitted: (_) => {
                        alert(context),
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: RaisedButton(
                        elevation: 20,
                        color: Colors.blue[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () => {
                          alert(context),
                        },
                        child: Text(
                          'Get OTP ',
                          style: TextStyle(
                              fontSize: 18,
                              //fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
