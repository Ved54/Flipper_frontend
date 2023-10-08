import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:mazha_app/Product%20Uploads/Bike%20Upload/view_bike.dart';
import 'package:mazha_app/Product%20Uploads/Bike%20Upload/view_cycle.dart';
import 'package:mazha_app/Product%20Uploads/Bike%20Upload/view_spare.dart';
import 'package:mazha_app/Product%20Uploads/Book,%20Sport%20and%20Hobby%20Upload/view_bsh.dart';
import 'package:mazha_app/Product%20Uploads/Car%20Upload/view_car.dart';
import 'package:mazha_app/Product%20Uploads/Commercial%20Vehicle%20and%20Spare%20Upload/view_commSpare.dart';
import 'package:mazha_app/Product%20Uploads/Commercial%20Vehicle%20and%20Spare%20Upload/view_commvehicle.dart';
import 'package:mazha_app/Product%20Uploads/Electronic%20and%20Appliance%20Upload%20/view_elecApp.dart';
import 'package:mazha_app/Product%20Uploads/Furniture%20Upload/view_furniture.dart';
import 'package:mazha_app/Product%20Uploads/Job%20Upload/view_job.dart';
import 'package:mazha_app/Product%20Uploads/Mobile%20Upload/view_accessory.dart';
import 'package:mazha_app/Product%20Uploads/Mobile%20Upload/view_mobile.dart';
import 'package:mazha_app/Product%20Uploads/Pet%20Upload/view_pet.dart';
import 'package:mazha_app/Product%20Uploads/Property%20Upload/view_property.dart';
import 'package:mazha_app/screens/barter.dart';
import 'package:mazha_app/utils/next_screen.dart';
import 'package:provider/provider.dart';
import '../Product Uploads/Fashion Upload/view_fashion.dart';
import '../Product Uploads/Service Upload/view_service.dart';
import '../providers/sign_in_provider.dart';
import '../utils/GraphQL.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late List<bool> buttonPressStates;
  bool check_searchicon_color = false;

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
    buttonPressStates = List.generate(12, (index) => index == 0);
  }

  var idx = 0;

  final String getUsersQuery = '''
    query{
    displayUsers{
        flipperUser
    }
  }''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 20,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Discover',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 30,
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Color(0xFF333333)),
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              tooltip: "Barter",
              splashColor: Colors.transparent,
              iconSize: 30,
              icon: ImageIcon(
                AssetImage('assets/icons/barter_icon.png'),
                color: Color(0xFF333333),
              ),
              onPressed: () {
                nextScreen(context, Barter());
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Color(0xFF333333)),
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              tooltip: "Biding",
              splashColor: Colors.transparent,
              iconSize: 30,
              icon: ImageIcon(
                AssetImage('assets/icons/bid_icon.png'),
                color: Color(0xFF333333),
              ),
              onPressed: () {},
            )
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                    color: Colors.black12.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    onTap: () {
                      setState(() {
                        check_searchicon_color = true;
                      });
                    },
                    cursorColor: Color(0xFF4EDB86),
                    decoration: InputDecoration(
                      fillColor: Colors.black12.withOpacity(0.05),
                      hintText: 'Search',
                      prefixIcon: Icon(
                        Icons.search,
                        color: check_searchicon_color == true
                            ? Color(0xFF4EDB86)
                            : Colors.black12,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF4EDB86),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    splashColor: Colors.transparent,
                    iconSize: 30,
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            color: Colors.white,
            height: 50,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: _catChips(),
            ),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PageView.builder(
                itemCount: 1,
                controller: PageController(initialPage: idx),
                itemBuilder: (context, index) {
                  switch (idx) {
                    case 0:
                      return Product_List_Car();
                    case 1:
                      return Product_List_Property();
                    case 2:
                      return Product_List_Mobile();
                    case 3:
                      return Product_List_Job();
                    case 4:
                      return Product_List_Bike();
                    case 5:
                      return Product_List_Furniture();
                    case 6:
                      return Product_List_Fashion();
                    case 7:
                      return Product_List_ElecApp();
                    case 8:
                      return Product_List_CommSpare();
                    case 9:
                      return Product_List_BooksSportsHobbies();
                    case 10:
                      return Product_List_Pet();
                    case 11:
                      return Product_List_Service();
                    default:
                      return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _catChips() {
    List<String> cat_But = [
      "Cars",
      "Properties",
      "Mobiles",
      "Jobs",
      "Bikes",
      "Furniture",
      "Fashion",
      "Electronics & Appliances",
      "Commercial Vehicles & Spares",
      "Books, Sports & Hobbies",
      "Pets",
      "Services"
    ];

    List<Widget> catChips = [];

    for (int index = 0; index < cat_But.length; index++) {
      catChips.add(Padding(
        padding: EdgeInsets.only(right: 10),
        child: ActionChip(
          side: BorderSide(
            width: 0.5,
            color: buttonPressStates[index]
                ? Color(0xFF4EDB86)
                : Color(0xFF333333),
          ),
          label: Text(
            cat_But[index],
            style: TextStyle(
              color:
                  buttonPressStates[index] ? Colors.white : Color(0xFF333333),
            ),
          ),
          onPressed: () {
            setState(() {
              idx = index;
              buttonPressStates[index] = !buttonPressStates[index];

              for (int i = 0; i < buttonPressStates.length; i++) {
                if (i != index) {
                  buttonPressStates[i] = false;
                }
              }
            });
          },
          backgroundColor:
              buttonPressStates[index] ? Color(0xFF4EDB86) : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: buttonPressStates[index] ? 0 : 0.5,
                color: Color(0xFF333333)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ));
    }
    return catChips;
  }
}


// ------------ Car Section ------------
class Product_List_Car extends StatefulWidget {
  @override
  State<Product_List_Car> createState() => _Product_List_CarState();
}

class _Product_List_CarState extends State<Product_List_Car> {

  List<bool> isHeartFilledList = [];

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
    isHeartFilledList = List.generate(1000000, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    final String getCarsQuery = '''
    query{
  displayCars(flipperUser: "${sp.uid}"){
    id
    flipperUser
    flipperType
    carBrand
    carModel
    carVariant
    carYear
    carFuelType
    carTransmission
    carKmDriven
    carOwnerNum
    carDescription
    carLocation
    carPrice
    carImage
  }
}
''';

    return GraphQLProvider(
      client: client,
      child: graphql.Query(
        options: QueryOptions(
          document: gql(getCarsQuery),
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

          final List<dynamic> data = result.data?['displayCars'];

          if (data.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/no_data.png',scale: 3,),
                SizedBox(height: 20,),
                Text('Looks like there are no Cars for Sale !!', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),),
              ],
            );
          }
          return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.85,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              var car = data[index];
              return GestureDetector(
                onTap: (){
                  nextScreen(context, ViewCar(carId: car['id'],userId: car['flipperUser'], flipperType: car['flipperType'],
                      carBrand: car['carBrand'], carModel: car['carModel'],
                      carVariant: car['carVariant'], carYear: car['carYear'],
                      carFuelType: car['carFuelType'], carTransmission: car['carTransmission'],
                      carKmDriven: car['carKmDriven'], carOwnerNum: car['carOwnerNum'],
                      carDescription: car['carDescription'], carLocation: car['carLocation'],
                      carPrice: car['carPrice'], carImage: httpLinkImage + car['carImage']));
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF333333)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 150,
                              child: Image(
                                image: NetworkImage(
                                  httpLinkImage + car['carImage'],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "₹ ${car['carPrice']} /-",
                              style:
                              TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                '${car['carBrand']} ${car['carModel']}',
                                style:
                                TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
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
                                    "${car['carLocation']}",
                                    style: TextStyle(color: Colors.grey, fontSize: 15),
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
                        onTap: () async{
                          setState(() {
                            isHeartFilledList[index] = !isHeartFilledList[index];
                          });
                          print("${car['id']}");
                          if (isHeartFilledList[index] == true) {
                            var req = http.MultipartRequest(
                                'POST', Uri.parse('${httpLinkC}/favorite/'));
                            req.fields.addAll({
                              'flipperUser': "${sp.uid}",
                              'flipperType': "Car",
                              'carId': "${car['id']}",
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
    );

  }
}


// ------------ Property Section ------------
class Product_List_Property extends StatefulWidget {
  const Product_List_Property({super.key});

  @override
  State<Product_List_Property> createState() => _Product_List_PropertyState();
}

class _Product_List_PropertyState extends State<Product_List_Property> {

  List<bool> isHeartFilledList = [];

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
    isHeartFilledList = List.generate(1000000, (index) => false); // Assuming 10 items
  }



  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();

    final String getPropertiesQuery = '''
    query{
      displayProperties(flipperUser: "${sp.uid}"){
        id
        flipperUser
        flipperType
        propertyType
        propertyTitle
        propertyDescription
        propertyLocation
        propertyPrice
        propertyImage
      }
    }
