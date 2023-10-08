import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mazha_app/utils/next_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../providers/sign_in_provider.dart';
import '../utils/GraphQL.dart';
import '../utils/nav_bar.dart';

class BuildProfile extends StatefulWidget {
  const BuildProfile({super.key});

  static String userId = "";
  static String userName = "";
  static String email = "";
  static String phoneNumber = "";
  static String country = "";
  static String currentLocation = "";
  static String bio = "";

  @override
  State<BuildProfile> createState() => _BuildProfileState();
}

class _BuildProfileState extends State<BuildProfile> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController countryctrl = TextEditingController();
  TextEditingController locationctrl = TextEditingController();
  TextEditingController phonectrl = TextEditingController();
  TextEditingController bioctrl = TextEditingController();

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    setState(() {
      countryctrl.text = '${placemarks[0].country}';
      locationctrl.text =
          '${placemarks[0].locality}, ${placemarks[0].administrativeArea}';
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

  _uploadUser() async {
    var request =
        http.MultipartRequest('POST', Uri.parse('${httpLinkC}/user/'));

    request.fields.addAll({
      'flipperUser': "${BuildProfile.userId}",
      'username': "${BuildProfile.userName}",
      'emailAddress': "${BuildProfile.email}",
      'mobileNumber': "${BuildProfile.phoneNumber}",
      'country': "${BuildProfile.country}",
      'userLocation': "${BuildProfile.currentLocation}",
      'userBio': "${BuildProfile.bio}"
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(response);
    } else {
      print(response.reasonPhrase);
    }
  }

  String? nameError;
  String? phoneNumberError;
  String? bio;

  void _showSnackBar({
    required BuildContext context, // Accept BuildContext as a parameter
    required String title,
    required String message,
    required ContentType contentType,
    required Color backgroundColor,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 2),
      elevation: 0,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    TextEditingController userEmail =
        TextEditingController(text: '${sp.email}');
    TextEditingController userctrl = TextEditingController(text: '${sp.name}');

    bool validate(BuildContext context) {
      nameError = null;
      bio = null;
      phoneNumberError = null;

      if (userctrl.text.isEmpty) {
        nameError = "Username is required";
        _showSnackBar(
          title: 'Validation Error',
          message: nameError!,
          contentType: ContentType.warning,
          backgroundColor: Colors.transparent,
          context: context,
        );
        return false;
      }

      if (phonectrl.text.isEmpty) {
        phoneNumberError = "Phone Number is required";
        _showSnackBar(
          context: context,
          title: 'Validation Error',
          message: phoneNumberError!,
          contentType: ContentType.warning,
          backgroundColor: Colors.transparent,
        );
        return false;
      }

      else if (phonectrl.text.length != 10) {
        phoneNumberError = "Phone Number must have exactly 10 digits";
        _showSnackBar(
          context: context,
          title: 'Validation Error',
          message: phoneNumberError!,
          contentType: ContentType.warning,
          backgroundColor: Colors.transparent,
        );
        return false;
      }
      return true;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Flipper Profile',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 40,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage("${sp.imageUrl}"),
                  radius: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: userctrl,
                  onChanged: (value){
                    setState(() {
                      BuildProfile.userName = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: UnderlineInputBorder(),
                    errorText: (userctrl.text.length < 5 && userctrl.text.isNotEmpty)
                        ? 'Username must be at least 5 characters'
                        : null,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: userEmail,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: phonectrl,
                  onChanged: (value) {
                    BuildProfile.phoneNumber = value;
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: countryctrl,
                  decoration: InputDecoration(
                    labelText: 'Country',
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: locationctrl,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: bioctrl,
                  onChanged: (value) {
                    BuildProfile.bio = value;
                  },
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: 'Bio',
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        BuildProfile.userId = '${sp.uid}';
                        BuildProfile.email = userEmail.text;
                        BuildProfile.currentLocation = locationctrl.text;
                        BuildProfile.country = countryctrl.text;
                      });
                      if (validate(context)) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Profile Created',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Color(0xFF4EDb86),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(15),
                        ));
                        // Delay for 2 seconds
                        await Future.delayed(
                          Duration(seconds: 1),
                        );

                        nextScreenReplace(context, NavBar());
                      }
                      _uploadUser();
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(
                  height: 90,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
