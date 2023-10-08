import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:mazha_app/screens/view_profile.dart';
import 'package:mazha_app/utils/next_screen.dart';
import '../../utils/GraphQL.dart';

class ViewFurniture extends StatefulWidget {
  const ViewFurniture(
      {super.key,
        required this.userId,
        required this.furnitureType,
        required this.furnitureTitle,
        required this.furnitureDescription,
        required this.furnitureLocation,
        required this.furniturePrice,
        required this.furnitureImage});

  final String userId;
  final String furnitureType;
  final String furnitureTitle;
  final String furnitureDescription;
  final String furnitureLocation;
  final String furniturePrice;
  final String furnitureImage;
  static String id = "";

  @override
  State<ViewFurniture> createState() => _ViewFurnitureState();
}

class _ViewFurnitureState extends State<ViewFurniture> {
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

  Widget build(BuildContext context) {
    ViewFurniture.id = widget.userId;

    final String getUserQuery = '''
     query{
      usersbyid(flipperUser: "${ViewFurniture.id}"){
        username
        emailAddress
  }
}
''';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.heart)),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image(
                  image: NetworkImage(widget.furnitureImage),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:20, right: 20, top: 10),
              child: Row(
                children: [
                  Text(
                    '₹ ${widget.furniturePrice} /-', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.visible,
                      '${widget.furnitureTitle}',
                      style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Row(
                children: [
                  Icon(Icons.location_on),
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.visible,
                      '${widget.furnitureLocation}',
                      style:
                      TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 5),
                child: Divider(
                  thickness: 2,
                )),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "About",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 30,
                        child: Row(
                          children: [
                            Text(
                              "Furniture Type ",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 15),
                            ),
                            Spacer(),
                            Text(
                              " : ",
                              textAlign: TextAlign.right,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${widget.furnitureType}',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 5),
                child: Divider(
                  thickness: 2,
                )),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.description),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Description",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${widget.furnitureDescription}',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                child: Divider(
                  thickness: 2,
                )),
            ListTile(
              onTap: () {
                nextScreen(context, ViewProfile(userId: widget.userId));
              },
              leading: FutureBuilder<String?>(
                future: getImageURLForUID(widget.userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final imageUrl = snapshot.data;

                    return CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(imageUrl!),
                      radius: 30,
                    );
                  }
                },
              ),
              title: GraphQLProvider(
                client: client,
                child: graphql.Query(
                  options: QueryOptions(
                    document: gql(getUserQuery),
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
                    final Map<String, dynamic> data = result.data?['usersbyid'];
                    if (data.isEmpty) {
                      return const Center(child: Text("No user Found !!"));
                    }
                    return Text(
                      '${data['username']}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ),
              subtitle: GraphQLProvider(
                client: client,
                child: graphql.Query(
                  options: QueryOptions(
                    document: gql(getUserQuery),
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
                    final Map<String, dynamic> data = result.data?['usersbyid'];
                    if (data.isEmpty) {
                      return const Center(child: Text("No user Found !!"));
                    }
                    return Text(
                      '${data['emailAddress']}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    top: 5, left: 10, right: 10, bottom: 20),
                child: Divider(
                  thickness: 2,
                )),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 40,
                  child: Center(
                    child: Text(
                      'Make Offer',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF4EDB86),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 40,
                  child: Center(
                    child: Text(
                      'Chat',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
