import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import '../utils/GraphQL.dart';

class ViewAuction extends StatefulWidget {
  const ViewAuction({super.key, required this.id});

  final String id;

  @override
  State<ViewAuction> createState() => _ViewAuctionState();
}

class _ViewAuctionState extends State<ViewAuction> {

  @override
  Widget build(BuildContext context) {

    final String getAuctionDetails = '''
  query{
  Auctionsbyid(id: ${widget.id}){
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

    return GraphQLProvider(
      client: client,
      child: graphql.Query(
        options: QueryOptions(
          document: gql(getAuctionDetails),
        ),
          builder: (QueryResult result, {fetchMore, refetch}){
            if (result.hasException) {
              print("Exception");
              print(result.exception.toString());
              return Center(child: CircularProgressIndicator());
            }

            if (result.isLoading) {
              print("Loading");
              return Center(child: CircularProgressIndicator());
            }

            final Map<String, dynamic> data = result.data?['Auctionsbyid'];

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
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
                            image:
                            NetworkImage(httpLinkImage + data['productImage']),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              overflow: TextOverflow.visible,
                              '${data['productTitle']}', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
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
                              '${data['auctionLocation']}', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
                        child: Divider(thickness: 2,)
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info_outline),
                              SizedBox(width: 5,),
                              Text("About", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),)
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: 30,
                                child: Row(
                                  children: [
                                    Text("Base Price", textAlign: TextAlign.left, style: TextStyle(fontSize: 15),),
                                    Spacer(),
                                    Text(" : " , textAlign: TextAlign.right, style: TextStyle(fontSize: 15),),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,),
                              Text(
                                '₹ ${data['basePrice']} /-', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: 30,
                                child: Row(
                                  children: [
                                    Text("Minimum Bid", textAlign: TextAlign.left, style: TextStyle(fontSize: 15),),
                                    Spacer(),
                                    Text(" : " , textAlign: TextAlign.right, style: TextStyle(fontSize: 15),),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,),
                              Text(
                                '₹ ${data['minimumBid']} /-', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: 30,
                                child: Row(
                                  children: [
                                    Text("Date", textAlign: TextAlign.left, style: TextStyle(fontSize: 15),),
                                    Spacer(),
                                    Text(" : " , textAlign: TextAlign.right, style: TextStyle(fontSize: 15),),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,),
                              Text(
                                DateFormat('EEEE ,d MMM').format(DateTime.parse(data['auctionDate'] as String)), style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: 30,
                                child: Row(
                                  children: [
                                    Text("Time", textAlign: TextAlign.left, style: TextStyle(fontSize: 15),),
                                    Spacer(),
                                    Text(" : " , textAlign: TextAlign.right, style: TextStyle(fontSize: 15),),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20,),
                              Text(
                                DateFormat('h:m a').format(DateFormat('HH:mm:ss').parse(data['auctionTime'] as String)), style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
                        child: Divider(thickness: 2,)
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.description),
                              SizedBox(width: 5,),
                              Text("Description", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),)
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text(
                            '${data['auctionDescription']}', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
        }
      ),
    );
  }
}
