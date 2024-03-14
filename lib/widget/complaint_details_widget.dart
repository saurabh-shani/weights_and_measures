import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weights/models/complaintDetailsModel.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:weights/screens/complaint_detail_screen.dart';
import 'package:weights/screens/try_screen.dart';

class ComplaintDetailsWidget extends StatefulWidget {
  final String compliantID;
  final String zoneid;
  final String mobileno;

  const ComplaintDetailsWidget({
    Key key,
    this.compliantID,
    this.zoneid,
    this.mobileno,
  }) : super(key: key);

  @override
  State<ComplaintDetailsWidget> createState() => _ComplaintDetailsWidgetState();
}

List selectedresult = [];
List detailActionList = [];
List selectedList = [];

class _ComplaintDetailsWidgetState extends State<ComplaintDetailsWidget> {
  final List<ComplaintDetailsModel> complaintDetailsList = [];
  List actionData = [];
  String actionValue;
  String updateResponeId;
  String deviceId;
  String complaintIdss;
  String zoneid;
  String mobNumber;
  String images;

  @override
  void initState() {
    super.initState();
    // print(widget.complaintId + widget.zonal_ids + widget.mobNumber);
    complaintDetails();
    actionSubmitDataFromApi();
    complaintIdss = widget.compliantID;
    zoneid = widget.zoneid;

    mobNumber = widget.mobileno;
    detailsActionTakenFromApi();
    _getId();
  }

  detailsActionTakenFromApi() async {
    var url = 'http://164.100.54.35/DL/AN.svc/getStatusMasterdetailedList';
    try {
      final response = await http.post(Uri.encodeFull(url),
          headers: {"content-type": "application/json"});
      var resbody = json.decode(response.body).cast<dynamic>();
      setState(() {
        detailActionList = resbody;
      });
      print(detailActionList);
      print(response.body.runtimeType);
    } catch (e) {
      print('Error' + e.toString());
    }
  }

