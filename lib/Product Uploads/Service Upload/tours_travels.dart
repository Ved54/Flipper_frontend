import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/job_cat.dart';
import 'package:mazha_app/Product%20Uploads/Service%20Upload/service_cat.dart';
import 'package:provider/provider.dart';

import '../../providers/sign_in_provider.dart';
import '../../utils/GraphQL.dart';
import '../../utils/nav_bar.dart';
import '../../utils/next_screen.dart';

class ToursTravels extends StatefulWidget {
  const ToursTravels({super.key});

  @override
  State<ToursTravels> createState() => _ToursTravelsState();
}

class _ToursTravelsState extends State<ToursTravels> {
  final locationController = TextEditingController();
  String currentLocation = "";

  final typeController = TextEditingController(text: 'Tours & Travels');

  final titleController = TextEditingController();
  String title = "";

  final _textDes = TextEditingController();
  String description = "";


  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    setState(() {
      currentLocation =
      '${placemarks[0].locality}, ${placemarks[0].administrativeArea}';
      locationController.text = currentLocation;
    });
  }

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
    getLocation();
  }

  File? file;
  final ImagePicker picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePhotoWithCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
      });
    }
  }

  Widget _displayImage() {
    if (file == null) {
      return Text('No image selected.');
    } else {
      return Image.file(File(file!.path));
    }
  }


  @override
  Widget build(BuildContext context) {

    final sp = context.watch<SignInProvider>();

    _createServiceUpload() async {
      var request = http.MultipartRequest('POST', Uri.parse('${httpLinkC}/serviceupload/'));
      request.fields.addAll({
        'flipperUser': "${sp.uid}",
        'serviceType': "Tours& Travels",
        'serviceTitle': "${title}",
        'serviceDescription': "${description}",
        'serviceLocation': "${currentLocation}",
      });
      request.files.add(await http.MultipartFile.fromPath('serviceImage', file!.path.toString()));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(response);
      }
      else {
        print(response.reasonPhrase);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          "Service Details",
          style: TextStyle(
            color: Color(0xFF333333),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SelectService()),
            );
          },
          icon: const Icon(
            CupertinoIcons.arrow_left,
            color: Color(0xFF333333),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            TextField(
              controller: typeController,
              readOnly: true,
              cursorColor: Color(0xFF4EDB86),
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                labelText: 'Type',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xFF4EDB86),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: titleController,
              onChanged: (value){
                setState(() {
                  title = value;
                });
              },
              cursorColor: Color(0xFF4EDB86),
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                labelText: 'Title',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xFF4EDB86),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _textDes,
              onChanged: (value){
                setState(() {
                  description = value;
                });
              },
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onTap: () {},
              cursorColor: Color(0xFF4EDB86),
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                labelText: 'Description',
                border: UnderlineInputBorder(),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xFF4EDB86),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(child: _displayImage(),),
            ElevatedButton(onPressed: (){_showBottomSheet(context);}, child: Text("Add Image"),),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: locationController,
              onChanged: (value) {
                setState(() {
                  currentLocation = value;
                });
              },
              cursorColor: Color(0xFF4EDB86),
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                labelText: 'Location',
                border: UnderlineInputBorder(),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xFF4EDB86),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Color(0xFF4EDB86)),
            child: const Text(
              'Upload',
              style: TextStyle(color: Color(0xFF333333)),
            ),
            onPressed: () async{
              setState(() {
                currentLocation = locationController.text;
              });
              _createServiceUpload();
              const snack = SnackBar(
                content: Text('Service Uploaded Successfully', style: TextStyle(
                    color: Colors.white),),
                backgroundColor: Color(0xFF4EDb86),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(15),
              );
              ScaffoldMessenger.of(context).showSnackBar(snack);
              nextScreenReplace(context, NavBar());
            },
          ),
        ),
      ),
    );
  }
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Take a Photo'),
              onTap: () {
                _takePhotoWithCamera();
                // Handle take photo option
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                _pickImageFromGallery();
                // Handle choose from gallery option
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
