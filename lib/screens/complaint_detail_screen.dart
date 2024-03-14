import 'package:flutter/material.dart';
import 'package:weights/screens/try_screen.dart';
import 'package:weights/widget/complaint_details_widget.dart';

class ComplaintDetailsScreen extends StatelessWidget {
  // const ComplaintDetailsScreen({ Key? key }) : super(key: key);
  static const routeName = 'ComplaintDetails-Screen';
  String compliantID;
  String zoneid;
  String mobileno;
  ComplaintDetailsScreen({this.compliantID, this.zoneid, this.mobileno});
  @override
  Widget build(BuildContext context) {
    /*final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final complaintId = routeArgs['complaintid'];
    final zoneid = routeArgs['zonal_id'];
    final mobNumber = routeArgs['mobile_number'];*/

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Complaint Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ComplaintDetailsWidget(
        compliantID: compliantID,
        zoneid: zoneid,
        mobileno: mobileno,
      ),
    );
  }
}
