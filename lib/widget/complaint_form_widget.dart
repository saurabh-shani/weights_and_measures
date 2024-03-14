import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
// import 'package:location/location.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';

class ComplaintFormWidget extends StatefulWidget {
  @override
  _ComplaintFormWidgetState createState() => _ComplaintFormWidgetState();
}

class _ComplaintFormWidgetState extends State<ComplaintFormWidget> {
  File _storedImage;
  // LocationData _currentPosition;
  String localityId, complaintTypeId, imageStringBase64, deviceId, mobileNumber;
  List localityData = [], mNamedata = [], complaintTypeData = [];
  final _form = GlobalKey<FormState>();
  bool isLoading = false;
  List complaintFormDetails = [];
  final merchantNameController = TextEditingController(),
      merchantAddressController = TextEditingController(),
      complaintTypeController = TextEditingController(),
      complaintDescriptionController = TextEditingController(),
      complainantNameController = TextEditingController();
  double currentLatitude = 28.629510143263015;
  double currentLongitude = 77.251289269051;

  @override
  void initState() {
    super.initState();
    merchantLocalityData();
    // merchantNameData();
    complaintTypeDataFromApi();
  }

  //to get current location
  // Future<void> _getCurrentUserLocation() async {
  //   final locData = await Location().getLocation();
  //   print(locData.latitude);
  //   print(locData.longitude);
  //   setState(() {
  //     currentLatitude = locData.latitude;
  //     currentLongitude = locData.longitude;
  //   });
  // }

  //to get device id

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // Unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // Unique ID on Android
    }
  }

  Future<void> saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      print('save');
      return;
    } else if (_storedImage == null) {
      Scaffold.of(context).showSnackBar(
        new SnackBar(
          content: new Text('No Image Selected'),
        ),
      );
    } else if (localityId == null) {
      Scaffold.of(context).showSnackBar(
        new SnackBar(
          content: new Text('Please select locality'),
        ),
      );
    } else if (complaintTypeId == null) {
      Scaffold.of(context).showSnackBar(
        new SnackBar(
          content: new Text('Please select complaint type'),
        ),
      );
    } else {
      print('Merchant name' + merchantNameController.text);
      print('merchant address' + merchantAddressController.text);
      print('ComplaitntType' + complaintTypeController.text);
      print('conmplaint description' + complaintDescriptionController.text);
      print('name' + complainantNameController.text);
      print('merchant id' + '1');
      print('localtity id' + localityId);
      print('complaint id' + complaintTypeId);
      print('Image' + _storedImage.toString());

      getDeviceIdAndImage();

      print(imageStringBase64);
      // print('Device Id' + deviceId);
      // _getCurrentUserLocation();
      submitForm();
      // alert(context);
    }
  }

  //To get
  Future<void> getDeviceIdAndImage() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    Uint8List imagebytes = await _storedImage.readAsBytes(); //convert to bytes
    String deviceIDD = await _getId();
    setState(() {
      deviceId = deviceIDD;
      mobileNumber = sharedPreferences.getString('mobilenumber');
      imageStringBase64 =
          base64.encode(imagebytes); //convert bytes to base64 string
      isLoading = true;
    });
  }

  //To submit form

  Future<http.Response> submitForm() async {
    var url = 'http://164.100.54.35/DL/AN.svc/SaveandReturnComplaintID';

    Map data = {
      "complainantname": complainantNameController.text,
      "mobileno": mobileNumber,
      "localityid": localityId,
      "latitude": "78.12.25.32",
      "longitude": "25.236.251",
      "merchantid": "1",
      "merchantname": merchantNameController.text,
      "merchantaddress": merchantAddressController.text,
      "complainttypeid": complaintTypeId,
      "complaintdescription": complaintDescriptionController.text,
      "photo": imageStringBase64,
      "ipaddress": deviceId,
    };
    print('Map data' + data.toString());
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print("code ${response.statusCode}");
    print("body ${response.body}");
    alert(context, response.body);
    return response;
  }

//  //To fetch merchant name form api
//   Future<dynamic> merchantNameData() async {
//     var url = 'http://164.100.54.35/DL/AN.svc/GetmasterMerchantList';
//     try {
//       final response = await http.post(Uri.encodeFull(url),
//           headers: {"content-type": "application/json"});
//       var resbody = json.decode(response.body);
//       setState(() {
//         mNamedata = resbody;
//       });
//       print(mNamedata);
//       print(response.body.runtimeType);
//     } catch (e) {
//       print('Error' + e.toString());
//     }
//   }

