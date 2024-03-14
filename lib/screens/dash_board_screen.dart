import 'package:flutter/material.dart';
import 'package:weights/screens/departmental_login_screen.dart';
import 'package:weights/screens/try_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoaredScreen extends StatelessWidget {
  static const routeName = 'Dashboard-Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text(
            'Home page',
            textAlign: TextAlign.center,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body:
          // Stack(
          //   children: <Widget>[
          //     Container(
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.only(
          //             bottomLeft: Radius.circular(60),
          //             bottomRight: Radius.circular(60),
          //           ),
          //           color: Colors.blue),
          //       height: MediaQuery.of(context).size.height * 0.4,
          //       width: double.infinity,
          //     ),
          //     SingleChildScrollView(
          //       child: Column(
          //         children: <Widget>[
          //           SizedBox(
          //             height: 30,
          //           ),
          //           Text(
          //             'Welcome',
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontWeight: FontWeight.bold,
          //               fontSize: 28,
          //             ),
          //           ),
          //           Text(
          //             'Mr Kumar',
          //             style: TextStyle(
          //               color: Colors.white,
          //               // fontWeight: FontWeight.bold,
          //               fontSize: 20,
          //             ),
          //           ),
          //           SizedBox(
          //             height: 30,
          //           ),
          //           Row(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: <Widget>[
          //               Card(
          //                 elevation: 10,
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(20),
          //                 ),
          //                 child: GestureDetector(
          //                   onTap: () {
          //                     Navigator.of(context).push(
          //                       MaterialPageRoute(
          //                         builder: (BuildContext context) => TryScreen(),
          //                       ),
          //                     );
          //                   },
          //                   child: Container(
          //                     height: 180,
          //                     width: 180,
          //                     child: Center(
          //                       child: Text(
          //                         'Active Cases\n10',
          //                         textAlign: TextAlign.center,
          //                         style: TextStyle(
          //                           fontSize: 20,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               Card(
          //                 elevation: 10,
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(20),
          //                 ),
          //                 child: GestureDetector(
          //                   onTap: () {
          //                     Navigator.of(context).push(
          //                       MaterialPageRoute(
          //                         builder: (BuildContext context) => TryScreen(),
          //                       ),
          //                     );
          //                   },
          //                   child: Container(
          //                     height: 180,
          //                     width: 180,
          //                     child: Center(
          //                       child: Text(
          //                         'Pending Cases\n10',
          //                         textAlign: TextAlign.center,
          //                         style: TextStyle(
          //                           fontSize: 20,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           SizedBox(
          //             height: 30,
          //           ),
          //           Row(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: <Widget>[
          //               Card(
          //                 elevation: 10,
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(20),
          //                 ),
          //                 child: GestureDetector(
          //                   onTap: () {
          //                     Navigator.of(context).push(
          //                       MaterialPageRoute(
          //                         builder: (BuildContext context) => TryScreen(),
          //                       ),
          //                     );
          //                   },
          //                   child: Container(
          //                     height: 180,
          //                     width: 180,
          //                     child: Center(
          //                       child: Text(
          //                         'Completed Cases\n10',
          //                         textAlign: TextAlign.center,
          //                         style: TextStyle(
          //                           fontSize: 20,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               Card(
          //                 elevation: 10,
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(20),
          //                 ),
          //                 child: GestureDetector(
          //                   onTap: () {
          //                     Navigator.of(context).push(
          //                       MaterialPageRoute(
          //                         builder: (BuildContext context) => TryScreen(),
          //                       ),
          //                     );
          //                   },
          //                   child: Container(
          //                     height: 180,
          //                     width: 180,
          //                     child: Center(
          //                       child: Text(
          //                         'Disposed Cases\n10',
          //                         textAlign: TextAlign.center,
          //                         style: TextStyle(
          //                           fontSize: 20,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           SizedBox(
          //             height: 50,
          //           ),
          //           Container(
          //             height: 50,
          //             margin: EdgeInsets.symmetric(horizontal: 50),
          //             width: double.infinity,
          //             child: RaisedButton(
          //               elevation: 10,
          //               color: Colors.blue,
          //               onPressed: () async {
          //                 final SharedPreferences sharedPreferences =
          //                     await SharedPreferences.getInstance();
          //                 sharedPreferences.remove('mobilenumber');
          //                 Navigator.of(context).pushReplacement(
          //                   MaterialPageRoute(
          //                     builder: (BuildContext context) =>
          //                         DepartmentalLoginScreen(), //ComplaintScreen()
          //                   ),
          //                 );
          //               },
          //               shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(20)),
          //               child: Text(
          //                 'Logout',
          //                 style: TextStyle(
          //                     fontSize: 20,
          //                     fontWeight: FontWeight.bold,
          //                     color: Colors.white),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          Text(''),
    );
  }
}
