import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weights/models/complaintSummaryModel.dart';
import 'package:weights/screens/complaint_detail_screen.dart';

class CompliantListWidget extends StatefulWidget {
  final String zoneid;
  final String mobNumber;

  const CompliantListWidget({
    Key key,
    this.zoneid,
    this.mobNumber,
  }) : super(key: key);

  @override
  _CompliantListWidgetState createState() => _CompliantListWidgetState();
}

class _CompliantListWidgetState extends State<CompliantListWidget> {
  final List<ComplantSummaryModel> formListResponse = [];
  String compliantID;
  String zoneid;
  String mobileno;
  var resbody;

  @override
  void initState() {
    super.initState();
    zoneid = widget.zoneid;
    mobileno = widget.mobNumber;
    formList();
  }

  Future<void> formList() async {
    final url = 'http://164.100.54.35/DL/AN.svc/GetComplaintSummaryDetailsList';

    Map data = {
      "zoneid": zoneid,
      "mobileno": mobileno,
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
      formListResponse.add(
        new ComplantSummaryModel(
          complainantname: data["complainantname"],
          complaintid: data["complaintid"],
          localityname: data["localityname"],
          merchantname: data["merchantname"],
          mobileno: data["mobileno"],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: formListResponse.length,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              compliantID = formListResponse[index].complaintid;
              zoneid = zoneid;
              mobileno = mobileno;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComplaintDetailsScreen(
                      compliantID: compliantID,
                      zoneid: zoneid,
                      mobileno: mobileno),
                ),
              );

              // Navigator.of(context).pushNamed(
              //   ComplaintDetailsScreen.routeName,
              //   arguments: {
              //     "complaintid": ,
              //     "zoneid": zoneid,
              //     "mobileno": mobileno,
              //   },
              // );
            },
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              // height: 120,
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Text('${formListResponse[index].complaintid}'),
                  Row(
                    children: <Widget>[
                      Text('Complainant Name: '),
                      Text('${formListResponse[index].complainantname}')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Locality Name: '),
                      Text('${formListResponse[index].localityname}')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Merchant Name: '),
                      Text('${formListResponse[index].merchantname}')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Mobile Number: '),
                      Text('${formListResponse[index].mobileno}')
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
