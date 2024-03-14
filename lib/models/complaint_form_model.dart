import 'dart:io';

import 'package:flutter/foundation.dart';

class ComplaintFormModel {
  final String mobileNumber;
  final String localityId;
  final double latitude;
  final double longitutde;
  final String merchantId;
  final String merchantName;
  final String merchantAddress;
  final String complaintDescription;
  final String complaintPhoto;
  final String deviceId;
  bool isLoggedin;

  ComplaintFormModel({
    @required this.mobileNumber,
    @required this.localityId,
    @required this.latitude,
    @required this.longitutde,
    @required this.merchantId,
    @required this.merchantName,
    @required this.merchantAddress,
    @required this.complaintDescription,
    @required this.complaintPhoto,
    @required this.deviceId,
  });
}
