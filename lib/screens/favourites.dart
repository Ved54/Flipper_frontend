import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import '../Product Uploads/Bike Upload/view_bike.dart';
import '../Product Uploads/Bike Upload/view_cycle.dart';
import '../Product Uploads/Bike Upload/view_spare.dart';
import '../Product Uploads/Book, Sport and Hobby Upload/view_bsh.dart';
import '../Product Uploads/Car Upload/view_car.dart';
import '../Product Uploads/Commercial Vehicle and Spare Upload/view_commSpare.dart';
import '../Product Uploads/Commercial Vehicle and Spare Upload/view_commvehicle.dart';
import '../Product Uploads/Electronic and Appliance Upload /view_elecApp.dart';
import '../Product Uploads/Fashion Upload/view_fashion.dart';
import '../Product Uploads/Furniture Upload/view_furniture.dart';
import '../Product Uploads/Job Upload/view_job.dart';
import '../Product Uploads/Mobile Upload/view_accessory.dart';
import '../Product Uploads/Mobile Upload/view_mobile.dart';
import '../Product Uploads/Pet Upload/view_pet.dart';
import '../Product Uploads/Property Upload/view_property.dart';
import '../Product Uploads/Service Upload/view_service.dart';
import '../providers/sign_in_provider.dart';
import '../utils/GraphQL.dart';
import '../utils/next_screen.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  String type = "";

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  List<bool> isHeartFilledList = [];

  @override
  void initState() {
    super.initState();
    getData();
    isHeartFilledList = List.generate(1000000, (index) => true);
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    final String getBarterFavQuery = '''
    query{
  barterFavbyId(flipperUser:"${sp.uid}"){
    id
    barterId{
      id
      flipperUser
      barterTitle
      barterDescription
      barterRequirement
      barterLocation
      barterImage
    }
  }
}
    ''';
    final String getFavQuery = '''
    query{
  displayFavbyId(flipperUser: "${sp.uid}"){
    id
    flipperType
    carId{
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
    propertyId{
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
    mobileId{
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
    jobId{
      id
      flipperUser
      flipperType
      jobType
      jobTitle
      salaryPeriod
      positionType
      salaryRange
      jobDescription
      jobLocation
      jobImage
    }
    bikeId{
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
    furnitureId{
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
    fashionId{
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
    elecId{
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
    commId{
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
    bshId{
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
    petId{
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
    serviceId{
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
}
    ''';

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                text: 'Products',
              ),
              Tab(
                text: 'Barters',
              ),
            ],
          ),
          title: Text(
            'Favorites',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: TabBarView(
            children: [
              GraphQLProvider(
                client: client,
                child: graphql.Query(
                  options: QueryOptions(
                    document: gql(getFavQuery),
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

                    final List<dynamic> data = result.data?['displayFavbyId'];
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
                            'You have not added anything to Favorites !!',
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
                        var car = data[index]['carId'];
                        var property = data[index]['propertyId'];
                        var mobile = data[index]['mobileId'];
                        var job = data[index]['jobId'];
                        var bike = data[index]['bikeId'];
                        var furniture = data[index]['furnitureId'];
                        var fashion = data[index]['fashionId'];
                        var elec = data[index]['elecId'];
                        var comm = data[index]['commId'];
                        var bsh = data[index]['bshId'];
                        var pet = data[index]['petId'];
                        var service = data[index]['serviceId'];
                        if (data[index]['flipperType'] == 'Car') {
                          return GestureDetector(
                            onTap: () {
                              nextScreen(
                                  context,
                                  ViewCar(
                                      carId: car['id'],
                                      userId: car['flipperUser'],
                                      flipperType: car['flipperType'],
                                      carBrand: car['carBrand'],
                                      carModel: car['carModel'],
                                      carVariant: car['carVariant'],
                                      carYear: car['carYear'],
                                      carFuelType: car['carFuelType'],
                                      carTransmission: car['carTransmission'],
                                      carKmDriven: car['carKmDriven'],
                                      carOwnerNum: car['carOwnerNum'],
                                      carDescription: car['carDescription'],
                                      carLocation: car['carLocation'],
                                      carPrice: car['carPrice'],
                                      carImage:
                                          httpLinkImage + car['carImage']));
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
                                      MediaQuery.of(context).size.width * 0.5,
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
                                              httpLinkImage + car['carImage'],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "₹ ${car['carPrice']} /-",
                                          style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Expanded(
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            '${car['carBrand']} ${car['carModel']}',
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
                                  ),
                                ),
                                Positioned(
                                  left: 150,
                                  child: GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        isHeartFilledList[index] =
                                            !isHeartFilledList[index];
                                      });
                                      if (isHeartFilledList[index] == false) {
                                        final String deleteUserMutation = ''' 
                                         mutation delete{
                                            deleteFav(flipperUser: "${sp.uid}" id: ${data[index]['id']}){
                                              success
                                            }
                                         }''';
                                        final GraphQLClient _client =
                                            client.value;
                                        final MutationOptions options =
                                            MutationOptions(
                                          document: gql(deleteUserMutation),
                                        );
                                        final QueryResult result =
                                            await _client.mutate(options);

                                        if (result.hasException) {
                                          print(
                                              'Error deleting Favorites: ${result.exception.toString()}');
                                        } else {
                                          print('Deletion successful !');
                                        }
                                      }
                                    },
                                    child: Icon(
                                      isHeartFilledList[index]
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: isHeartFilledList[index]
                                          ? Colors.red
                                          : null,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        if (data[index]['flipperType'] == 'Property') {
                          return GestureDetector(
                            onTap: () {
                              nextScreen(
                                  context,
                                  ViewProperty(
                                      userId: property['flipperUser'],
                                      propertyType: property['propertyType'],
                                      propertyTitle: property['propertyTitle'],
                                      propertyDescription:
                                          property['propertyDescription'],
                                      propertyLocation:
                                          property['propertyLocation'],
                                      propertyPrice: property['propertyPrice'],
                                      propertyImage: httpLinkImage +
                                          property['propertyImage']));
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
                                      MediaQuery.of(context).size.width * 0.5,
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
                                                  property['propertyImage'],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "₹ ${property['propertyPrice']} /-",
                                          style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${property['propertyTitle']}',
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
                                                "${property['propertyLocation']}",
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
                                        isHeartFilledList[index] =
                                            !isHeartFilledList[index];
                                      });
                                      if (isHeartFilledList[index] == false) {
                                        final String deleteUserMutation = ''' 
                                         mutation delete{
                                            deleteFav(flipperUser: "${sp.uid}" id: ${data[index]['id']}){
                                              success
                                            }
                                         }''';
                                        final GraphQLClient _client =
                                            client.value;
                                        final MutationOptions options =
                                            MutationOptions(
                                          document: gql(deleteUserMutation),
                                        );
                                        final QueryResult result =
                                            await _client.mutate(options);

                                        if (result.hasException) {
                                          print(
                                              'Error deleting Favorites: ${result.exception.toString()}');
                                        } else {
                                          print('Deletion successful !');
                                        }
                                      }
                                    },
                                    child: Icon(
                                      isHeartFilledList[index]
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: isHeartFilledList[index]
                                          ? Colors.red
                                          : null,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        if (data[index]['flipperType'] == 'Mobile') {
                          return GestureDetector(
                            onTap: () {
                              if (mobile['accessoryType'] != "") {
                                nextScreen(
                                    context,
                                    ViewAccessory(
                                        userId: mobile['flipperUser'],
                                        accessoryType: mobile['accessoryType'],
                                        flipperType: mobile['flipperType'],
                                        mobileTitle: mobile['mobileTitle'],
                                        mobileDescription:
                                            mobile['mobileDescription'],
                                        mobileLocation:
                                            mobile['mobileLocation'],
                                        mobileImage: httpLinkImage +
                                            mobile['mobileImage'],
                                        mobilePrice: mobile['mobilePrice']));
                              } else {
                                nextScreen(
                                    context,
                                    ViewMobile(
                                        userId: mobile['flipperUser'],
                                        accessoryType: mobile['accessoryType'],
                                        flipperType: mobile['flipperType'],
                                        mobileBrand: mobile['mobileBrand'],
                                        mobileTitle: mobile['mobileTitle'],
                                        mobileDescription:
                                            mobile['mobileDescription'],
                                        mobileLocation:
                                            mobile['mobileLocation'],
                                        mobileImage: httpLinkImage +
                                            mobile['mobileImage'],
                                        mobilePrice: mobile['mobilePrice']));
                              }
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
                                      MediaQuery.of(context).size.width * 0.5,
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
                                                  mobile['mobileImage'],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "₹ ${mobile['mobilePrice']} /-",
                                          style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${mobile['mobileTitle']}',
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
                                                "${mobile['mobileLocation']}",
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
                                        isHeartFilledList[index] =
                                            !isHeartFilledList[index];
                                      });
                                      if (isHeartFilledList[index] == false) {
                                        final String deleteUserMutation = ''' 
                                         mutation delete{
                                            deleteFav(flipperUser: "${sp.uid}" id: ${data[index]['id']}){
                                              success
                                            }
                                         }''';
                                        final GraphQLClient _client =
                                            client.value;
                                        final MutationOptions options =
                                            MutationOptions(
                                          document: gql(deleteUserMutation),
                                        );
                                        final QueryResult result =
                                            await _client.mutate(options);

                                        if (result.hasException) {
                                          print(
                                              'Error deleting Favorites: ${result.exception.toString()}');
                                        } else {
                                          print('Deletion successful !');
                                        }
                                      }
                                    },
                                    child: Icon(
                                      isHeartFilledList[index]
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: isHeartFilledList[index]
                                          ? Colors.red
                                          : null,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        if (data[index]['flipperType'] == 'Job') {
                          return GestureDetector(
                            onTap: () {
                              nextScreen(
                                  context,
                                  ViewJob(
                                    userId: job['flipperUser'],
                                    flipperType: job['flipperType'],
                                    jobType: job['jobType'],
                                    jobTitle: job['jobTitle'],
                                    jobDescription: job['jobDescription'],
                                    jobLocation: job['jobLocation'],
                                    jobImage: httpLinkImage + job['jobImage'],
                                    positionType: job['positionType'],
                                    salaryPeriod: job['salaryPeriod'],
                                    salaryRange: job['salaryRange'],
                                  ));
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
                                      MediaQuery.of(context).size.width * 0.5,
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
                                              httpLinkImage + job['jobImage'],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "₹ ${job['salaryRange']} /-",
                                          style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${job['jobTitle']}',
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
                                                "${job['jobLocation']}",
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
                                        isHeartFilledList[index] =
                                            !isHeartFilledList[index];
                                      });
                                      if (isHeartFilledList[index] == false) {
                                        final String deleteUserMutation = ''' 
                                         mutation delete{
                                            deleteFav(flipperUser: "${sp.uid}" id: ${data[index]['id']}){
                                              success
                                            }
                                         }''';
                                        final GraphQLClient _client =
                                            client.value;
                                        final MutationOptions options =
                                            MutationOptions(
                                          document: gql(deleteUserMutation),
                                        );
                                        final QueryResult result =
                                            await _client.mutate(options);

                                        if (result.hasException) {
                                          print(
                                              'Error deleting Favorites: ${result.exception.toString()}');
                                        } else {
                                          print('Deletion successful !');
                                        }
                                      }
                                    },
                                    child: Icon(
                                      isHeartFilledList[index]
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: isHeartFilledList[index]
                                          ? Colors.red
                                          : null,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        if (data[index]['flipperType'] == 'Bike') {
                          return GestureDetector(
                            onTap: () {
                              if (bike['bikeType'] == "Spare Part") {
                                nextScreen(
                                    context,
                                    ViewBikeSparePart(
                                        userId: bike['flipperUser'],
                                        flipperType: bike['flipperType'],
                                        spareTitle: bike['spareTitle'],
                                        bikeDescription:
                                            bike['bikeDescription'],
                                        bikeLocation: bike['bikeLocation'],
                                        bikePrice: bike['bikePrice'],
                                        bikeImage:
                                            httpLinkImage + bike['bikeImage']));
                              } else if (bike['bikeType'] == "Bicycle") {
                                nextScreen(
                                    context,
                                    ViewCycle(
                                        userId: bike['flipperUser'],
                                        flipperType: bike['flipperType'],
                                        cycleTitle: bike['cycleTitle'],
                                        bikeBrand: bike['bikeBrand'],
                                        bikeDescription:
                                            bike['bikeDescription'],
                                        bikeLocation: bike['bikeLocation'],
                                        bikePrice: bike['bikePrice'],
                                        bikeImage:
                                            httpLinkImage + bike['bikeImage']));
                              } else {
                                nextScreen(
                                    context,
                                    ViewBike(
                                        userId: bike['flipperUser'],
                                        flipperType: bike['flipperType'],
                                        bikeType: bike['bikeType'],
                                        bikeBrand: bike['bikeBrand'],
                                        bikeModel: bike['bikeModel'],
                                        bikeYear: bike['bikeYear'],
                                        bikeKmDriven: bike['bikeKmDriven'],
                                        bikeOwnerNum: bike['bikeOwnerNum'],
                                        bikeDescription:
                                            bike['bikeDescription'],
                                        bikeLocation: bike['bikeLocation'],
                                        bikePrice: bike['bikePrice'],
                                        bikeImage:
                                            httpLinkImage + bike['bikeImage']));
                              }
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
                                      MediaQuery.of(context).size.width * 0.5,
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
                                              httpLinkImage + bike['bikeImage'],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "₹ ${bike['bikePrice']} /-",
                                          style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
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
                                        isHeartFilledList[index] =
                                            !isHeartFilledList[index];
                                      });
                                      if (isHeartFilledList[index] == false) {
                                        final String deleteUserMutation = ''' 
                                         mutation delete{
                                            deleteFav(flipperUser: "${sp.uid}" id: ${data[index]['id']}){
                                              success
                                            }
                                         }''';
                                        final GraphQLClient _client =
                                            client.value;
                                        final MutationOptions options =
                                            MutationOptions(
                                          document: gql(deleteUserMutation),
                                        );
                                        final QueryResult result =
                                            await _client.mutate(options);

                                        if (result.hasException) {
                                          print(
                                              'Error deleting Favorites: ${result.exception.toString()}');
                                        } else {
                                          print('Deletion successful !');
                                        }
                                      }
                                    },
                                    child: Icon(
                                      isHeartFilledList[index]
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: isHeartFilledList[index]
                                          ? Colors.red
                                          : null,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        if (data[index]['flipperType'] == 'Furniture') {
                          return GestureDetector(
                            onTap: () {
                              nextScreen(
                                  context,
                                  ViewFurniture(
                                      userId: furniture['flipperUser'],
                                      furnitureType: furniture['furnitureType'],
                                      furnitureTitle:
                                          furniture['furnitureTitle'],
                                      furnitureDescription:
                                          furniture['furnitureDescription'],
                                      furnitureLocation:
                                          furniture['furnitureLocation'],
                                      furniturePrice:
                                          furniture['furniturePrice'],
                                      furnitureImage: httpLinkImage +
                                          furniture['furnitureImage']));
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
                                      MediaQuery.of(context).size.width * 0.5,
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
                                                  furniture['furnitureImage'],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "₹ ${furniture['furniturePrice']} /-",
                                          style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Expanded(
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            '${furniture['furnitureTitle']}',
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
                                                "${furniture['furnitureLocation']}",
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
                                        isHeartFilledList[index] =
                                            !isHeartFilledList[index];
                                      });
                                      if (isHeartFilledList[index] == false) {
                                        final String deleteUserMutation = ''' 
                                         mutation delete{
                                            deleteFav(flipperUser: "${sp.uid}" id: ${data[index]['id']}){
                                              success
                                            }
                                         }''';
                                        final GraphQLClient _client =
                                            client.value;
                                        final MutationOptions options =
                                            MutationOptions(
                                          document: gql(deleteUserMutation),
                                        );
                                        final QueryResult result =
                                            await _client.mutate(options);

                                        if (result.hasException) {
                                          print(
                                              'Error deleting Favorites: ${result.exception.toString()}');
                                        } else {
                                          print('Deletion successful !');
                                        }
                                      }
                                    },
                                    child: Icon(
                                      isHeartFilledList[index]
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: isHeartFilledList[index]
                                          ? Colors.red
                                          : null,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        if (data[index]['flipperType'] == 'Fashion') {
                          return GestureDetector(
                            onTap: () {
                              nextScreen(
                                  context,
                                  ViewFashion(
                                      userId: fashion['flipperUser'],
                                      fashionType: fashion['fashionType'],
                                      fashionTitle: fashion['fashionTitle'],
                                      fashionDescription:
                                          fashion['fashionDescription'],
                                      fashionLocation:
                                          fashion['fashionLocation'],
                                      fashionPrice: fashion['fashionPrice'],
                                      fashionImage: httpLinkImage +
                                          fashion['fashionImage']));
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
                                      MediaQuery.of(context).size.width * 0.5,
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
                                                  fashion['fashionImage'],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "₹ ${fashion['fashionPrice']} /-",
                                          style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Expanded(
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            '${fashion['fashionTitle']}',
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
                                                "${fashion['fashionLocation']}",
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
                                        isHeartFilledList[index] =
                                            !isHeartFilledList[index];
                                      });
                                      if (isHeartFilledList[index] == false) {
                                        final String deleteUserMutation = ''' 
                                         mutation delete{
                                            deleteFav(flipperUser: "${sp.uid}" id: ${data[index]['id']}){
                                              success
                                            }
                                         }''';
                                        final GraphQLClient _client =
                                            client.value;
                                        final MutationOptions options =
                                            MutationOptions(
                                          document: gql(deleteUserMutation),
                                        );
                                        final QueryResult result =
                                            await _client.mutate(options);

                                        if (result.hasException) {
                                          print(
                                              'Error deleting Favorites: ${result.exception.toString()}');
                                        } else {
                                          print('Deletion successful !');
                                        }
                                      }
                                    },
                                    child: Icon(
                                      isHeartFilledList[index]
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: isHeartFilledList[index]
                                          ? Colors.red
                                          : null,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        if (data[index]['flipperType'] == 'ElecApp') {
                          return GestureDetector(
                            onTap: () {
                              nextScreen(
                                  context,
                                  ViewElecApp(
                                      userId: elec['flipperUser'],
                                      elecType: elec['elecType'],
                                      elecTitle: elec['elecTitle'],
                                      elecDescription: elec['elecDescription'],
                                      elecLocation: elec['elecLocation'],
                                      elecPrice: elec['elecPrice'],
                                      elecImage:
                                          httpLinkImage + elec['elecImage']));
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
                                      MediaQuery.of(context).size.width * 0.5,
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
                                              httpLinkImage + elec['elecImage'],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "₹ ${elec['elecPrice']} /-",
                                          style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Expanded(
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            '${elec['elecTitle']}',
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
                                                "${elec['elecLocation']}",
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
                                        isHeartFilledList[index] =
                                            !isHeartFilledList[index];
                                      });
                                      if (isHeartFilledList[index] == false) {
                                        final String deleteUserMutation = ''' 
                                         mutation delete{
                                            deleteFav(flipperUser: "${sp.uid}" id: ${data[index]['id']}){
                                              success
                                            }
                                         }''';
                                        final GraphQLClient _client =
                                            client.value;
                                        final MutationOptions options =
                                            MutationOptions(
                                          document: gql(deleteUserMutation),
                                        );
                                        final QueryResult result =
                                            await _client.mutate(options);

                                        if (result.hasException) {
                                          print(
                                              'Error deleting Favorites: ${result.exception.toString()}');
                                        } else {
                                          print('Deletion successful !');
                                        }
                                      }
                                    },
                                    child: Icon(
                                      isHeartFilledList[index]
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: isHeartFilledList[index]
                                          ? Colors.red
                                          : null,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        if (data[index]['flipperType'] == 'Comm') {
                          return GestureDetector(
                            onTap: () {
                              if (comm['spareTitle'] != "") {
                                nextScreen(
                                    context,
                                    ViewCommSparePart(
                                        userId: comm['flipperUser'],
                                        flipperType: comm['flipperType'],
                                        spareTitle: comm['spareTitle'],
                                        commDescription:
                                            comm['commDescription'],
                                        commLocation: comm['commLocation'],
                                        commPrice: comm['commPrice'],
                                        commImage:
                                            httpLinkImage + comm['commImage']));
                              } else {
                                nextScreen(
                                    context,
                                    ViewComm(
                                        userId: comm['flipperUser'],
                                        flipperType: comm['flipperType'],
                                        commType: comm['commType'],
                                        commTitle: comm['commTitle'],
                                        commBrand: comm['commBrand'],
                                        commYear: comm['commYear'],
                                        commKmDriven: comm['commKmDriven'],
                                        commDescription:
                                            comm['commDescription'],
                                        commLocation: comm['commLocation'],
                                        commPrice: comm['commPrice'],
                                        commImage:
                                            httpLinkImage + comm['commImage']));
                              }
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
                                      MediaQuery.of(context).size.width * 0.5,
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
                                              httpLinkImage + comm['commImage'],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "₹ ${comm['commPrice']} /-",
                                          style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
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
                                        isHeartFilledList[index] =
                                            !isHeartFilledList[index];
                                      });
                                      if (isHeartFilledList[index] == false) {
                                        final String deleteUserMutation = ''' 
                                         mutation delete{
                                            deleteFav(flipperUser: "${sp.uid}" id: ${data[index]['id']}){
                                              success
                                            }
                                         }''';
                                        final GraphQLClient _client =
                                            client.value;
                                        final MutationOptions options =
                                            MutationOptions(
                                          document: gql(deleteUserMutation),
                                        );
                                        final QueryResult result =
                                            await _client.mutate(options);

                                        if (result.hasException) {
                                          print(
                                              'Error deleting Favorites: ${result.exception.toString()}');
                                        } else {
                                          print('Deletion successful !');
                                        }
                                      }
                                    },
                                    child: Icon(
                                      isHeartFilledList[index]
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: isHeartFilledList[index]
                                          ? Colors.red
                                          : null,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        if (data[index]['flipperType'] == 'BSH') {
                          return GestureDetector(
                            onTap: () {
                              nextScreen(
                                  context,
                                  ViewBSH(
                                      userId: bsh['flipperUser'],
                                      bshType: bsh['bshType'],
                                      bshTitle: bsh['bshTitle'],
                                      bshDescription: bsh['bshDescription'],
                                      bshLocation: bsh['bshLocation'],
                                      bshPrice: bsh['bshPrice'],
                                      bshImage:
                                          httpLinkImage + bsh['bshImage']));
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
                                      MediaQuery.of(context).size.width * 0.5,
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
                                              httpLinkImage + bsh['bshImage'],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "₹ ${bsh['bshPrice']} /-",
                                          style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Expanded(
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            '${bsh['bshTitle']}',
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
                                                "${bsh['bshLocation']}",
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
                                        isHeartFilledList[index] =
                                            !isHeartFilledList[index];
                                      });
                                      if (isHeartFilledList[index] == false) {
                                        final String deleteUserMutation = ''' 
                                         mutation delete{
                                            deleteFav(flipperUser: "${sp.uid}" id: ${data[index]['id']}){
                                              success
                                            }
                                         }''';
                                        final GraphQLClient _client =
                                            client.value;
                                        final MutationOptions options =
                                            MutationOptions(
                                          document: gql(deleteUserMutation),
                                        );
                                        final QueryResult result =
                                            await _client.mutate(options);

                                        if (result.hasException) {
                                          print(
                                              'Error deleting Favorites: ${result.exception.toString()}');
                                        } else {
                                          print('Deletion successful !');
                                        }
                                      }
                                    },
                                    child: Icon(
                                      isHeartFilledList[index]
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: isHeartFilledList[index]
                                          ? Colors.red
                                          : null,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        if (data[index]['flipperType'] == 'Pet') {
                          return GestureDetector(
                            onTap: () {
                              nextScreen(
                                  context,
                                  ViewPet(
                                      userId: pet['flipperUser'],
                                      petType: pet['petType'],
                                      petTitle: pet['petTitle'],
                                      petDescription: pet['petDescription'],
                                      petLocation: pet['petLocation'],
                                      petPrice: pet['petPrice'],
                                      petImage:
                                          httpLinkImage + pet['petImage']));
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
                                      MediaQuery.of(context).size.width * 0.5,
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
                                              httpLinkImage + pet['petImage'],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "₹ ${pet['petPrice']} /-",
                                          style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Expanded(
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            '${pet['petTitle']}',
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
                                                "${pet['petLocation']}",
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
                                        isHeartFilledList[index] =
                                            !isHeartFilledList[index];
                                      });
                                      if (isHeartFilledList[index] == false) {
                                        final String deleteUserMutation = ''' 
                                         mutation delete{
                                            deleteFav(flipperUser: "${sp.uid}" id: ${data[index]['id']}){
                                              success
                                            }
                                         }''';
                                        final GraphQLClient _client =
                                            client.value;
                                        final MutationOptions options =
                                            MutationOptions(
                                          document: gql(deleteUserMutation),
                                        );
                                        final QueryResult result =
                                            await _client.mutate(options);

                                        if (result.hasException) {
                                          print(
                                              'Error deleting Favorites: ${result.exception.toString()}');
                                        } else {
                                          print('Deletion successful !');
                                        }
                                      }
                                    },
                                    child: Icon(
                                      isHeartFilledList[index]
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: isHeartFilledList[index]
                                          ? Colors.red
                                          : null,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        if (data[index]['flipperType'] == 'Service') {
                          return GestureDetector(
                            onTap: () {
                              nextScreen(
                                  context,
                                  ViewService(
                                    userId: service['flipperUser'],
                                    flipperType: service['flipperType'],
                                    serviceType: service['serviceType'],
                                    serviceTitle: service['serviceTitle'],
                                    serviceDescription:
                                        service['serviceDescription'],
                                    serviceLocation: service['serviceLocation'],
                                    serviceImage:
                                        httpLinkImage + service['serviceImage'],
                                  ));
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
                                      MediaQuery.of(context).size.width * 0.5,
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
                                                  service['serviceImage'],
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
                                                "${service['serviceLocation']}",
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
                                        isHeartFilledList[index] =
                                            !isHeartFilledList[index];
                                      });
                                      if (isHeartFilledList[index] == false) {
                                        final String deleteUserMutation = ''' 
                                         mutation delete{
                                            deleteFav(flipperUser: "${sp.uid}" id: ${data[index]['id']}){
                                              success
                                            }
                                         }''';
                                        final GraphQLClient _client =
                                            client.value;
                                        final MutationOptions options =
                                            MutationOptions(
                                          document: gql(deleteUserMutation),
                                        );
                                        final QueryResult result =
                                            await _client.mutate(options);

                                        if (result.hasException) {
                                          print(
                                              'Error deleting Favorites: ${result.exception.toString()}');
                                        } else {
                                          print('Deletion successful !');
                                        }
                                      }
                                    },
                                    child: Icon(
                                      isHeartFilledList[index]
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: isHeartFilledList[index]
                                          ? Colors.red
                                          : null,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              GraphQLProvider(
                client: client,
                child: graphql.Query(
                    options: QueryOptions(
                      document: gql(getBarterFavQuery),
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
                      final List<dynamic> data = result.data?['barterFavbyId'];
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
                              'You have not added anything to Favorites !!',
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
                            var barter = data[index]['barterId'];
                            return GestureDetector(
                              onTap: () {

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
                                    MediaQuery.of(context).size.width * 0.5,
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
                                          isHeartFilledList[index] =
                                          !isHeartFilledList[index];
                                        });
                                        if (isHeartFilledList[index] == false) {
                                          final String deletebarFav = '''
                                         mutation delete{
                                            deleteBarterfav(flipperUser: "${sp.uid}" id: ${data[index]['id']}){
                                              success
                                            }
                                         }''';
                                          final GraphQLClient _client =
                                              client.value;
                                          final MutationOptions options =
                                          MutationOptions(
                                            document: gql(deletebarFav),
                                          );
                                          final QueryResult result =
                                          await _client.mutate(options);

                                          if (result.hasException) {
                                            print(
                                                'Error deleting Favorites: ${result.exception.toString()}');
                                          } else {
                                            print('Deletion successful !');
                                          }
                                        }
                                      },
                                      child: Icon(
                                        isHeartFilledList[index]
                                            ? CupertinoIcons.heart_fill
                                            : CupertinoIcons.heart,
                                        color: isHeartFilledList[index]
                                            ? Colors.red
                                            : null,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
