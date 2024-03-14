import 'package:flutter/material.dart';
import 'package:weights/screens/login_screen.dart';
import 'package:weights/widget/complaint_form_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComplaintScreen extends StatelessWidget {
  static const routeName = 'Complaint-Screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Form'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: IconButton(
              onPressed: () async {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.remove('mobilenumber');
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      LoginScreen(), //ComplaintScreen()
                ));
              },
              icon: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              ComplaintFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
