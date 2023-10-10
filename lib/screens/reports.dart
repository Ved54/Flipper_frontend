import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart';
import '../utils/GraphQL.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  var progressValueAll;
  var progressValuecar;
  var progressValueprop;
  var progressValuemob;
  var progressValuejob;
  var progressValuebike;
  var progressValuefur;
  var progressValuefas;
  var progressValueelec;
  var progressValuecomm;
  var progressValuebsh;
  var progressValuepet;
  var progressValueser;

  final String cars = '''
  query{
    allCars{
      id
    }
  }
  ''';

  void retreiveData() {
    print(" Yooooooooooo");
    GraphQLProvider(
      client: client,
      child: Query(
        options: QueryOptions(
          document: gql(cars),
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            print(result.exception.toString());
            return Center();
          }

          if (result.isLoading) {
            print("Loading");
            return Center();
          }
          final List<dynamic> carData = result.data?['allCars'];
          progressValuecar = carData.length;
          if (carData.isEmpty) {
            progressValuecar = 999;
            return SizedBox();
          }
          return SizedBox();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    retreiveData();

    final String auctions = '''
    query{
  displayAuctions{
    id
    hostName
    productTitle
    basePrice
    minimumBid
    auctionDate
    auctionTime
    auctionDescription
    auctionLocation
    auctionAddress
    productImage
  }
}
  ''';

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text("Reports",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            centerTitle: true,
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: 'Products',
                ),
                Tab(
                  text: 'Barters',
                ),
                Tab(
                  text: 'Auctions',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total Products  ",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0, end: 1),
                            duration: const Duration(milliseconds: 1500),
                            builder: (context, value, _) => Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: CircularProgressIndicator(
                                    value: value,
                                    strokeWidth: 10,
                                    color: Color(0xFF8F00Ff),
                                  ),
                                ),
                                Text(
                                  "1235",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TweenAnimationBuilder<double>(
                                      tween: Tween<double>(
                                          begin: 0.0, end: 123 / 1235),
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      builder: (context, value, _) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            child: CircularProgressIndicator(
                                              value: value,
                                              strokeWidth: 5,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          Text(
                                            "123",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text("Cars",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TweenAnimationBuilder<double>(
                                      tween: Tween<double>(
                                          begin: 0.0, end: 184 / 1235),
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      builder: (context, value, _) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            child: CircularProgressIndicator(
                                              value: value,
                                              strokeWidth: 5,
                                              color: Colors.pink,
                                            ),
                                          ),
                                          Text(
                                            "184",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text("Properties",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TweenAnimationBuilder<double>(
                                      tween: Tween<double>(
                                          begin: 0.0, end: 156 / 1235),
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      builder: (context, value, _) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            child: CircularProgressIndicator(
                                              value: value,
                                              strokeWidth: 5,
                                              color: Colors.amber,
                                            ),
                                          ),
                                          Text(
                                            "156",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text("Mobiles",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TweenAnimationBuilder<double>(
                                      tween: Tween<double>(
                                          begin: 0.0, end: 144 / 1235),
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      builder: (context, value, _) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            child: CircularProgressIndicator(
                                              value: value,
                                              strokeWidth: 5,
                                              color: Colors.lightBlueAccent,
                                            ),
                                          ),
                                          Text(
                                            "144",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text("Jobs",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TweenAnimationBuilder<double>(
                                      tween: Tween<double>(
                                          begin: 0.0, end: 92 / 1235),
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      builder: (context, value, _) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            child: CircularProgressIndicator(
                                              value: value,
                                              strokeWidth: 5,
                                              color: Colors.lightGreenAccent,
                                            ),
                                          ),
                                          Text(
                                            "92",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text("Bikes",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TweenAnimationBuilder<double>(
                                      tween: Tween<double>(
                                          begin: 0.0, end: 85 / 1235),
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      builder: (context, value, _) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            child: CircularProgressIndicator(
                                              value: value,
                                              strokeWidth: 5,
                                              color: Colors.cyanAccent,
                                            ),
                                          ),
                                          Text(
                                            "85",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text("Furnitures",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TweenAnimationBuilder<double>(
                                      tween: Tween<double>(
                                          begin: 0.0, end: 61 / 1235),
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      builder: (context, value, _) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            child: CircularProgressIndicator(
                                              value: value,
                                              strokeWidth: 5,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                          Text(
                                            "61",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text("Fashions",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TweenAnimationBuilder<double>(
                                      tween: Tween<double>(
                                          begin: 0.0, end: 76 / 1235),
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      builder: (context, value, _) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            child: CircularProgressIndicator(
                                              value: value,
                                              strokeWidth: 5,
                                              color: Colors.yellowAccent,
                                            ),
                                          ),
                                          Text(
                                            "76",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text("ElecApps",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TweenAnimationBuilder<double>(
                                      tween: Tween<double>(
                                          begin: 0.0, end: 81 / 1235),
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      builder: (context, value, _) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            child: CircularProgressIndicator(
                                              value: value,
                                              strokeWidth: 5,
                                              color: Colors.purpleAccent,
                                            ),
                                          ),
                                          Text(
                                            "81",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text("Comms",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TweenAnimationBuilder<double>(
                                      tween: Tween<double>(
                                          begin: 0.0, end: 89 / 1235),
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      builder: (context, value, _) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            child: CircularProgressIndicator(
                                              value: value,
                                              strokeWidth: 5,
                                              color: Colors.brown,
                                            ),
                                          ),
                                          Text(
                                            "89",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text("BSH",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TweenAnimationBuilder<double>(
                                      tween: Tween<double>(
                                          begin: 0.0, end: 66 / 1235),
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      builder: (context, value, _) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            child: CircularProgressIndicator(
                                              value: value,
                                              strokeWidth: 5,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            "66",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text("Pets",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TweenAnimationBuilder<double>(
                                      tween: Tween<double>(
                                          begin: 0.0, end: 78 / 1235),
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      builder: (context, value, _) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 70,
                                            child: CircularProgressIndicator(
                                              value: value,
                                              strokeWidth: 5,
                                              color: Colors.indigo,
                                            ),
                                          ),
                                          Text(
                                            "78",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text("Services",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total Auctions ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0.0, end: 1),
                          duration: const Duration(milliseconds: 1500),
                          builder: (context, value, _) => Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: CircularProgressIndicator(
                                  value: value,
                                  strokeWidth: 5,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                "836",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 3,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: ListBarters.length,
                      itemBuilder: (context, index) {

                        return Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              elevation:
                                  5,
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Text(
                                      "|",
                                      style: TextStyle(fontSize: 40),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "${ListBarters[index]}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ))
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
                  ],
                ),
              ),
              GraphQLProvider(
                client: client,
                child: Query(
                  options: QueryOptions(
                    document: gql(auctions),
                  ),
                  builder: (QueryResult result, {fetchMore, refetch}) {
                    if (result.hasException) {
                      print(result.exception.toString());
                      return Center();
                    }

                    if (result.isLoading) {
                      print("Loading");
                      return Center();
                    }
                    final List<dynamic> auctionData =
                        result.data?['displayAuctions'];

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Total Auctions ",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(begin: 0.0, end: 1),
                                duration: const Duration(milliseconds: 1500),
                                builder: (context, value, _) => Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      child: CircularProgressIndicator(
                                        value: value,
                                        strokeWidth: 5,
                                      ),
                                    ),
                                    Text(
                                      "678",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            thickness: 3,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: ListAuctions.length,
                            itemBuilder: (context, index) {
                              // var auction = auctionData[index];
                              return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(20),
                                    elevation:
                                        5, // Set the elevation value as per your preference
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Text(
                                            "|",
                                            style: TextStyle(fontSize: 40),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                              child: Text(
                                            "${ListAuctions[index]}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  List<String> ListAuctions = [
    "Elegant Victorian Mahogany Writing Desk",
    "Rare 18th Century Porcelain Tea Set",
    "Antique Brass Ship's Sextant, 19th Century",
    "Exquisite Art Nouveau Silver Mirror",
    "Antique Persian Kashan Rug, Handwoven Beauty",
    "18th Century French Giltwood Chandelier",
    "Historic Civil War Era Colt Revolver",
    "Antique Tiffany & Co. Sterling Silver Flatware Set",
    "Impressive Renaissance Revival Grandfather Clock",
    "Rare 19th Century Chinese Jade Figurine"
  ];

  List<String> ListBarters = [
    "Vintage Record Player and Vinyl Collection",
    "Handmade Quilts and Blankets",
    "Original Artwork by Local Artist",
    "Rare Collectible Coins and Currency",
    "Antique Wooden Furniture Set",
    "Professional DSLR Camera and Accessories",
    "Homegrown Organic Produce and Herbs",
    "Custom-Made Jewelry and Accessories",
    "Handcrafted Woodworking Tools",
    "Unused Exercise Equipment and Weights"
  ];
}