''';

    return GraphQLProvider(
      client: client,
      child: graphql.Query(
        options: QueryOptions(
          document: gql(getPropertiesQuery),
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

          final List<dynamic> data = result.data?['displayProperties'];

          if (data.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/no_data.png',scale: 3,),
                SizedBox(height: 20,),
                Text('Looks like there are no Properties for Sale !!', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),),
              ],
            );
          }
          return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.85,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              var property = data[index];
              return GestureDetector(
                onTap: (){
                  nextScreen(context, ViewProperty(userId: property['flipperUser'], propertyType: property['propertyType'],
                      propertyTitle: property['propertyTitle'], propertyDescription: property['propertyDescription'],
                      propertyLocation: property['propertyLocation'], propertyPrice: property['propertyPrice'],
                      propertyImage: httpLinkImage + property['propertyImage']));
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF333333)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 150,
                              child: Image(
                                image: NetworkImage(
                                  httpLinkImage + property['propertyImage'],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "₹ ${property['propertyPrice']} /-",
                              style:
                              TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                '${property['propertyTitle']}',
                                style:
                                TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
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
                                    "${property['propertyLocation']}",
                                    style: TextStyle(color: Colors.grey, fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // child: Icon(CupertinoIcons.heart),
                      left: 150,
                      child: GestureDetector(
                        onTap: () async{
                          setState(() {
                            isHeartFilledList[index] = !isHeartFilledList[index];
                          });
                          if (isHeartFilledList[index] == true) {
                            var req = http.MultipartRequest(
                                'POST', Uri.parse('$httpLinkC/favorite/'));
                            req.fields.addAll({
                              'flipperUser': "${sp.uid}",
                              'flipperType': "Property",
                              'propertyId': "${property['id']}",
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
    );
  }
}


// ------------ Mobile Section ------------
class Product_List_Mobile extends StatefulWidget {
  const Product_List_Mobile({super.key});

  @override
  State<Product_List_Mobile> createState() => _Product_List_MobileState();
}

class _Product_List_MobileState extends State<Product_List_Mobile> {

  List<bool> isHeartFilledList = [];

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
    isHeartFilledList = List.generate(1000000, (index) => false); // Assuming 10 items
  }

  @override
  Widget build(BuildContext context) {

    final sp = context.watch<SignInProvider>();

    final String getMobilesQuery = '''
    query{
      displayMobiles(flipperUser: "${sp.uid}"){
        flipperUser
        flipperType
        accessoryType
        mobileBrand
        mobileTitle
        mobileDescription
        mobileLocation
        mobilePrice
        mobileImage
      }
    }
