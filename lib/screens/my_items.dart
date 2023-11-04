import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mazha_app/utils/nav_bar.dart';
import 'package:mazha_app/utils/next_screen.dart';
import 'package:provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import '../providers/sign_in_provider.dart';
import '../utils/GraphQL.dart';

class MyItems extends StatefulWidget {
  const MyItems({super.key});

  @override
  State<MyItems> createState() => _MyItemsState();
}

class _MyItemsState extends State<MyItems> {
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

    final String carQuery = '''
query{
  carsbyid(flipperUser: "${sp.uid}"){
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

    final String bikeQuery = '''
query{
  bikesbyid(flipperUser: "${sp.uid}"){
    id
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

    final String propertyQuery = '''
query{
  propertiesbyid(flipperUser: "${sp.uid}"){
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

    final String mobileQuery = '''
query{
  mobilesbyid(flipperUser: "${sp.uid}"){
    id
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

    final String jobQuery = '''
query{
  jobsbyid(flipperUser: "${sp.uid}"){
    id
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

    final String furnitureQuery = '''
query{
  furnituresbyid(flipperUser: "${sp.uid}"){
    id
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

    final String fashionQuery = '''
query{
  fashionsbyid(flipperUser: "${sp.uid}"){
    id
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

    final String elecQuery = '''
query{
  electronicappliancesbyid(flipperUser: "${sp.uid}"){
    id
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

    final String commQuery = '''
query{
  commsbyid(flipperUser: "${sp.uid}"){
    id
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

    final String bshQuery = '''
query{
  BSHsbyid(flipperUser: "${sp.uid}"){
    id
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

    final String petQuery = '''
query{
  petsbyid(flipperUser: "${sp.uid}"){
    id
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

    final String serviceQuery = '''
query{
  servicesbyid(flipperUser: "${sp.uid}"){
    id
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

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            nextScreen(context, NavBar());
          },
        ),
        title: const Text(
          'My Products',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
              children: [
                Image.asset(
                  'assets/icons/no_data.png',
                  scale: 8,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'There are no Items to Trade !!',
                  style: TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 15),
                ),
              ],
        ),
            ),
          ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  GraphQLProvider(
                      client: client,
                      child: graphql.Query(
                        options: QueryOptions(
                          document: gql(carQuery),
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

                          final List<dynamic> data = result.data?['carsbyid'];

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              var car = data[index];
                              var delCar = car['id'];
                              return GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 140,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 110,
                                                width: 110,
                                                child: Image(
                                                  image: NetworkImage(
                                                    httpLinkImage + car['carImage'],
                                                  ),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Container(
                                                height: 110,
                                                width: 215,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        overflow: TextOverflow.ellipsis,
                                                        '${car['carBrand']} ${car['carModel']}',
                                                        style: TextStyle(
                                                            color: Color(0xFF333333),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        overflow: TextOverflow.visible,
                                                        '₹ ${car['carPrice']} /-',
                                                        style: TextStyle(
                                                            color: Color(0xFF333333),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          size: 15,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            overflow:
                                                                TextOverflow.ellipsis,
                                                            "${car['carLocation']}",
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontSize: 15),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: IconButton(
                                            onPressed: () async {
                                              final String deleteCar = ''' 
                                             mutation delete{
                                              deleteCar(id: $delCar){
                                                  success
                                                    }
                                                  }''';
                                              final GraphQLClient _client = client
                                                  .value;
                                              final MutationOptions options = MutationOptions(
                                                document: gql(deleteCar),
                                              );
                                              final QueryResult result = await _client
                                                  .mutate(options);

                                              if (result.hasException) {
                                                print(
                                                    'Error deleting Car: ${result
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
                                ),
                              );
                            },
                          );
                        },
                      )),
                  GraphQLProvider(
                      client: client,
                      child: graphql.Query(
                        options: QueryOptions(
                          document: gql(propertyQuery),
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

                          final List<dynamic> data = result.data?['propertiesbyid'];

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              var prop = data[index];
                              var delprop = prop['id'];
                              return GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 140,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 110,
                                                width: 110,
                                                child: Image(
                                                  image: NetworkImage(
                                                    httpLinkImage + prop['propertyImage'],
                                                  ),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Container(
                                                height: 110,
                                                width: 215,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        overflow: TextOverflow.ellipsis,
                                                        '${prop['propertyTitle']}',
                                                        style: TextStyle(
                                                            color: Color(0xFF333333),
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight.w500),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        overflow: TextOverflow.visible,
                                                        '₹ ${prop['propertyPrice']} /-',
                                                        style: TextStyle(
                                                            color: Color(0xFF333333),
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight.w400),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          size: 15,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            overflow:
                                                            TextOverflow.ellipsis,
                                                            "${prop['propertyLocation']}",
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontSize: 15),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: IconButton(
                                            onPressed: () async {
                                              final String deleteProperty = ''' 
                                             mutation delete{
                                              deleteProperty(id: $delprop){
                                                  success
                                                    }
                                                  }''';
                                              final GraphQLClient _client = client
                                                  .value;
                                              final MutationOptions options = MutationOptions(
                                                document: gql(deleteProperty),
                                              );
                                              final QueryResult result = await _client
                                                  .mutate(options);

                                              if (result.hasException) {
                                                print(
                                                    'Error deleting Car: ${result
                                                        .exception.toString()}');
                                              } else {
                                                print('Deletion successful !');
                                                const snack = SnackBar(
                                                  content: Text('Property Deleted Successfully', style: TextStyle(
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
                                ),
                              );
                            },
                          );
                        },
                      )),
                  GraphQLProvider(
                    client: client,
                    child: graphql.Query(
                      options: QueryOptions(
                        document: gql(mobileQuery),
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

                        final List<dynamic> data = result.data?['mobilesbyid'];

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var mobile = data[index];
                            var delMob = mobile['id'];
                            return GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 110,
                                              width: 110,
                                              child: Image(
                                                image: NetworkImage(
                                                  httpLinkImage + mobile['mobileImage'],
                                                ),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              height: 110,
                                              width: 215,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      overflow: TextOverflow.ellipsis,
                                                      '${mobile['mobileTitle']}',
                                                      style:
                                                      TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      overflow:
                                                      TextOverflow.visible,
                                                      '₹ ${mobile['mobilePrice']} /-',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF333333),
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 15,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          "${mobile['mobileLocation']}",
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                          onPressed: () async {
                                            final String deleteMob = ''' 
                                             mutation delete{
                                              deleteMobile(id: $delMob){
                                                  success
                                                    }
                                                  }''';
                                            final GraphQLClient _client = client
                                                .value;
                                            final MutationOptions options = MutationOptions(
                                              document: gql(deleteMob),
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
                        document: gql(jobQuery),
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

                        final List<dynamic> data = result.data?['jobsbyid'];

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var job = data[index];
                            var deljob = job['id'];
                            return GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 110,
                                              width: 110,
                                              child: Image(
                                                image: NetworkImage(
                                                  httpLinkImage + job['jobImage'],
                                                ),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              height: 110,
                                              width: 215,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      overflow: TextOverflow.ellipsis,
                                                      '${job['jobTitle']}',
                                                      style:
                                                      TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      overflow: TextOverflow.ellipsis,
                                                      "₹ ${job['salaryRange']} /-",
                                                      style:
                                                      TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 15,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          "${job['jobLocation']}",
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                          onPressed: () async {
                                            final String deletejob = ''' 
                                             mutation delete{
                                              deleteJob(id: $deljob){
                                                  success
                                                    }
                                                  }''';
                                            final GraphQLClient _client = client
                                                .value;
                                            final MutationOptions options = MutationOptions(
                                              document: gql(deletejob),
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
                                                content: Text('Job Deleted Successfully', style: TextStyle(
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
                          document: gql(bikeQuery),
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

                          final List<dynamic> data = result.data?['bikesbyid'];

                          // if (data.isEmpty) {
                          //   return Center(
                          //     child: Column(
                          //       children: [
                          //         Image.asset(
                          //           'assets/icons/no_data.png',
                          //           scale: 3,
                          //         ),
                          //         SizedBox(
                          //           height: 20,
                          //         ),
                          //         Text(
                          //           'Looks like there is Nothing here !!',
                          //           style: TextStyle(
                          //               fontWeight: FontWeight.w300, fontSize: 17),
                          //         ),
                          //       ],
                          //     ),
                          //   );
                          // }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              var bike = data[index];
                              var delBike = bike['id'];
                              return GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 140,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 110,
                                                width: 110,
                                                child: Image(
                                                  image: NetworkImage(
                                                    httpLinkImage + bike['bikeImage'],
                                                  ),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Container(
                                                height: 110,
                                                width: 215,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        bike['bikeType'] ==
                                                                "Spare Part"
                                                            ? '${bike['spareTitle']}'
                                                            : (bike['bikeType'] ==
                                                                    "Bicycle"
                                                                ? '${bike['cycleTitle']}'
                                                                : '${bike['bikeBrand']} ${bike['bikeModel']} ${bike['bikeYear']}'),
                                                        style: TextStyle(
                                                          color: Color(0xFF333333),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        overflow:
                                                            TextOverflow.visible,
                                                        '₹ ${bike['bikePrice']} /-',
                                                        style: TextStyle(
                                                            color:
                                                                Color(0xFF333333),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          size: 15,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            "${bike['bikeLocation']}",
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: IconButton(
                                            onPressed: () async {
                                              final String deleteBike = ''' 
                                             mutation delete{
                                              deleteBike(id: $delBike){
                                                  success
                                                    }
                                                  }''';
                                              final GraphQLClient _client = client
                                                  .value;
                                              final MutationOptions options = MutationOptions(
                                                document: gql(deleteBike),
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
                        document: gql(furnitureQuery),
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

                        final List<dynamic> data = result.data?['furnituresbyid'];

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var furniture = data[index];
                            var delFur = furniture['id'];
                            return GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 110,
                                              width: 110,
                                              child: Image(
                                                image: NetworkImage(
                                                  httpLinkImage + furniture['furnitureImage'],
                                                ),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              height: 110,
                                              width: 215,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      overflow: TextOverflow.ellipsis,
                                                      '${furniture['furnitureTitle']}',
                                                      style:
                                                      TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      overflow:
                                                      TextOverflow.visible,
                                                      '₹ ${furniture['furniturePrice']} /-',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF333333),
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 15,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          "${furniture['furnitureLocation']}",
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                          onPressed: () async {
                                            final String deleteFur = ''' 
                                             mutation delete{
                                              deleteFurniture(id: $delFur){
                                                  success
                                                    }
                                                  }''';
                                            final GraphQLClient _client = client
                                                .value;
                                            final MutationOptions options = MutationOptions(
                                              document: gql(deleteFur),
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
                        document: gql(fashionQuery),
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

                        final List<dynamic> data = result.data?['fashionsbyid'];

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var fashion = data[index];
                            var delFash = fashion['id'];
                            return GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 110,
                                              width: 110,
                                              child: Image(
                                                image: NetworkImage(
                                                  httpLinkImage + fashion['fashionImage'],
                                                ),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              height: 110,
                                              width: 215,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      overflow: TextOverflow.ellipsis,
                                                      '${fashion['fashionTitle']}',
                                                      style:
                                                      TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      overflow:
                                                      TextOverflow.visible,
                                                      '₹ ${fashion['fashionPrice']} /-',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF333333),
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 15,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          "${fashion['fashionLocation']}",
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                          onPressed: () async {
                                            final String deleteFash = ''' 
                                             mutation delete{
                                              deleteFashion(id: $delFash){
                                                  success
                                                    }
                                                  }''';
                                            final GraphQLClient _client = client
                                                .value;
                                            final MutationOptions options = MutationOptions(
                                              document: gql(deleteFash),
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
                        document: gql(elecQuery),
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

                        final List<dynamic> data = result.data?['electronicappliancesbyid'];

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var elec = data[index];
                            var delelec = elec['id'];
                            return GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 110,
                                              width: 110,
                                              child: Image(
                                                image: NetworkImage(
                                                  httpLinkImage + elec['elecImage'],
                                                ),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              height: 110,
                                              width: 215,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      overflow: TextOverflow.ellipsis,
                                                      '${elec['elecTitle']}',
                                                      style:
                                                      TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      overflow:
                                                      TextOverflow.visible,
                                                      '₹ ${elec['elecPrice']} /-',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF333333),
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 15,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          "${elec['elecLocation']}",
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                          onPressed: () async {
                                            final String deleteElec = ''' 
                                             mutation delete{
                                              deleteElec(id: $delelec){
                                                  success
                                                    }
                                                  }''';
                                            final GraphQLClient _client = client
                                                .value;
                                            final MutationOptions options = MutationOptions(
                                              document: gql(deleteElec),
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
                        document: gql(commQuery),
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

                        final List<dynamic> data = result.data?['commsbyid'];

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var comm = data[index];
                            var delcom = comm['id'];
                            return GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 110,
                                              width: 110,
                                              child: Image(
                                                image: NetworkImage(
                                                  httpLinkImage + comm['commImage'],
                                                ),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              height: 110,
                                              width: 215,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
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
                                                  Expanded(
                                                    child: Text(
                                                      overflow:
                                                      TextOverflow.visible,
                                                      '₹ ${comm['commPrice']} /-',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF333333),
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 15,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          "${comm['commLocation']}",
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                          onPressed: () async {
                                            final String deleteComms = ''' 
                                             mutation delete{
                                              deleteComm(id: $delcom){
                                                  success
                                                    }
                                                  }''';
                                            final GraphQLClient _client = client
                                                .value;
                                            final MutationOptions options = MutationOptions(
                                              document: gql(deleteComms),
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
                        document: gql(bshQuery),
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

                        final List<dynamic> data = result.data?['BSHsbyid'];

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var bsh = data[index];
                            var delbsh = bsh['id'];
                            return GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 110,
                                              width: 110,
                                              child: Image(
                                                image: NetworkImage(
                                                  httpLinkImage + bsh['bshImage'],
                                                ),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              height: 110,
                                              width: 215,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      '${bsh['bshTitle']}',
                                                      style: TextStyle(
                                                        color: Color(0xFF333333),
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      overflow:
                                                      TextOverflow.visible,
                                                      '₹ ${bsh['bshPrice']} /-',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF333333),
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 15,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          "${bsh['bshLocation']}",
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                          onPressed: () async {
                                            final String deleteBSH = ''' 
                                             mutation delete{
                                              deleteBsh(id: $delbsh){
                                                  success
                                                    }
                                                  }''';
                                            final GraphQLClient _client = client
                                                .value;
                                            final MutationOptions options = MutationOptions(
                                              document: gql(deleteBSH),
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
                        document: gql(petQuery),
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

                        final List<dynamic> data = result.data?['petsbyid'];

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var pet = data[index];
                            var delpet = pet['id'];
                            return GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 110,
                                              width: 110,
                                              child: Image(
                                                image: NetworkImage(
                                                  httpLinkImage + pet['petImage'],
                                                ),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              height: 110,
                                              width: 215,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      '${pet['petTitle']}',
                                                      style: TextStyle(
                                                        color: Color(0xFF333333),
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      overflow:
                                                      TextOverflow.visible,
                                                      '₹ ${pet['petPrice']} /-',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF333333),
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 15,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          "${pet['petLocation']}",
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                          onPressed: () async {
                                            final String deletePet = ''' 
                                             mutation delete{
                                              deletePet(id: $delpet){
                                                  success
                                                    }
                                                  }''';
                                            final GraphQLClient _client = client
                                                .value;
                                            final MutationOptions options = MutationOptions(
                                              document: gql(deletePet),
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
                        document: gql(serviceQuery),
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

                        final List<dynamic> data = result.data?['servicesbyid'];

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var service = data[index];
                            var delser = service['id'];
                            return GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 110,
                                              width: 110,
                                              child: Image(
                                                image: NetworkImage(
                                                  httpLinkImage + service['serviceImage'],
                                                ),
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              height: 110,
                                              width: 215,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      '${service['serviceTitle']}',
                                                      style: TextStyle(
                                                        color: Color(0xFF333333),
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 15,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          "${service['serviceLocation']}",
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                          onPressed: () async {
                                            final String deleteService = ''' 
                                             mutation delete{
                                              deleteService(id: $delser){
                                                  success
                                                    }
                                                  }''';
                                            final GraphQLClient _client = client
                                                .value;
                                            final MutationOptions options = MutationOptions(
                                              document: gql(deleteService),
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
          ],
        ),
      ),
    );
  }
}
