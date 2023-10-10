import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mazha_app/screens/edit_profile.dart';
import 'package:mazha_app/screens/reports.dart';
import 'package:mazha_app/screens/search_profile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/profile_provider.dart';
import '../providers/sign_in_provider.dart';
import '../utils/GraphQL.dart';
import '../utils/next_screen.dart';
import 'login_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  static String userName = "";
  static String email = "";
  static String phoneNumber = "";
  static String country = "";
  static String currentLocation = "";
  static String bio = "";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  bool hd_imageSwitch = false;
  bool storage_switch = false;
  bool location_switch = false;
  bool camera_switch = false;
  bool notification_switch = false;



  Future<void> loadSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      hd_imageSwitch = prefs.getBool('hd_imageSwitch') ?? false;
      storage_switch = prefs.getBool('storage_switch') ?? false;
      location_switch = prefs.getBool('location_switch') ?? false;
      camera_switch = prefs.getBool('camera_switch') ?? false;
      notification_switch = prefs.getBool('notification_switch') ?? false;
    });
  }

  Future<void> saveSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('hd_imageSwitch', hd_imageSwitch);
    prefs.setBool('storage_switch', storage_switch);
    prefs.setBool('location_switch', location_switch);
    prefs.setBool('camera_switch', camera_switch);
    prefs.setBool('notification_switch', notification_switch);
  }

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
    loadSwitchState();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    final String getUsersQuery = '''
    query{
      usersbyid(flipperUser: "${sp.uid}"){
        flipperUser
        username
        emailAddress
        mobileNumber
        country
        userLocation
        userBio
  }
}
''';

    return GraphQLProvider(
      client: client,
      child: Query(
        options: QueryOptions(
          document: gql(getUsersQuery),
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            print(result.exception.toString());
            return Center(child: CircularProgressIndicator());
          }

          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          final Map<String, dynamic> data = result.data?['usersbyid'];

          if (data.isEmpty) {
            return const Text('No User found');
          }

          Profile.userName = data['username'];
          Profile.email = data['emailAddress'];
          Profile.phoneNumber = data['mobileNumber'];
          Profile.country = data['country'];
          Profile.currentLocation = data['userLocation'];
          Profile.bio = data['userBio'];

          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              backgroundColor: Colors.grey.shade100,
              elevation: 0,
              automaticallyImplyLeading: false,
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    nextScreen(context, ProfileSearch());
                  },
                  icon: Icon(Icons.search),
                )
              ],
              title: Text(
                'Profile',
                style: TextStyle(color: Color(0xFF333333), fontSize: 25),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage("${sp.imageUrl}"),
                            radius: 50,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${Profile.userName}",
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "4.5/5",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF333333),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      nextScreenReplace(context, EditProfile());
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF4EDB86),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Edit Profile",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      sp.userSignOut();
                                      nextScreen(context, const LoginScreen());
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Sign Out",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Wrap(
                      children: [Text("${Profile.bio}")],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.account_circle_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Account",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "E-mail",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                Text('${Profile.email}'),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Phone Number",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                Text("${Profile.phoneNumber}"),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                Text("${Profile.currentLocation}"),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Country",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                Text("${Profile.country}"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Info",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Bought",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                Text(
                                  '20',
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Sold",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                Text(
                                  '20',
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Bids",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                Text(
                                  '20',
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Barter",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                Text(
                                  '20',
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.menu,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Options",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Notification",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                const Spacer(),
                                buildPermissionSwitch(
                                  // permission: Permission.notification,
                                  switchValue: notification_switch,
                                  onChanged: (value) async {
                                    // final status = await _requestPermission(Permission.notification);
                                    PermissionStatus status = await Permission.notification.request();
                                    setState(() {
                                      if (status.isGranted) {
                                        notification_switch = value;
                                      } else {
                                        notification_switch = false;
                                        if (status.isPermanentlyDenied) {
                                          _openAppSettings();
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('This permission is recommended')),
                                          );
                                        }
                                      }
                                      saveSwitchState();
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                buildPermissionSwitch(
                                  // permission: Permission.location,
                                  switchValue: location_switch,
                                  onChanged: (value) async {
                                    final status = await _requestPermission(Permission.location);
                                    setState(() {
                                      if (status.isGranted) {
                                        location_switch = value;
                                      } else {
                                        location_switch = false;
                                        if (status.isPermanentlyDenied) {
                                          _openAppSettings();
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('This permission is recommended')),
                                          );
                                        }
                                      }
                                      saveSwitchState();
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Camera",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                const Spacer(),
                                buildPermissionSwitch(
                                  // permission: Permission.camera,
                                  switchValue: camera_switch,
                                  onChanged: (value) async {
                                    final status = await _requestPermission(Permission.camera);
                                    setState(() {
                                      if (status.isGranted) {
                                        camera_switch = value;
                                      } else {
                                        camera_switch = false;
                                        if (status.isPermanentlyDenied) {
                                          _openAppSettings();
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('This permission is recommended')),
                                          );
                                        }
                                      }
                                      saveSwitchState();
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Storage",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                const Spacer(),
                                buildPermissionSwitch(
                                  // permission: Permission.storage,
                                  switchValue: storage_switch,
                                  onChanged: (value) async {
                                    final status = await _requestPermission(Permission.storage);
                                    setState(() {
                                      if (status.isGranted) {
                                        storage_switch = value;
                                      } else {
                                        storage_switch = false;
                                        if (status.isPermanentlyDenied) {
                                          _openAppSettings();
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('This permission is recommended')),
                                          );
                                        }
                                      }
                                      saveSwitchState();
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "HD Images",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                const Spacer(),
                                CupertinoSwitch(
                                    value: hd_imageSwitch, onChanged: (value) {
                                  setState(() {
                                    hd_imageSwitch = value;
                                  });
                                }),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.question_mark_outlined,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "About Flipper",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                )
                              ],
                            ),
                            // SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Share this App",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.share,
                                      size: 20,
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Rate this App",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.star,
                                      size: 20,
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Terms & Condition",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.receipt_long,
                                      size: 20,
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Privacy",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.privacy_tip_outlined,
                                      size: 20,
                                    ))
                              ],
                            ),
                            GestureDetector(
                              onTap: (){
                                nextScreen(context, Reports());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Reports",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.bar_chart,
                                        size: 20,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 65,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget buildPermissionSwitch({
    // required Permission permission,
    required bool switchValue,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoSwitch(
          value: switchValue,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Future<PermissionStatus> _requestPermission(Permission permission) async {
    final status = await permission.request();
    return status;
  }

  void _openAppSettings() {
    openAppSettings();
  }
}