''';
    return GraphQLProvider(
      client: client,
      child: graphql.Query(
        options: QueryOptions(
          document: gql(getMobilesQuery),
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

          final List<dynamic> data = result.data?['displayMobiles'];

          if (data.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/no_data.png',scale: 3,),
                SizedBox(height: 20,),
                Text('Looks like there are no Mobiles for Sale !!', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),),
              ],
            );
          }
          return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.85,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              var mobile = data[index];
              return GestureDetector(
                onTap: (){
                  if(mobile['accessoryType'] != ""){
                    nextScreen(context, ViewAccessory(userId: mobile['flipperUser'], accessoryType: mobile['accessoryType'],flipperType: mobile['flipperType'],
                        mobileTitle: mobile['mobileTitle'], mobileDescription: mobile['mobileDescription'], mobileLocation: mobile['mobileLocation'],
                        mobileImage: httpLinkImage + mobile['mobileImage'], mobilePrice: mobile['mobilePrice']));
                  }else{
                    nextScreen(context, ViewMobile(userId: mobile['flipperUser'], accessoryType: mobile['accessoryType'],flipperType: mobile['flipperType'], mobileBrand: mobile['mobileBrand'],
                        mobileTitle: mobile['mobileTitle'], mobileDescription: mobile['mobileDescription'], mobileLocation: mobile['mobileLocation'],
                        mobileImage: httpLinkImage + mobile['mobileImage'], mobilePrice: mobile['mobilePrice']));
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF333333)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 150,
                              child: Image(
                                image: NetworkImage(
                                  httpLinkImage + mobile['mobileImage'],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "₹ ${mobile['mobilePrice']} /-",
                              style:
                              TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                '${mobile['mobileTitle']}',
                                style:
                                TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
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
                                    "${mobile['mobileLocation']}",
                                    style: TextStyle(color: Colors.grey, fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // child: Icon(CupertinoIcons.heart),
                      left: 150,
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            isHeartFilledList[index] = !isHeartFilledList[index];
                          });
                          if (isHeartFilledList[index] == true) {
                            var req = http.MultipartRequest(
                                'POST', Uri.parse('$httpLinkC/favorite/'));
                            req.fields.addAll({
                              'flipperUser': "${sp.uid}",
                              'flipperType': "Mobile",
                              'mobileId': "${mobile['id']}",
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
    );
  }
}


// ------------ Job Section ------------
class Product_List_Job extends StatefulWidget {
  const Product_List_Job({super.key});

  @override
  State<Product_List_Job> createState() => _Product_List_JobState();
}

class _Product_List_JobState extends State<Product_List_Job> {
  List<bool> isHeartFilledList = [];

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
    isHeartFilledList = List.generate(1000000, (index) => false); // Assuming 10 items
  }
  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();

    final String getJobsQuery = '''
    query{
      displayJobs(flipperUser: "${sp.uid}"){
        flipperUser
        flipperType
        jobType
        salaryPeriod
        positionType
        salaryRange
        jobTitle
        jobDescription
        jobLocation
        jobImage
      }
    }
