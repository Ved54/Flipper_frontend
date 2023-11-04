import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mazha_app/Product%20Uploads/Barter%20Upload/View_barter.dart';
import 'package:provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:http/http.dart' as http;
import '../Product Uploads/Barter Upload/barter_upload.dart';
import '../providers/sign_in_provider.dart';
import '../utils/GraphQL.dart';
import '../utils/nav_bar.dart';
import '../utils/next_screen.dart';

class Barter extends StatefulWidget {
  const Barter({super.key});

  @override
  State<Barter> createState() => _BarterState();
}

class _BarterState extends State<Barter> {

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }
  List<bool> isHeartFilledList = [];

  @override
  void initState() {
    super.initState();
    getData();
    isHeartFilledList = List.generate(1000000, (index) => false);
  }
  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    final String getBartersQuery = '''
    query{
  displayBarters(flipperUser: "${sp.uid}"){
    id
    flipperUser
    barterTitle
    barterDescription
    barterRequirement
    barterLocation
    barterImage
  }
}
    ''';
    final String getMyBartersQuery = '''
    query{
  bartersbyid(flipperUser: "${sp.uid}"){
    id
    flipperUser
    barterTitle
    barterDescription
    barterRequirement
    barterLocation
    barterImage
  }
}
    ''';
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              nextScreen(context, NavBar());
            },
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                text: 'Barters',
              ),
              Tab(
                text: 'My Barters',
              ),
            ],
          ),
          title: const Text(
            'Barter Trading',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white,),
          onPressed: () {
            nextScreen(context, BarterUpload());
          },
          backgroundColor: Color(0xFF4EDB86),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: TabBarView(
            children: [
              GraphQLProvider(
                client: client,
                child: graphql.Query(
                  options: QueryOptions(
                    document: gql(getBartersQuery),
                  ),
                  builder: (QueryResult result, {fetchMore, refetch}) {
                    if (result.hasException) {
                      print("Exception");
                      print(result.exception.toString());
                      return SizedBox();
                    }

                    if (result.isLoading) {
                      print("Loading");
                      return const Center(child: CircularProgressIndicator());
                    }

                    final List<dynamic> data = result.data?['displayBarters'];
                    if (data.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/no_data.png',
                            scale: 3,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'There are no Items to Trade !!',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 17),
                          ),
                        ],
                      );
                    }
                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.85,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var barter = data[index];
                          return GestureDetector(
                            onTap: (){
                              nextScreen(context, ViewBarter(id: barter['id']));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border:
                                    Border.all(color: Color(0xFF333333)),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                  ),
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.5,
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 120,
                                          width: 150,
                                          child: Image(
                                            image: NetworkImage(
                                              httpLinkImage +
                                                  barter['barterImage'],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            '${barter['barterTitle']}',
                                            style: TextStyle(
                                                color: Color(0xFF333333),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.location_solid,
                                              size: 15,
                                            ),
                                            Expanded(
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                "${barter['barterLocation']}",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 150,
                                  child: GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        isHeartFilledList[index] = !isHeartFilledList[index];
                                      });
                                      if (isHeartFilledList[index] == true) {
                                        var req = http.MultipartRequest(
                                            'POST', Uri.parse('$httpLinkC/favoritebarter/'));
                                        req.fields.addAll({
                                          'flipperUser': "${sp.uid}",
                                          'barterId': "${barter['id']}",
                                        });
                                        http.StreamedResponse response = await req.send();

                                        if (response.statusCode == 200) {
                                          print(response);
                                        }
                                        else {
                                          print(response.reasonPhrase);
                                        }
                                      }
                                    },
                                    child: Icon(
                                      isHeartFilledList[index]
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: isHeartFilledList[index] ? Colors.red : null,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                      },
                    );
                  },
                ),
              ),
              GraphQLProvider(
                client: client,
                child: graphql.Query(
                  options: QueryOptions(
                    document: gql(getMyBartersQuery),
                  ),
                  builder: (QueryResult result, {fetchMore, refetch}) {
                    if (result.hasException) {
                      print("Exception");
                      print(result.exception.toString());
                      return SizedBox();
                    }

                    if (result.isLoading) {
                      print("Loading");
                      return const Center(child: CircularProgressIndicator());
                    }

                    final List<dynamic> data = result.data?['bartersbyid'];

                    if (data.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/no_data.png',
                            scale: 3,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Currently you don't have any ongoing Barter !!",
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 17),
                          ),
                        ],
                      );
                    }
                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.85,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var barter = data[index];
                        var delBar = barter['id'];
                        return GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Color(0xFF333333)),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                width:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.5,
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 150,
                                        child: Image(
                                          image: NetworkImage(
                                            httpLinkImage +
                                                barter['barterImage'],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          '${barter['barterTitle']}',
                                          style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.location_solid,
                                            size: 15,
                                          ),
                                          Expanded(
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              "${barter['barterLocation']}",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                    onPressed: () async {
                                      final String deleteBarter = ''' 
                                         mutation delete{
                                          deleteBarter(id: $delBar){
                                              success
                                                }
                                              }''';
                                      final GraphQLClient _client = client
                                          .value;
                                      final MutationOptions options = MutationOptions(
                                        document: gql(deleteBarter),
                                      );
                                      final QueryResult result = await _client
                                          .mutate(options);

                                      if (result.hasException) {
                                        print(
                                            'Error deleting Bike: ${result
                                                .exception.toString()}');
                                      } else {
                                        print('Deletion successful !');
                                        const snack = SnackBar(
                                          content: Text('Product Deleted Successfully', style: TextStyle(
                                              color: Colors.white),),
                                          backgroundColor: Colors.redAccent,
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.all(15),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snack);
                                        nextScreenReplace(context, NavBar());
                                      }
                                    },
                                    icon: Icon(Icons.delete, color: Colors.red,)),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
