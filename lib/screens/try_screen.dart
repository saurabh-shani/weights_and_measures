import 'package:flutter/material.dart';
import 'package:weights/screens/departmental_login_screen.dart';
import 'package:weights/screens/login_screen.dart';
import 'package:weights/widget/complaintListWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TryScreen extends StatelessWidget {
  static const routeName = 'Try-Screen';
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final zoneid = routeArgs['zoneid'];
    final mobNumber = routeArgs['mobNumber'];

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Details of Complaints'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: IconButton(
              onPressed: () async {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.remove('mobilenumber');
                sharedPreferences.remove("zonalId");
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DepartmentalLoginScreen(), //ComplaintScreen()
                ));
              },
              icon: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: CompliantListWidget(
        zoneid: zoneid,
        mobNumber: mobNumber,
      ),
    );
  }
}























// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:weights/screens/complaintDetail.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class TryScreen extends StatefulWidget {
//   static const routeName = 'Try-Screeen';

//   TryScreen(String zonalIdValue, String text);

//   @override
//   _TryScreenState createState() => _TryScreenState();
// }

// class _TryScreenState extends State<TryScreen> {
//   var zonal;

//   @override
//   void initState() {
//     super.initState();
//     getShared();
//     formList();
//   }

//   Future<void> getShared() async {
//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();

//     setState(() {
//       zonal = sharedPreferences.getString('zonalId');
//     });
//   }

//   Future<http.Response> formList() async {
//     // print('zonal ' + zonal);
//     var url = 'http://164.100.54.35/DL/AN.svc/GetComplaintSummaryDetailsList';
//     Map data = {
//       "zoneid": zonal,
//       "mobileno": "9643914381",
//     };
//     //encode Map to JSON
//     var body = json.encode(data);

//     var response = await http.post(url,
//         headers: {"Content-Type": "application/json"}, body: body);
//     // print("${response.statusCode}");
//     // print("${response.body}");
//     var resbody = json.decode(response.body);
//     print(resbody);
//     // alert(context, response.body);
//     setState(() {
//       formListResponse = resbody;
//     });
//     return response;
//   }

  //   List formListResponse = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Details of Complaints'),
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Stack(
//           children: <Widget>[
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20),
//                 child: DataTable(
//                   horizontalMargin: 0,
//                   columnSpacing: 10,
//                   columns: <DataColumn>[
//                     DataColumn(
//                       label: Container(
//                         height: 50,
//                         width: 150,
//                         child: Center(
//                           child: Text(
//                             'Complainant',
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Container(
//                         height: 50,
//                         width: 150,
//                         child: Center(
//                           child: Text(
//                             'Locality',
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Container(
//                         height: 50,
//                         width: 150,
//                         child: Center(
//                           child: Text(
//                             'Merchant',
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Container(
//                         height: 50,
//                         width: 150,
//                         child: Center(
//                           child: Text(
//                             'Contact',
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Container(
//                         height: 50,
//                         width: 150,
//                         child: Center(
//                           child: Text(
//                             'Details',
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                   rows:
//                       formListResponse // Loops through dataColumnText, each iteration assigning the value to element
//                           .map(
//                             ((element) => DataRow(
//                                   cells: <DataCell>[
//                                     // DataCell(Text(listOfColumns.length.toString())),
//                                     DataCell(Text(element["complainantname"]
//                                         .toString())), //Extracting from Map element the value
//                                     DataCell(Text(element["localityname"])),
//                                     DataCell(Text(element["merchantname"])),
//                                     DataCell(Text(element["mobileno"])),
//                                     DataCell(
//                                       RaisedButton(
//                                         color: Colors.blue,
//                                         elevation: 0,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                         ),
//                                         textColor: Colors.black,
//                                         onPressed: () {
//                                            Navigator.of(context).pushReplacement(compain)
                                          
                                          
                                          
//                                           // Navigator.of(context).push(
//                                           //   MaterialPageRoute(
//                                           //     builder: (BuildContext context) =>
//                                           //         ComplaintDetailsScreen(
//                                           //       element["complaintid"],
//                                           //       zonal,
//                                           //       element["mobileno"],
//                                           //     ), //ComplaintScreen()
//                                           //   ),
//                                           // );
//                                         },
//                                         child: Text('View'),
//                                       ),
//                                     ),
//                                   ],
//                                 )),
//                           )
//                           .toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