''';
    return GraphQLProvider(
      client: client,
      child: graphql.Query(
        options: QueryOptions(
          document: gql(getJobsQuery),
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

          final List<dynamic> data = result.data?['displayJobs'];

          if (data.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/no_data.png',scale: 3,),
                SizedBox(height: 20,),
                Text('Looks like there are no Jobs in Market !!', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),),
              ],
            );
          }
          return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.85,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              var job = data[index];
              return GestureDetector(
                onTap: (){
                  nextScreen(context, ViewJob(userId: job['flipperUser'], flipperType: job['flipperType'], jobType: job['jobType'],
                  jobTitle: job['jobTitle'], jobDescription: job['jobDescription'], jobLocation: job['jobLocation'],
                  jobImage: httpLinkImage + job['jobImage'], positionType: job['positionType'], salaryPeriod: job['salaryPeriod'],
                  salaryRange: job['salaryRange'],));
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF333333)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 150,
                              child: Image(
                                image: NetworkImage(
                                  httpLinkImage + job['jobImage'],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              "₹ ${job['salaryRange']} /-",
                              style:
                              TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                '${job['jobTitle']}',
                                style:
                                TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
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
                                    "${job['jobLocation']}",
                                    style: TextStyle(color: Colors.grey, fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // child: Icon(CupertinoIcons.heart),
                      left: 150,
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            isHeartFilledList[index] = !isHeartFilledList[index];
                          });
                          if (isHeartFilledList[index] == true) {
                            var req = http.MultipartRequest(
                                'POST', Uri.parse('$httpLinkC/favorite/'));
                            req.fields.addAll({
                              'flipperUser': "${sp.uid}",
                              'flipperType': "Job",
                              'jobId': "${job['id']}",
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
    );
  }
}


// ------------ Bike Section ------------
class Product_List_Bike extends StatefulWidget {
  const Product_List_Bike({super.key});

  @override
  State<Product_List_Bike> createState() => _Product_List_BikeState();
}

class _Product_List_BikeState extends State<Product_List_Bike> {
  List<bool> isHeartFilledList = [];

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
    isHeartFilledList = List.generate(1000000, (index) => false); // Assuming 10 items
  }
  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();

    final String getBikesQuery = '''
    query{
      displayBikes(flipperUser: "${sp.uid}"){
        flipperUser
        flipperType
        bikeType
        spareTitle
        cycleTitle
        bikeBrand
        bikeModel
        bikeYear
        bikeKmDriven
        bikeOwnerNum
        bikeDescription
        bikeLocation
        bikePrice
        bikeImage
      }
    }
''';
    return GraphQLProvider(
      client: client,
      child: graphql.Query(
        options: QueryOptions(
          document: gql(getBikesQuery),
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

          final List<dynamic> data = result.data?['displayBikes'];

          if (data.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/no_data.png',scale: 3,),
                SizedBox(height: 20,),
                Text('Looks like there are no Bikes for Sale !!', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),),
              ],
            );
          }
          return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.85,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              var bike = data[index];
              return GestureDetector(
                onTap: (){
                  if(bike['bikeType'] == "Spare Part"){
                    nextScreen(context, ViewBikeSparePart(userId: bike['flipperUser'], flipperType: bike['flipperType'],
                        spareTitle: bike['spareTitle'], bikeDescription: bike['bikeDescription'],
                        bikeLocation: bike['bikeLocation'], bikePrice: bike['bikePrice'],
                        bikeImage: httpLinkImage + bike['bikeImage']));
                  }
                  else if(bike['bikeType'] == "Bicycle"){
                    nextScreen(context, ViewCycle(userId: bike['flipperUser'], flipperType: bike['flipperType'],
                        cycleTitle: bike['cycleTitle'], bikeBrand: bike['bikeBrand'],
                        bikeDescription: bike['bikeDescription'], bikeLocation: bike['bikeLocation'],
                        bikePrice: bike['bikePrice'], bikeImage: httpLinkImage + bike['bikeImage']));
                  }
                  else{
                    nextScreen(context, ViewBike(userId: bike['flipperUser'], flipperType: bike['flipperType'],
                        bikeType: bike['bikeType'], bikeBrand: bike['bikeBrand'], bikeModel: bike['bikeModel'],
                        bikeYear: bike['bikeYear'], bikeKmDriven: bike['bikeKmDriven'],
                        bikeOwnerNum: bike['bikeOwnerNum'], bikeDescription: bike['bikeDescription'],
                        bikeLocation: bike['bikeLocation'], bikePrice: bike['bikePrice'], bikeImage: httpLinkImage + bike['bikeImage']));
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF333333)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 150,
                              child: Image(
                                image: NetworkImage(
                                  httpLinkImage + bike['bikeImage'],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              "₹ ${bike['bikePrice']} /-",
                              style:
                              TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Text(
                                bike['bikeType'] == "Spare Part"
                                    ? '${bike['spareTitle']}'
                                    : (bike['bikeType'] == "Bicycle"
                                    ? '${bike['cycleTitle']}'
                                    : '${bike['bikeBrand']} ${bike['bikeModel']} ${bike['bikeYear']}'),
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
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
                                    "${bike['bikeLocation']}",
                                    style: TextStyle(color: Colors.grey, fontSize: 15),
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
                        onTap: ()async{
                          setState(() {
                            isHeartFilledList[index] = !isHeartFilledList[index];
                          });
                          if (isHeartFilledList[index] == true) {
                            var req = http.MultipartRequest(
                                'POST', Uri.parse('${httpLinkC}/favorites/'));
                            req.fields.addAll({
                              'flipperUser': "${sp.uid}",
                              'flipperType': "Bike",
                              'bikeId': "${bike['id']}",
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
    );
  }
}


// ------------ Furniture Section ------------
class Product_List_Furniture extends StatefulWidget {
  const Product_List_Furniture({super.key});

  @override
  State<Product_List_Furniture> createState() => _Product_List_FurnitureState();
}

class _Product_List_FurnitureState extends State<Product_List_Furniture> {
  List<bool> isHeartFilledList = [];

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
    isHeartFilledList = List.generate(1000000, (index) => false); // Assuming 10 items
  }
  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();

    final String getFurnituresQuery = '''
    query{
      displayFurnitures(flipperUser: "${sp.uid}"){
        flipperUser
        flipperType
        furnitureType
        furnitureTitle
        furnitureDescription
        furnitureLocation
        furniturePrice
        furnitureImage
      }
    }
