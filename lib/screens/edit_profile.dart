import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql/client.dart';
import 'package:mazha_app/screens/profile.dart';
import 'package:mazha_app/utils/next_screen.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../providers/sign_in_provider.dart';
import '../utils/GraphQL.dart';
import '../utils/nav_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController unamectrl = TextEditingController(text: '${Profile.userName}');
  TextEditingController emailctrl = TextEditingController(text: '${Profile.email}');
  TextEditingController countryctrl = TextEditingController(text: '${Profile.country}');
  TextEditingController locationctrl = TextEditingController(text: '${Profile.currentLocation}');
  TextEditingController phonectrl = TextEditingController(text: '${Profile.phoneNumber}');
  TextEditingController bioctrl = TextEditingController(text: '${Profile.bio}');

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  String uid = "";
  String uname = "";
  String email = "";
  String pnum = "";
  String ubio = "";
  String uLoc = "";
  String uCountry = "";

  // _updateUser() async {
  //   var request = http.MultipartRequest('POST', Uri.parse('${httpLinkC}/user/'));
  //
  //   request.fields.addAll({
  //     'flipperUser': "${EditProfile.userId}",
  //     'username': "${EditProfile.userName}",
  //     'emailAddress': "${EditProfile.emamil}",
  //     'mobileNumber': "${EditProfile.phoneNumber}",
  //     'country': "${EditProfile.country}",
  //     'userLocation': "${EditProfile.currentLocation}",
  //     'userBio': "${EditProfile.bio}"
  //   });
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     print(response);
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }

  Future<void> _updateUser() async {
    final String updateUserMutation = ''' 
    mutation update{
      updateUser(flipperUser: "${uid}", username: "${uname}", emailAddress:"${email}", mobileNumber:"${pnum}", country: "${uCountry}", userLocation: "${uLoc}", userBio: "${ubio}"){
          user{
          username
          emailAddress
          mobileNumber
          country
          userLocation
          userBio
      }
    }
  }''';
    final GraphQLClient _client = client.value;

    final MutationOptions options = MutationOptions(
      document: gql(updateUserMutation),
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      print('Error creating user: ${result.exception.toString()}');
    } else {
      print('User Updated successfully!');
    }
  }

  @override
  Widget build(BuildContext context) {

    final sp = context.watch<SignInProvider>();
    uid = "${sp.uid}";

    final userProfileProvider = context.read<ProfileProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Edit Profile",
          style: TextStyle(color: Color(0xFF333333), fontSize: 25),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage("${sp.imageUrl}"),
                radius: 50,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: unamectrl,
                onChanged: (value){
                  uname = value;
                },
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: emailctrl,
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
              ElevatedButton(onPressed: (){
                setState(() {
                  uname = unamectrl.text;
                  email = emailctrl.text;
                  pnum = phonectrl.text;
                  uLoc = locationctrl.text;
                  uCountry = countryctrl.text;
                  ubio = bioctrl.text;
                });
                const snack = SnackBar(
                  content: Text('Profile Updated', style: TextStyle(
                      color: Colors.white),),
                  backgroundColor: Color(0xFF4EDb86),
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(15),
                );
                ScaffoldMessenger.of(context).showSnackBar(snack);
                _updateUser();
                // userProfileProvider.updateUserProfile(UserProfile as UserProfile);
                nextScreenReplace(context, NavBar());
              }, child: Text("Save Changes", style: TextStyle(color: Colors.white),)),
              SizedBox(height: 90,)
            ],
          ),
        ),
      ),
    );
  }
}
