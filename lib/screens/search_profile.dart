import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mazha_app/screens/view_profile.dart';
import 'package:mazha_app/utils/next_screen.dart';
import 'package:provider/provider.dart';
import '../providers/sign_in_provider.dart';

class ProfileSearch extends StatefulWidget {
  const ProfileSearch({super.key});

  @override
  State<ProfileSearch> createState() => _ProfileSearchState();
}

class _ProfileSearchState extends State<ProfileSearch> {
  String name = "";
  bool check_searchicon_color = false;

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Search Profiles'),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: TextField(
              onTap: () {
                setState(() {
                  check_searchicon_color = true;
                });
              },
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              cursorColor: Color(0xFF4EDB86),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                fillColor: Colors.black12.withOpacity(0.05),
                hintText: 'Search',
                prefixIcon: Icon(
                  Icons.search,
                  color: check_searchicon_color == true
                      ? Color(0xFF4EDB86)
                      : Colors.black,
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshots) {
              return (snapshots.connectionState == ConnectionState.waiting)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Flexible(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.78,
                        child: ListView.builder(
                          itemCount: snapshots.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshots.data!.docs[index].data()
                                as Map<String, dynamic>;
                            if (name.isEmpty && data['uid'] != '${sp.uid}') {
                              return ListTile(
                                onTap: (){
                                  nextScreen(context, ViewProfile(userId: data['uid']));
                                },
                                title: Text(
                                  data[
                                      'name'], // Use 'name' as the key to access the name field
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.black),
                                ),
                                subtitle: Text(
                                  data[
                                      'email'], // Use 'email' as the key to access the email field
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.black),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(data['image_url']),
                                ),
                              );
                            }
                            if (data['name']
                                .toString()
                                .toLowerCase()
                                .startsWith(name.toLowerCase()) && data['uid'] != '${sp.uid}') {
                                return ListTile(
                                  onTap: (){
                                    nextScreen(context, ViewProfile(userId: data['uid']));
                                  },
                                  title: Text(
                                    data[
                                        'name'], // Use 'name' as the key to access the name field
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    data[
                                        'email'], // Use 'email' as the key to access the email field
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(data['image_url']),
                                  ),
                                );
                              }
                            return SizedBox();
                          },
                        ),

                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
