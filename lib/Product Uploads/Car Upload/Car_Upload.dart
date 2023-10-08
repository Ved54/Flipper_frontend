import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mazha_app/screens/sell.dart';
import 'package:mazha_app/utils/next_screen.dart';
import 'package:provider/provider.dart';

import '../../utils/GraphQL.dart';
import '../../providers/sign_in_provider.dart';
import '../../utils/nav_bar.dart';

class UploadCar extends StatefulWidget {
  const UploadCar({super.key});


  @override
  State<UploadCar> createState() => _UploadCarState();
}

class _UploadCarState extends State<UploadCar> {

  final locationController = TextEditingController();
  String currentLocation = "";

  final _textBrand = TextEditingController();
  String brand = "";

  final _textModel = TextEditingController();
  String model = "";

  final _textVariant = TextEditingController();
  String variant = "";

  final _textYear = TextEditingController();
  String year = "";

  final _textFuel = TextEditingController();
  String fuel = "";

  final _textKmD = TextEditingController();
  String kmD = "";

  final _textOwn = TextEditingController();
  String own = "";

  final _textDes = TextEditingController();
  String description = "";

  final _textPrice = TextEditingController();
  String price = "";
  bool rupee_symbol = false;


  String trans = "";
  bool trans_box1 = false;
  bool trans_box2 = false;

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

    _createCarUpload() async {
      var request = http.MultipartRequest('POST', Uri.parse('${httpLinkC}/carupload/'));
      request.fields.addAll({
        'flipperUser': "${sp.uid}",
        'carBrand': "${brand}",
        'carModel': "${model}",
        'carVariant': "${variant}",
        'carYear': "${year}",
        'carFuelType': "${fuel}",
        'carTransmission': "${trans}",
        'carKmDriven': "${kmD}",
        'carOwnerNum': "${own}",
        'carDescription': "${description}",
        'carLocation': "${currentLocation}",
        'carPrice': "${price}",
      });
      request.files.add(await http.MultipartFile.fromPath('carImage', file!.path.toString()));

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
          "Car Details",
          style: TextStyle(
            color: Color(0xFF333333),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Sell()),
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
              controller: _textBrand,
              onChanged: (value){
                setState(() {
                  brand = value;
                });
              },
              cursorColor: Color(0xFF4EDB86),
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                labelText: 'Brand',
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
              controller: _textModel,
              onChanged: (value){
                model = value;
              },
              cursorColor: Color(0xFF4EDB86),
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                labelText: 'Model',
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
              controller: _textVariant,
              onChanged: (value){
                setState(() {
                  variant = value;
                });
              },
              onTap: () {},
              cursorColor: Color(0xFF4EDB86),
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                labelText: 'Variant',
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
              controller: _textYear,
              keyboardType: TextInputType.numberWithOptions(),
              onTap: () {},
              onChanged: (value){
                setState(() {
                  year = value;
                });
              },
              cursorColor: Color(0xFF4EDB86),
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                labelText: 'Year',
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
              controller: _textFuel,
              onTap: () {},
              onChanged: (value){
                setState(() {
                  fuel = value;
                });
              },
              cursorColor: Color(0xFF4EDB86),
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                labelText: 'Fuel',
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transmission",
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
                          trans = "Automatic";
                          trans_box1 = true;
                          trans_box2 = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: trans_box1 == true
                              ? Color(0xFF4EDB86).withOpacity(0.1)
                              : Colors.white,
                          border: Border.all(
                              color: trans_box1 == true
                                  ? Color(0xFF4EDB86)
                                  : Color(0xFF333333)),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        height: 45,
                        width: 150,
                        child: Center(
                            child: Text(
                          "Automatic",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          trans = "Manual";
                          trans_box2 = true;
                          trans_box1 = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: trans_box2 == true
                              ? Color(0xFF4EDB86).withOpacity(0.1)
                              : Colors.white,
                          border: Border.all(
                              color: trans_box2 == true
                                  ? Color(0xFF4EDB86)
                                  : Color(0xFF333333)),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        height: 45,
                        width: 150,
                        child: Center(
                            child: Text(
                          "Manual",
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
              controller: _textKmD,
              keyboardType: TextInputType.numberWithOptions(),
              onTap: () {},
              onChanged: (value){
                setState(() {
                  kmD = value;
                });
              },
              cursorColor: Color(0xFF4EDB86),
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                labelText: 'Km Driven',
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
              controller: _textOwn,
              keyboardType: TextInputType.numberWithOptions(),
              onTap: () {},
              onChanged: (value){
                setState(() {
                  own = value;
                });
              },
              cursorColor: Color(0xFF4EDB86),
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                labelText: 'No. of Owners',
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
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _textPrice,
              onChanged: (value){
                setState(() {
                  price = value;
                });
              },
              keyboardType: TextInputType.numberWithOptions(),
              onTap: () {
                setState(() {
                  rupee_symbol = true;
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
            onPressed: () async{
              setState(() {
                currentLocation = locationController.text;
              });
              _createCarUpload();
              const snack = SnackBar(
                content: Text('Product Uploaded Successfully', style: TextStyle(
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