  Future<void> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      setState(() {
        deviceId = iosDeviceInfo.identifierForVendor;
      }); // Unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      setState(() {
        deviceId = androidDeviceInfo.androidId;
      }); // Unique ID on Android
    }
  }

  Future<dynamic> alert(BuildContext context, String body) {
    final withoutEquals = body
        .replaceAll(RegExp('{'), '')
        .replaceAll(RegExp('}'), '')
        .replaceAll(RegExp(':'), '')
        .replaceAll(RegExp('"'), '')
        .replaceAll(RegExp('[^A-Za-z0-9]'), ' ')
        .replaceAll(RegExp('Complaintid'), 'Your Complaint ID');
    print(withoutEquals);
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Successfully',
          textAlign: TextAlign.center,
        ),
        content: Text(
          withoutEquals,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(TryScreen.routeName, arguments: {
                    'zoneid': zoneid,
                    'mobNumber': mobNumber,
                  });
                  // Navigator.of(ctx).pushReplacement(TryScreen.routeName);
                },
                color: Colors.blue,
                elevation: 20,
              ),
            ],
          )
        ],
        backgroundColor: Colors.green[100],
        elevation: 50,
      ),
    );
  }

  Future<void> submitActionToApi(
      String complaintid, String userid, List selectedList) async {
    var url = 'http://164.100.54.35/DL/AN.svc/UpdateComplaintStatus';

    Map data = {
      "complaintdetailid": "",
      "complaintid": complaintid,
      "complainttypeid": actionValue,
      "userid": userid,
      "userremarks": "Complaint Resolved",
      "status": "1",
      "useripaddress": deviceId,
    };
    var body = json.encode(data);
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      var resbody = json.decode(response.body);
      setState(() {
        updateResponeId = resbody;
      });
      print(updateResponeId);
      alert(context, updateResponeId);
      print(response.body.runtimeType);
    } catch (e) {
      print('Error' + e.toString());
    }
  }

  Future<void> submitHqActionToApi(
      String complaintid,
      String userid,
      ) async {
    var url = 'http://164.100.54.35/DL/AN.svc/UpdateComplaintStatus';

    Map data = {
      "complaintid": complaintid,
      "userid": userid,
      "userremarks": "Complaint Resolved",
      "useripaddress": deviceId,
    };
    var body = json.encode(data);
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      var resbody = json.decode(response.body);
      setState(() {
        updateResponeId = resbody;
      });
      print(updateResponeId);
      alert(context, updateResponeId);
      print(response.body.runtimeType);
    } catch (e) {
      print('Error' + e.toString());
    }
  }

  Future<dynamic> actionSubmitDataFromApi() async {
    var url = 'http://164.100.54.35/DL/AN.svc/GetStatusMasterList';
    try {
      final response = await http.post(Uri.encodeFull(url),
          headers: {"content-type": "application/json"});
      var resbody = json.decode(response.body);
      setState(() {
        actionData = resbody;
      });
      print(actionData);
      print(response.body.runtimeType);
    } catch (e) {
      print('Error' + e.toString());
    }
  }

  Future<void> complaintDetails() async {
    var resbody;
    final url = 'http://164.100.54.35/DL/AN.svc/GetComplaintFullDetailsList';

    Map data = {
      "complaintid": widget.compliantID,
      "zoneid": widget.zoneid,
      "mobileno": widget.mobileno,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${response.statusCode}");

    setState(() {
      resbody = json.decode(response.body);
    });
    print(resbody);

    for (var data in resbody) {
      complaintDetailsList.add(new ComplaintDetailsModel(
        complainantname: data['complainantname'],
        complaintdescription: data['complaintdescription'],
        complaintid: data['complaintid'],
        localityname: data['localityname'],
        merchantaddress: data['merchantaddress'],
        merchantname: data['merchantname'],
        mobileno: data['mobileno'],
        photo: data['photo'],
        userid: data['userid'],
      ));
    }
  }

  Widget _actionSubmitDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: DropdownButton(
        isExpanded: true,
        elevation: 30,
        items: actionData == null
            ? DropdownMenuItem(
          value: 'xyz',
          child: Text('Loading...'),
        )
            : actionData.map((item) {
          return DropdownMenuItem(
            value: item['statuscode'].toString(),
            child: Column(
              children: <Widget>[
                Text(item['statusdescription']),
                Divider(
                  height: 2,
                  color: Colors.grey,
                )
              ],
            ),
          );
        }).toList(),
        onChanged: (_value) {
          setState(() {
            actionValue = _value;
          });
          print(actionValue);
        },
        value: actionValue,
        hint: Text('Select action'),
      ),
    );
  }

  var cross = CrossAxisAlignment.start;
  var some = MainAxisAlignment.spaceEvenly;
  var again = TextStyle(
    // fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  var again1 = TextStyle(
    // fontSize: 15,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );
  String experiment;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: complaintDetailsList.length,
      itemBuilder: (_, index) {
        return Flexible(
          child: Card(
            margin: new EdgeInsets.all(6.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // if you need this
              side: BorderSide(
                color: Colors.grey.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: some,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: cross,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Complainant Id : ',
                            style: again,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Complainant Name : ',
                            style: again,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Mobile Number : ',
                            style: again,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Merchant Name : ',
                            style: again,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Merchant Address : ',
                            style: again,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Locality Name : ',
                            style: again,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Complainant Description : ',
                            style: again,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          /* Text(
                        'User Id : ',
                        style: again,
                      ),
                      SizedBox(
                        height: 30,
                      ),
*/

                          Text(
                            'Upload Document : ',
                            style: again,
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Text(
                            'Action Taken: ',
                            style: again,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 25,
                          ),
                          Text('${complaintDetailsList[index].complaintid}',
                              style: again1),

                          SizedBox(
                            height: 30,
                          ),

                          Text(
                              '${complaintDetailsList[index].complainantname}'),

                          SizedBox(
                            height: 30,
                          ),

                          Text('${complaintDetailsList[index].mobileno}'),
                          SizedBox(
                            height: 30,
                          ),
                          Text('${complaintDetailsList[index].merchantname}'),

                          SizedBox(
                            height: 30,
                          ),

                          Text(
                              '${complaintDetailsList[index].merchantaddress}'),

                          SizedBox(
                            height: 30,
                          ),
                          Text('${complaintDetailsList[index].localityname}'),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                              '${complaintDetailsList[index].complaintdescription}'),
                          SizedBox(
                            height: 30,
                          ),
                          /*Text('${complaintDetailsList[index].userid}'),
                      SizedBox(
                        height: 30,
                      ),*/
                          // tinypng(complaintDetailsList[index].photo),
                          GestureDetector(
                            onTap: () {
                              images = '${complaintDetailsList[index].photo}';
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ImageScreen(images: images),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  //color: Color(0xFFCCEEFF)),
                                  color: Colors.grey[200]),
                              height: 70,
                              width: 70,
                              //  padding: EdgeInsets.all(8.0),
                              child: Image.memory(
                                base64Decode(
                                    '${complaintDetailsList[index].photo}'),
                                height: 100,
                                width: 100,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (zoneid != '510') _actionSubmitDropdown(),
                  SizedBox(
                    height: 20,
                  ),
                  if (actionValue == '1')
                    MultiSelectDialogField(
                      items: detailActionList
                          .map(
                            (element) => MultiSelectItem(
                          element["statuscode"],
                          element["statusdescription"],
                        ),
                      )
                          .toList(),
                      title: Text("Detail Action Taken"),
                      selectedColor: Colors.blue,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      buttonText: Text(
                        "Detail Action Taken",
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 16,
                        ),
                      ),
                      onSaved: (results) {
                        selectedresult = results;
                      },
                      onConfirm: (results) {
                        setState(() {
                          selectedresult = results;
                          experiment = selectedresult.join(",");
                        });
                        print(experiment);
                      },
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    minLines: 2,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Remarks',
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
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
                        if (zoneid != '510') {
                          submitActionToApi(
                            complaintDetailsList[index].complaintid,
                            complaintDetailsList[index].userid,
                            selectedresult,
                          );
                        } else {
                          submitHqActionToApi(
                            complaintDetailsList[index].complaintid,
                            complaintDetailsList[index].userid,
                          );
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ImageScreen extends StatelessWidget {
  String images;
  ImageScreen({this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Uplaod Document"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.memory(base64Decode(this.images)),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