''';
    return GraphQLProvider(
      client: client,
      child: graphql.Query(
        options: QueryOptions(
          document: gql(getFurnituresQuery),
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

          final List<dynamic> data = result.data?['displayFurnitures'];

          if (data.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/no_data.png',scale: 3,),
                SizedBox(height: 20,),
                Text('Looks like there are no Furnitures Listed !!', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),),
              ],
            );
          }
          return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.85,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              var furniture = data[index];
              return GestureDetector(
                onTap: (){
                  nextScreen(context, ViewFurniture(userId: furniture['flipperUser'], furnitureType: furniture['furnitureType'],
                      furnitureTitle: furniture['furnitureTitle'], furnitureDescription: furniture['furnitureDescription'],
                      furnitureLocation: furniture['furnitureLocation'], furniturePrice: furniture['furniturePrice'],
                      furnitureImage: httpLinkImage + furniture['furnitureImage']));
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF333333)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 150,
                              child: Image(
                                image: NetworkImage(
                                  httpLinkImage + furniture['furnitureImage'],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "₹ ${furniture['furniturePrice']} /-",
                              style:
                              TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                '${furniture['furnitureTitle']}',
                                style:
                                TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
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
                                    "${furniture['furnitureLocation']}",
                                    style: TextStyle(color: Colors.grey, fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // child: Icon(CupertinoIcons.heart),
                      left: 150,
                      child: GestureDetector(
                        onTap: () async{
                          setState(() {
                            isHeartFilledList[index] = !isHeartFilledList[index];
                          });
                          if (isHeartFilledList[index] == true) {
                            var req = http.MultipartRequest(
                                'POST', Uri.parse('$httpLinkC/favorite/'));
                            req.fields.addAll({
                              'flipperUser': "${sp.uid}",
                              'flipperType': "Furniture",
                              'furnitureId': "${furniture['id']}",
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
    );
  }
}


// ------------ Fashion Section ------------
class Product_List_Fashion extends StatefulWidget {
  const Product_List_Fashion({super.key});

  @override
  State<Product_List_Fashion> createState() => _Product_List_FashionState();
}

class _Product_List_FashionState extends State<Product_List_Fashion> {
  List<bool> isHeartFilledList = [];

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
    isHeartFilledList = List.generate(1000000, (index) => false); // Assuming 10 items
  }
  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();

    final String getFashionsQuery = '''
    query{
      displayFashions(flipperUser: "${sp.uid}"){
        flipperUser
        flipperType
        fashionType
        fashionTitle
        fashionDescription
        fashionLocation
        fashionPrice
        fashionImage
      }
    }
