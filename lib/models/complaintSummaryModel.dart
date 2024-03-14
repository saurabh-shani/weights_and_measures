// To parse this JSON data, do
//
//     final complantSummaryModel = complantSummaryModelFromJson(jsonString);

import 'dart:convert';

List<ComplantSummaryModel> complantSummaryModelFromJson(String str) =>
    List<ComplantSummaryModel>.from(
        json.decode(str).map((x) => ComplantSummaryModel.fromJson(x)));

String complantSummaryModelToJson(List<ComplantSummaryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ComplantSummaryModel {
  ComplantSummaryModel({
    this.complainantname,
    this.complaintid,
    this.localityname,
    this.merchantname,
    this.mobileno,
  });

  String complainantname;
  String complaintid;
  String localityname;
  String merchantname;
  String mobileno;

  factory ComplantSummaryModel.fromJson(Map<String, dynamic> json) =>
      ComplantSummaryModel(
        complainantname: json["complainantname"],
        complaintid: json["complaintid"],
        localityname: json["localityname"],
        merchantname: json["merchantname"],
        mobileno: json["mobileno"],
      );

  Map<String, dynamic> toJson() => {
        "complainantname": complainantname,
        "complaintid": complaintid,
        "localityname": localityname,
        "merchantname": merchantname,
        "mobileno": mobileno,
      };
}
