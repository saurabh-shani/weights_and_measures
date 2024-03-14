// To parse this JSON data, do
//
//     final complaintDetailsModel = complaintDetailsModelFromJson(jsonString);

import 'dart:convert';

List<ComplaintDetailsModel> complaintDetailsModelFromJson(String str) =>
    List<ComplaintDetailsModel>.from(
        json.decode(str).map((x) => ComplaintDetailsModel.fromJson(x)));

String complaintDetailsModelToJson(List<ComplaintDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ComplaintDetailsModel {
  ComplaintDetailsModel({
    this.complainantname,
    this.complaintdescription,
    this.complaintid,
    this.localityname,
    this.merchantaddress,
    this.merchantname,
    this.mobileno,
    this.photo,
    this.userid,
  });

  String complainantname;
  String complaintdescription;
  String complaintid;
  String localityname;
  String merchantaddress;
  String merchantname;
  String mobileno;
  String photo;
/*  List<dynamic> photo;*/
  String userid;

  factory ComplaintDetailsModel.fromJson(Map<String, dynamic> json) =>
      ComplaintDetailsModel(
        complainantname: json["complainantname"],
        complaintdescription: json["complaintdescription"],
        complaintid: json["complaintid"],
        localityname: json["localityname"],
        merchantaddress: json["merchantaddress"],
        merchantname: json["merchantname"],
        mobileno: json["mobileno"],
        photo: json["photo"],
      /*  photo: List<dynamic>.from(json["photo"].map((x) => x)),*/
        userid: json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "complainantname": complainantname,
        "complaintdescription": complaintdescription,
        "complaintid": complaintid,
        "localityname": localityname,
        "merchantaddress": merchantaddress,
        "merchantname": merchantname,
        "mobileno": mobileno,
        "photo": photo,
      /*  "photo": List<dynamic>.from(photo.map((x) => x)),*/
        "userid": userid,
      };
}