''';
    return GraphQLProvider(
      client: client,
      child: graphql.Query(
        options: QueryOptions(
          document: gql(getFashionsQuery),
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

          final List<dynamic> data = result.data?['displayFashions'];

          if (data.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/no_data.png',scale: 3,),
                SizedBox(height: 20,),
                Text('Looks like current market has no Fashion taste !!', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),),
              ],
            );
          }
          return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.85,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              var fashion = data[index];
              return GestureDetector(
                onTap: (){
                  nextScreen(context, ViewFashion(userId: fashion['flipperUser'], fashionType: fashion['fashionType'],
                      fashionTitle: fashion['fashionTitle'], fashionDescription: fashion['fashionDescription'],
                      fashionLocation: fashion['fashionLocation'], fashionPrice: fashion['fashionPrice'],
                      fashionImage: httpLinkImage + fashion['fashionImage']));
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF333333)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 150,
                              child: Image(
                                image: NetworkImage(
                                  httpLinkImage + fashion['fashionImage'],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "₹ ${fashion['fashionPrice']} /-",
                              style:
                              TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                '${fashion['fashionTitle']}',
                                style:
                                TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
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
                                    "${fashion['fashionLocation']}",
                                    style: TextStyle(color: Colors.grey, fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // child: Icon(CupertinoIcons.heart),
                      left: 150,
                      child: GestureDetector(
                        onTap: () async{
                          setState(() {
                            isHeartFilledList[index] = !isHeartFilledList[index];
                          });
                          if (isHeartFilledList[index] == true) {
                            var req = http.MultipartRequest(
                                'POST', Uri.parse('$httpLinkC/favorite/'));
                            req.fields.addAll({
                              'flipperUser': "${sp.uid}",
                              'flipperType': "Fashion",
                              'fashionId': "${fashion['id']}",
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
    );
  }
}


// ------------ Electronics and Appliances Section ------------
class Product_List_ElecApp extends StatefulWidget {
  const Product_List_ElecApp({super.key});

  @override
  State<Product_List_ElecApp> createState() => _Product_List_ElecAppState();
}

class _Product_List_ElecAppState extends State<Product_List_ElecApp> {
  List<bool> isHeartFilledList = [];

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
    isHeartFilledList = List.generate(1000000, (index) => false); // Assuming 10 items
  }
  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();

    final String getElecAppsQuery = '''
    query{
      displayElectronicAppliances(flipperUser: "${sp.uid}"){
        flipperUser
        flipperType
        elecType
        elecTitle
        elecDescription
        elecLocation
        elecPrice
        elecImage
      }
    }
''';
    return GraphQLProvider(
      client: client,
      child: graphql.Query(
        options: QueryOptions(
          document: gql(getElecAppsQuery),
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

          final List<dynamic> data = result.data?['displayElectronicAppliances'];

          if (data.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/no_data.png',scale: 3,),
                SizedBox(height: 20,),
                Text('Neither Electronics nor Appliances are Listed !!', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),),
              ],
            );
          }
          return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.85,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              var elec = data[index];
              return GestureDetector(
                onTap: (){
                  nextScreen(context, ViewElecApp(userId: elec['flipperUser'], elecType: elec['elecType'],
                      elecTitle: elec['elecTitle'], elecDescription: elec['elecDescription'],
                      elecLocation: elec['elecLocation'], elecPrice: elec['elecPrice'], elecImage: httpLinkImage + elec['elecImage']));
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF333333)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 150,
                              child: Image(
                                image: NetworkImage(
                                  httpLinkImage + elec['elecImage'],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "₹ ${elec['elecPrice']} /-",
                              style:
                              TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                '${elec['elecTitle']}',
                                style:
                                TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
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
                                    "${elec['elecLocation']}",
                                    style: TextStyle(color: Colors.grey, fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // child: Icon(CupertinoIcons.heart),
                      left: 150,
                      child: GestureDetector(
                        onTap: () async{
                          setState(() {
                            isHeartFilledList[index] = !isHeartFilledList[index];
                          });
                          if (isHeartFilledList[index] == true) {
                            var req = http.MultipartRequest(
                                'POST', Uri.parse('$httpLinkC/favorite/'));
                            req.fields.addAll({
                              'flipperUser': "${sp.uid}",
                              'flipperType': "ElecApp",
                              'elecId': "${elec['id']}",
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
    );
  }
}


// ------------ Commercial Vehicles Section ------------
class Product_List_CommSpare extends StatefulWidget {
  const Product_List_CommSpare({super.key});

  @override
  State<Product_List_CommSpare> createState() => _Product_List_CommSpareState();
}

class _Product_List_CommSpareState extends State<Product_List_CommSpare> {
  List<bool> isHeartFilledList = [];

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
    isHeartFilledList = List.generate(1000000, (index) => false); // Assuming 10 items
  }
  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();

    final String getCommsQuery = '''
    query{
      displayComms(flipperUser: "${sp.uid}"){
        flipperUser
        flipperType
        commType
        spareTitle
        commTitle
        commBrand
        commYear
        commKmDriven
        commDescription
        commLocation
        commPrice
        commImage
      }
    }
