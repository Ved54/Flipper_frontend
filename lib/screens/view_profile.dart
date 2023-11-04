import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mazha_app/screens/search_profile.dart';
import 'package:mazha_app/utils/next_screen.dart';
import '../Chats/screens/chat_screen.dart';
import '../utils/GraphQL.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key, required this.userId});

  final String userId;
  static String id = "";
  static String userName = "";
  static String email = "";
  static String phoneNumber = "";
  static String country = "";
  static String currentLocation = "";
  static String bio = "";

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  Future<String?> getImageURLForUID(String uid) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final DocumentSnapshot userDocument = snapshot.docs.first;
        final String imageURL = userDocument['image_url'];
        return imageURL;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching image URL: $e');
      return null;
    }
  }

  // widget.userId
  @override
  Widget build(BuildContext context) {
    ViewProfile.id = widget.userId;
    final String getUsersQuery = '''
    query{
      usersbyid(flipperUser: "${ViewProfile.id}"){
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

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 55,
                  width: double.infinity,
                  color: Color(0xFF4EDB86),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        right: 330,
                        child: IconButton(
                          onPressed: (){
                            nextScreenReplace(context, ProfileSearch());
                          },
                          icon: Icon(Icons.arrow_back_outlined, size: 30),
                        ),
                      ),
                      Center(child: Text("Flipper User", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),))
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.34,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 100,
                        right: 0,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF4EDB86),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40))),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        bottom: 0,
                        right: 40,
                        left: 40,
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 2.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: FutureBuilder<String?>(
                                    future: getImageURLForUID(widget.userId),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        // If the Future is still running, show a loading indicator.
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        // If an error occurs, show an error message.
                                        return Center(
                                            child:
                                                Text('Error: ${snapshot.error}'));
                                      } else {
                                        // If the Future has completed successfully, display the user's profile.
                                        final imageUrl = snapshot.data;

                                        return CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage: NetworkImage(
                                              imageUrl!), // Provide a default image
                                          radius: 45,
                                        );
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GraphQLProvider(
                                  client: client,
                                  child: graphql.Query(
                                    options: QueryOptions(
                                      document: gql(getUsersQuery),
                                    ),
                                    builder: (QueryResult result,
                                        {fetchMore, refetch}) {
                                      if (result.hasException) {
                                        print("Exception");
                                        print(result.exception.toString());
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }

                                      if (result.isLoading) {
                                        print("Loading");
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }

                                      final Map<String, dynamic> data =
                                          result.data?['usersbyid'];

                                      if (data == null) {
                                        return const Text('No User found');
                                      }

                                      ViewProfile.userName = data['username'];

                                      return Text(
                                        "${ViewProfile.userName}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.location_on),
                                    GraphQLProvider(
                                      client: client,
                                      child: graphql.Query(
                                        options: QueryOptions(
                                          document: gql(getUsersQuery),
                                        ),
                                        builder: (QueryResult result, {fetchMore, refetch}) {
                                          if (result.hasException) {
                                            print("Exception");
                                            print(result.exception.toString());
                                            return Center(child: CircularProgressIndicator());
                                          }

                                          if (result.isLoading) {
                                            print("Loading");
                                            return Center(child: CircularProgressIndicator());
                                          }

                                          final Map<String, dynamic> data =
                                          result.data?['usersbyid'];

                                          if (data == null) {
                                            return const Text('No User found');
                                          }

                                          ViewProfile.currentLocation = data['userLocation'];

                                          return Text("${ViewProfile.currentLocation}");
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "4/5",
                                      style:
                                          TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "101 reviews",
                                      style:
                                          TextStyle(fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _showRatingDialog(context);
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
                                            "Rate",
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
                                        nextScreen(context, ChatScreen(userId: widget.userId));
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Message",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style:
                            TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Wrap(
                    children: [
                      GraphQLProvider(
                        client: client,
                        child: graphql.Query(
                          options: QueryOptions(
                            document: gql(getUsersQuery),
                          ),
                          builder: (QueryResult result, {fetchMore, refetch}) {
                            if (result.hasException) {
                              print("Exception");
                              print(result.exception.toString());
                              return Center(child: CircularProgressIndicator());
                            }

                            if (result.isLoading) {
                              print("Loading");
                              return Center(child: CircularProgressIndicator());
                            }

                            final Map<String, dynamic> data =
                                result.data?['usersbyid'];

                            if (data == null) {
                              return const Text('No User found');
                            }

                            ViewProfile.bio = data['userBio'];

                            return Text("${ViewProfile.bio}");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Email : ', style: TextStyle(fontWeight: FontWeight.w500),),
                      SizedBox(width: 5,),
                      GraphQLProvider(
                        client: client,
                        child: graphql.Query(
                          options: QueryOptions(
                            document: gql(getUsersQuery),
                          ),
                          builder: (QueryResult result, {fetchMore, refetch}) {
                            if (result.hasException) {
                              print("Exception");
                              print(result.exception.toString());
                              return Center(child: CircularProgressIndicator());
                            }

                            if (result.isLoading) {
                              print("Loading");
                              return Center(child: CircularProgressIndicator());
                            }

                            final Map<String, dynamic> data =
                            result.data?['usersbyid'];

                            if (data == null) {
                              return const Text('No User found');
                            }

                            ViewProfile.email = data['emailAddress'];

                            return Text("${ViewProfile.email}", style: TextStyle(fontSize: 15));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Phone Number : ', style: TextStyle(fontWeight: FontWeight.w500),),
                      SizedBox(width: 5,),
                      GraphQLProvider(
                        client: client,
                        child: graphql.Query(
                          options: QueryOptions(
                            document: gql(getUsersQuery),
                          ),
                          builder: (QueryResult result, {fetchMore, refetch}) {
                            if (result.hasException) {
                              print("Exception");
                              print(result.exception.toString());
                              return Center(child: CircularProgressIndicator());
                            }

                            if (result.isLoading) {
                              print("Loading");
                              return Center(child: CircularProgressIndicator());
                            }

                            final Map<String, dynamic> data =
                            result.data?['usersbyid'];

                            if (data == null) {
                              return const Text('No User found');
                            }

                            ViewProfile.phoneNumber = data['mobileNumber'];

                            return Text("${ViewProfile.phoneNumber}", style: TextStyle(fontSize: 15));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Country : ', style: TextStyle(fontWeight: FontWeight.w500),),
                      SizedBox(width: 5,),
                      GraphQLProvider(
                        client: client,
                        child: graphql.Query(
                          options: QueryOptions(
                            document: gql(getUsersQuery),
                          ),
                          builder: (QueryResult result,
                              {fetchMore, refetch}) {
                            if (result.hasException) {
                              print("Exception");
                              print(result.exception.toString());
                              return Center(
                                  child: CircularProgressIndicator());
                            }

                            if (result.isLoading) {
                              print("Loading");
                              return Center(
                                  child: CircularProgressIndicator());
                            }

                            final Map<String, dynamic> data =
                            result.data?['usersbyid'];

                            if (data == null) {
                              return const Text('No User found');
                            }

                            ViewProfile.country = data['country'];

                            return Text(
                              "${ViewProfile.country}", style: TextStyle(fontSize: 15),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _showRatingDialog(BuildContext context) async {
    double userRating = 0.0;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Rate this user"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RatingBar.builder(
                initialRating: userRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  userRating = rating;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Rate"),
              onPressed: () {
                // Do something with the userRating, e.g., print it
                print("User rating: $userRating");

                // Close the dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

