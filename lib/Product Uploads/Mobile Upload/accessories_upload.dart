import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/sign_in_provider.dart';
import '../../utils/nav_bar.dart';
import '../../utils/next_screen.dart';
import 'mob_cat.dart';
import '../../utils/GraphQL.dart';

class AccessoriesUpload extends StatefulWidget {
  const AccessoriesUpload({super.key});

  @override
  State<AccessoriesUpload> createState() => _AccessoriesUploadState();
}

class _AccessoriesUploadState extends State<AccessoriesUpload> {

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

  @override
  void initState() {
    super.initState();
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

  final locationController = TextEditingController();
  String currentLocation = "";

  final _textDes = TextEditingController();
  String description = "";

  final _textTitle = TextEditingController();
  String title = "";

  final _textPrice = TextEditingController();
  String price = "";
  bool rupee_symbol = false;

  String type = "";
  bool type_box1 = false;
  bool type_box2 = false;
  bool type_box3 = false;

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();

    _createMobileAccessoriesUpload() async {
      var request = http.MultipartRequest('POST', Uri.parse('${httpLinkC}/mobileupload/'));
      request.fields.addAll({
        'flipperUser': "${sp.uid}",
        'flipperType': "${type} Asseccsory",
        'accessoryType' : "${type}",
        'mobileBrand' : "",
        'mobileTitle': "${title}",
        'mobileDescription': "${description}",
        'mobileLocation': "${currentLocation}",
        'mobilePrice': "${price}",
      });
      request.files.add(await http.MultipartFile.fromPath('mobileImage', file!.path.toString()));

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
          "Accessory Details",
          style: TextStyle(
            color: Color(0xFF333333),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SelectMobile()),
            );
          },
          icon: const Icon(
            CupertinoIcons.arrow_left,
            color: Color(0xFF333333),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Type",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          type = "Mobile";
                          type_box1 = true;
                          type_box2 = false;
                          type_box3 = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: type_box1 == true
                              ? Color(0xFF4EDB86).withOpacity(0.1)
                              : Colors.white,
                          border: Border.all(
                              color: type_box1 == true
                                  ? Color(0xFF4EDB86)
                                  : Color(0xFF333333)),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        height: 45,
                        width: 100,
                        child: Center(
                            child: Text(
                              "Mobile",
                              style: TextStyle(color: Colors.black, fontSize: 18),
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          type = "Tablet";
                          type_box2 = true;
                          type_box1 = false;
                          type_box3 = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: type_box2 == true
                              ? Color(0xFF4EDB86).withOpacity(0.1)
                              : Colors.white,
                          border: Border.all(
                              color: type_box2 == true
                                  ? Color(0xFF4EDB86)
                                  : Color(0xFF333333)),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        height: 45,
                        width: 100,
                        child: Center(
                            child: Text(
                              "Tablet",
                              style: TextStyle(color: Colors.black, fontSize: 18),
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          type = "Mobile & Tablet";
                          type_box3 = true;
                          type_box2 = false;
                          type_box1 = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: type_box3 == true
                              ? Color(0xFF4EDB86).withOpacity(0.1)
                              : Colors.white,
                          border: Border.all(
                              color: type_box3 == true
                                  ? Color(0xFF4EDB86)
                                  : Color(0xFF333333)),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        height: 45,
                        width: 100,
                        child: Center(
                            child: Text(
                              "Both",
                              style: TextStyle(color: Colors.black, fontSize: 18),
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _textTitle,
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
            SizedBox(child: _displayImage(),),
            ElevatedButton(onPressed: (){_showBottomSheet(context);}, child: Text("Add Image"),),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _textDes,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onChanged: (value){
                setState(() {
                  description = value;
                });
              },
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
            TextField(
              controller: locationController,
              onChanged: (value){
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
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _textPrice,
              keyboardType: TextInputType.numberWithOptions(),
              onChanged: (value){
                setState(() {
                  price = value;
                });
              },
              onTap: () {
                setState(() {
                  rupee_symbol = true;
                });
              },
              onEditingComplete: () {
                setState(() {
                  rupee_symbol = false;
                });
              },
              cursorColor: Color(0xFF4EDB86),
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                prefixIcon: Icon(
                  Icons.currency_rupee,
                  color:
                  rupee_symbol == true ? Color(0xFF4EDB86) : Colors.black,
                ),
                labelText: 'Price',
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
            onPressed: () {
              setState(() {
                currentLocation = locationController.text;
              });
              const snack = SnackBar(
                content: Text('Product Uploaded Successfully', style: TextStyle(
                    color: Colors.white),),
                backgroundColor: Color(0xFF4EDb86),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(15),
              );
              _createMobileAccessoriesUpload();
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