''';
    return GraphQLProvider(
      client: client,
      child: graphql.Query(
        options: QueryOptions(
          document: gql(getCommsQuery),
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

          final List<dynamic> data = result.data?['displayComms'];

          if (data.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/no_data.png',scale: 3,),
                SizedBox(height: 20,),
                Text('Looks like there are no Commercial Vehicles for Sale !!', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),),
              ],
            );
          }
          return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.85,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              var comm = data[index];
              return GestureDetector(
                onTap: (){
                  if(comm['spareTitle'] != ""){
                    nextScreen(context, ViewCommSparePart(userId: comm['flipperUser'], flipperType: comm['flipperType'],
                        spareTitle: comm['spareTitle'], commDescription: comm['commDescription'],
                        commLocation: comm['commLocation'], commPrice: comm['commPrice'],
                        commImage: httpLinkImage + comm['commImage']));
                  }
                  else{
                    nextScreen(context, ViewComm(userId: comm['flipperUser'], flipperType: comm['flipperType'],
                        commType: comm['commType'], commTitle: comm['commTitle'], commBrand: comm['commBrand'],
                        commYear: comm['commYear'], commKmDriven: comm['commKmDriven'],
                        commDescription: comm['commDescription'], commLocation: comm['commLocation'],
                        commPrice: comm['commPrice'], commImage: httpLinkImage + comm['commImage']));
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF333333)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 150,
                              child: Image(
                                image: NetworkImage(
                                  httpLinkImage + comm['commImage'],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              "₹ ${comm['commPrice']} /-",
                              style:
                              TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Text(
                                comm['spareTitle'] != ""
                                    ? '${comm['spareTitle']}'
                                    : '${comm['commTitle']}',
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
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
                                    "${comm['commLocation']}",
                                    style: TextStyle(color: Colors.grey, fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // child: Icon(CupertinoIcons.heart),
                      left: 150,
                      child: GestureDetector(
                        onTap: () async{
                          setState(() {
                            isHeartFilledList[index] = !isHeartFilledList[index];
                          });
                          if (isHeartFilledList[index] == true) {
                            var req = http.MultipartRequest(
                                'POST', Uri.parse('$httpLinkC/favorite/'));
                            req.fields.addAll({
                              'flipperUser': "${sp.uid}",
                              'flipperType': "Comm",
                              'commId': "${comm['id']}",
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
    );
  }
}


// ------------ Books, Sports and Hobbies Section ------------
class Product_List_BooksSportsHobbies extends StatefulWidget {
  const Product_List_BooksSportsHobbies({super.key});

  @override
  State<Product_List_BooksSportsHobbies> createState() => _Product_List_BooksSportsHobbiesState();
}

class _Product_List_BooksSportsHobbiesState extends State<Product_List_BooksSportsHobbies> {
  List<bool> isHeartFilledList = [];

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
    isHeartFilledList = List.generate(1000000, (index) => false); // Assuming 10 items
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();

    final String getBSHsQuery = '''
    query{
      displayBSHs(flipperUser: "${sp.uid}"){
        flipperUser
        flipperType
        bshType
        bshTitle
        bshDescription
        bshLocation
        bshPrice
        bshImage
      }
    }
''';
    return GraphQLProvider(
      client: client,
      child: graphql.Query(
        options: QueryOptions(
          document: gql(getBSHsQuery),
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

          final List<dynamic> data = result.data?['displayBSHs'];

          if (data.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/no_data.png',scale: 3,),
                SizedBox(height: 20,),
                Text("Looks like poeple don't have any Hobbies !!", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),),
              ],
            );
          }
          return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.85,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              var bsh = data[index];
              return GestureDetector(
                onTap: (){
                  nextScreen(context, ViewBSH(userId: bsh['flipperUser'], bshType: bsh['bshType'],
                      bshTitle: bsh['bshTitle'], bshDescription: bsh['bshDescription'],
                      bshLocation: bsh['bshLocation'], bshPrice: bsh['bshPrice'], bshImage: httpLinkImage + bsh['bshImage']));
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF333333)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 150,
                              child: Image(
                                image: NetworkImage(
                                  httpLinkImage + bsh['bshImage'],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "₹ ${bsh['bshPrice']} /-",
                              style:
                              TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                '${bsh['bshTitle']}',
                                style:
                                TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
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
                                    "${bsh['bshLocation']}",
                                    style: TextStyle(color: Colors.grey, fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // child: Icon(CupertinoIcons.heart),
                      left: 150,
                      child: GestureDetector(
                        onTap: () async{
                          setState(() {
                            isHeartFilledList[index] = !isHeartFilledList[index];
                          });
                          if (isHeartFilledList[index] == true) {
                            var req = http.MultipartRequest(
                                'POST', Uri.parse('$httpLinkC/favorite/'));
                            req.fields.addAll({
                              'flipperUser': "${sp.uid}",
                              'flipperType': "BSH",
                              'bshId': "${bsh['id']}",
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
    );
  }

}


// ------------ Pet Section ------------
class Product_List_Pet extends StatefulWidget {
  const Product_List_Pet({super.key});

  @override
  State<Product_List_Pet> createState() => _Product_List_PetState();
}

class _Product_List_PetState extends State<Product_List_Pet> {
  List<bool> isHeartFilledList = [];

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
    isHeartFilledList = List.generate(1000000, (index) => false); // Assuming 10 items
  }
  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();

    final String getPetsQuery = '''
    query{
      displayPets(flipperUser: "${sp.uid}"){
        flipperUser
        flipperType
        petType
        petTitle
        petDescription
        petLocation
        petPrice
        petImage
      }
    }