//To fetch merchant locality form api
  Future<dynamic> merchantLocalityData() async {
    var url = 'http://164.100.54.35/DL/AN.svc/GetMasterLocalityList';
    try {
      final response = await http.post(Uri.encodeFull(url),
          headers: {"content-type": "application/json"});
      var resbody = json.decode(response.body);
      setState(() {
        localityData = resbody;
      });
      print(localityData);
      print(response.body.runtimeType);
    } catch (e) {
      print('Error' + e.toString());
    }
  }

  //To fetch complaint type data form api
  Future<dynamic> complaintTypeDataFromApi() async {
    var url = 'http://164.100.54.35/DL/AN.svc/GetComplainTypeList';
    try {
      final response = await http.post(Uri.encodeFull(url),
          headers: {"content-type": "application/json"});
      var resbody = json.decode(response.body);
      setState(() {
        complaintTypeData = resbody;
      });
      print(complaintTypeData);
      print(response.body.runtimeType);
    } catch (e) {
      print('Error' + e.toString());
    }
  }

  //To enter from

  //To enter Complainant name if merchant is not registered.
  Widget _complainantName() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextFormField(
        controller: complainantNameController,
        decoration: InputDecoration(
          labelText: 'Enter name of complainant',
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 3),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'The name field is required';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.name,
        onSaved: (value) {},
      ),
    );
  }

// // dropDwon menu to choose merchant name
//   Widget _merchantNameDropDownMenu() {
//     return Container(
//       height: 50,
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       width: double.infinity,
//       child: DropdownButton(
//         isExpanded: true,
//         elevation: 30,
//         items: mNamedata == null
//             ? DropdownMenuItem(
//                 value: 'xyz',
//                 child: Text('Loading...'),
//               )
//             : mNamedata.map((item) {
//                 return DropdownMenuItem(
//                   value: item['merchantid'].toString(),
//                   child: Text(item['merchantname']),
//                 );
//               }).toList(),
//         onChanged: (_value) {
//           setState(() {
//             merchantName = _value;
//           });
//           print(merchantName);
//         },
//         value: merchantName,
//         hint: Text('Select merchant name'),
//       ),
//     );
//   }

  //To enter merchant name if merchant is not registered.
  Widget _merchantName() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextFormField(
        controller: merchantNameController,
        decoration: InputDecoration(
          labelText: 'Enter name of merchant',
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 3),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        textInputAction: TextInputAction.next,
        // onFieldSubmitted: (_) {
        //   FocusScope.of(context).requestFocus(_emailIdFocusNode);
        // },
        validator: (value) {
          if (value.isEmpty) {
            return 'The name field is required';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.name,
        onSaved: (value) {},
      ),
    );
  }

  //Merchant Address
  Widget _merchantAddress() {
    return Container(
      // height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            ' \t\t\t\t Merchant Address',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextFormField(
              controller: merchantAddressController,
              maxLines: 6,
              // maxLength: 255,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 3),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              textInputAction: TextInputAction.next,
              // onFieldSubmitted: (_) {
              //   FocusScope.of(context).requestFocus(_emailIdFocusNode);
              // },
              validator: (value) {
                if (value.isEmpty) {
                  return 'The name field is required';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.multiline,
              onSaved: (value) {},
            ),
          ),
        ],
      ),
    );

    // Container(
    //   margin: const EdgeInsets.symmetric(
    //     horizontal: 20,
    //   ),
    //   child: TextFormField(
    //     controller: merchantAddressController,
    //     decoration: InputDecoration(
    //       labelText: 'Enter address of merchant',
    //       border: OutlineInputBorder(
    //         borderSide: BorderSide(width: 3),
    //         borderRadius: BorderRadius.circular(20),
    //       ),
    //     ),
    //     textInputAction: TextInputAction.next,
    //     // onFieldSubmitted: (_) {
    //     //   FocusScope.of(context).requestFocus(_emailIdFocusNode);
    //     // },
    //     validator: (value) {
    //       if (value.isEmpty) {
    //         return 'The name field is required';
    //       } else {
    //         return null;
    //       }
    //     },
    //     keyboardType: TextInputType.name,
    //     onSaved: (value) {},
    //   ),
    // );
  }

  //Merchant Location dropdown Menu
  Widget _merchantLocality() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: DropdownButton(
        isExpanded: true,
        elevation: 30,
        items: localityData == null
            ? DropdownMenuItem(
                value: 'xyz',
                child: Text('Loading...'),
              )
            : localityData.map((item) {
                return DropdownMenuItem(
                  value: item['localityid'].toString(),
                  child: Text(item['localityname']),
                );
              }).toList(),
        onChanged: (_value) {
          setState(() {
            localityId = _value;
          });
          print(localityId);
        },
        value: localityId,
        hint: Text('Select merchant locality'),
      ),
    );
  }

  //Complaint Type dropdown Menu
  Widget _complaintTypeDropdown() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: DropdownButton(
        isExpanded: true,
        elevation: 30,
        items: complaintTypeData == null
            ? DropdownMenuItem(
                value: 'xyz',
                child: Text('Loading...'),
              )
            : complaintTypeData.map((item) {
                return DropdownMenuItem(
                  value: item['complaintid'].toString(),
                  child: Text(
                    item['complaintdescription'],
                  ),
                );
              }).toList(),
        onChanged: (_value) {
          setState(() {
            complaintTypeId = _value;
          });
          print(complaintTypeId);
        },
        value: complaintTypeId,
        hint: Text('Select complaint type'),
      ),
    );
  }

  //To enter compaint type description it will be shown if complaint type is others
  Widget _complainType() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Enter type of complaint',
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 3),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        textInputAction: TextInputAction.next,
        // onFieldSubmitted: (_) {
        //   FocusScope.of(context).requestFocus(_emailIdFocusNode);
        // },
        validator: (value) {
          if (value.isEmpty) {
            return 'The name field is required';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.name,
        onSaved: (value) {},
      ),
    );
  }