''';
    return GraphQLProvider(
      client: client,
      child: graphql.Query(
        options: QueryOptions(
          document: gql(getPetsQuery),
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

          final List<dynamic> data = result.data?['displayPets'];

          if (data.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/no_data.png',scale: 3,),
                SizedBox(height: 20,),
                Text('Looks like there are no Pets Listed !!', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),),
              ],
            );
          }
          return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.85,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              var pet = data[index];
              return GestureDetector(
                onTap: (){
                  nextScreen(context, ViewPet(userId: pet['flipperUser'], petType: pet['petType'],petTitle: pet['petTitle'],
                      petDescription: pet['petDescription'], petLocation: pet['petLocation'],
                      petPrice: pet['petPrice'], petImage: httpLinkImage + pet['petImage']));
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF333333)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 150,
                              child: Image(
                                image: NetworkImage(
                                  httpLinkImage + pet['petImage'],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "₹ ${pet['petPrice']} /-",
                              style:
                              TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                '${pet['petTitle']}',
                                style:
                                TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
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
                                    "${pet['petLocation']}",
                                    style: TextStyle(color: Colors.grey, fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // child: Icon(CupertinoIcons.heart),
                      left: 150,
                      child: GestureDetector(
                        onTap: () async{
                          setState(() {
                            isHeartFilledList[index] = !isHeartFilledList[index];
                          });
                          if (isHeartFilledList[index] == true) {
                            var req = http.MultipartRequest(
                                'POST', Uri.parse('$httpLinkC/favorite/'));
                            req.fields.addAll({
                              'flipperUser': "${sp.uid}",
                              'flipperType': "Pet",
                              'petId': "${pet['id']}",
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
    );
  }
}


// ------------ Service Section ------------
class Product_List_Service extends StatefulWidget {
  const Product_List_Service({super.key});

  @override
  State<Product_List_Service> createState() => _Product_List_ServiceState();
}

class _Product_List_ServiceState extends State<Product_List_Service> {
  List<bool> isHeartFilledList = [];

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
    isHeartFilledList = List.generate(1000000, (index) => false); // Assuming 10 items
  }
  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();

    final String getServicesQuery = '''
    query{
      displayServices(flipperUser: "${sp.uid}"){
        flipperUser
        flipperType
        serviceType
        serviceTitle
        serviceDescription
        serviceLocation
        serviceImage
      }
    }
''';
    return GraphQLProvider(
      client: client,
      child: graphql.Query(
        options: QueryOptions(
          document: gql(getServicesQuery),
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

          final List<dynamic> data = result.data?['displayServices'];

          if (data.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icons/no_data.png',scale: 3,),
                SizedBox(height: 20,),
                Text('Looks like there are no Service Listed !!', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),),
              ],
            );
          }
          return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.85,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              var service = data[index];
              return GestureDetector(
                onTap: (){
                  nextScreen(context, ViewService(userId: service['flipperUser'], flipperType: service['flipperType'], serviceType: service['serviceType'],
                    serviceTitle: service['serviceTitle'], serviceDescription: service['serviceDescription'], serviceLocation: service['serviceLocation'],
                    serviceImage: httpLinkImage + service['serviceImage'],));
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF333333)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 150,
                              child: Image(
                                image: NetworkImage(
                                  httpLinkImage + service['serviceImage'],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                '${service['serviceTitle']}',
                                style:
                                TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
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
                                    "${service['serviceLocation']}",
                                    style: TextStyle(color: Colors.grey, fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // child: Icon(CupertinoIcons.heart),
                      left: 150,
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            isHeartFilledList[index] = !isHeartFilledList[index];
                          });
                          if (isHeartFilledList[index] == true) {
                            var req = http.MultipartRequest(
                                'POST', Uri.parse('$httpLinkC/favorite/'));
                            req.fields.addAll({
                              'flipperUser': "${sp.uid}",
                              'flipperType': "Service",
                              'serviceId': "${service['id']}",
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
    );
  }
}