// Complaint description
  Widget _complainDescription() {
    return Container(
      // height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            ' \t\t\t\tComplaint Description',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextFormField(
              controller: complaintDescriptionController,
              maxLines: 6,
              maxLength: 255,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 3),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              textInputAction: TextInputAction.next,
              // onFieldSubmitted: (_) {
              //   FocusScope.of(context).requestFocus(_emailIdFocusNode);
              // },
              validator: (value) {
                if (value.isEmpty) {
                  return 'The name field is required';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.multiline,
              onSaved: (value) {},
            ),
          ),
        ],
      ),
    );
  }

  //To take image
  Future<void> _takePicture(bool) async {
    final imageFile = await ImagePicker.pickImage(
      source: bool ? ImageSource.gallery : ImageSource.camera,
      maxWidth: 200,
      maxHeight: 200,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = imageFile;
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    _storedImage = savedImage;
  }

  Widget _getcomplaintPhoto() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            ' \t\t\t\tSelect Image',
            style: TextStyle(
              fontSize: 18,
              // fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: _storedImage != null ? 600 : 200,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: _storedImage != null
                  ? Container(
                      padding: EdgeInsets.all(10),
                      child: Image.file(
                        _storedImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                  : Text(
                      'No Image taken',
                      textAlign: TextAlign.center,
                    ),
            ),
            alignment: Alignment.center,
          ),
          Center(
            child: FlatButton.icon(
              onPressed: _sourceAlert,
              icon: Icon(Icons.camera_alt),
              label: Text('Choose Image'),
            ),
          ),
        ]);
  }

  Future<bool> _sourceAlert() {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        titlePadding: EdgeInsets.all(10),
        content: Container(
          height: 150,
          child: Column(
            children: <Widget>[
              Text(
                'Select Image from?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                  onPressed: () {
                    print('Camera');
                    _takePicture(false);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Camera',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )),
              FlatButton(
                onPressed: () {
                  print('Gallery');
                  _takePicture(true);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Gallery',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        elevation: 50,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

//Submit Button
  Widget submitButton() => RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 20,
      padding: const EdgeInsets.all(10),
      highlightElevation: 50,
      highlightColor: Colors.blue[100],
      color: Colors.blue[400],
      child: Container(
        height: 30,
        width: 100,
        child: Center(
            child: const Text(
          'Submit',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        )),
      ),
      onPressed: () async {
        saveForm();
      } //_submitData,
      );

//Reset form
  Widget resetButton() => RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 20,
      padding: const EdgeInsets.all(10),
      highlightElevation: 50,
      highlightColor: Colors.blue[100],
      color: Colors.blue[400],
      child: Container(
        height: 30,
        width: 100,
        child: Center(
            child: const Text(
          'Reset',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        )),
      ),
      onPressed: () {
        _form.currentState.reset();
        setState(() {
          // ignore: unnecessary_statements
          localityId = null;
          complaintTypeId = null;
          _storedImage = null;
        });
      } //reset form,
      );

//To show dailog of submit form
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
          'Succesfully',
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
                  Navigator.of(ctx).pop();
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          _complainantName(),
          SizedBox(
            height: 20,
          ),
          // _merchantNameDropDownMenu(),

          _merchantName(),
          SizedBox(
            height: 20,
          ),
          _merchantAddress(),
          SizedBox(
            height: 20,
          ),
          _merchantLocality(),
          SizedBox(
            height: 20,
          ),
          _complaintTypeDropdown(),
          SizedBox(
            height: 20,
          ),
          if (complaintTypeId == 'others') _complainType(),
          SizedBox(
            height: 20,
          ),
          _complainDescription(),
          _getcomplaintPhoto(),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              submitButton(),
              resetButton(),
            ],
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
