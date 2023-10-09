import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mazha_app/screens/view_auction.dart';
import 'package:mazha_app/utils/next_screen.dart';
import '../utils/GraphQL.dart';

class Bidding extends StatefulWidget {
  const Bidding({super.key});

  @override
  State<Bidding> createState() => _BiddingState();
}

class _BiddingState extends State<Bidding> {

  final String auctionQuery = '''
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Auctions',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: GraphQLProvider(
        client: client,
        child: graphql.Query(
          options: QueryOptions(
            document: gql(auctionQuery),
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

            final List<dynamic> data = result.data?['displayAuctions'];

            if (data.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/no_data.png',scale: 3,),
                  SizedBox(height: 20,),
                  Text('Looks like there are no ongoing Auctions !!', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17),),
                ],
              );
            }
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index){
                var auction = data[index];
                return GestureDetector(
                  onTap: (){
                    nextScreen(context, ViewAuction(id: auction['id']));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      decoration: BoxDecoration(
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
                                  httpLinkImage + auction['productImage'],
                                ),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 110,
                              width: 215,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      overflow: TextOverflow.visible,
                                      '${auction['productTitle']}',
                                      style:
                                      TextStyle(color: Color(0xFF333333), fontSize: 17, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      overflow: TextOverflow.visible,
                                      'Base price : ₹ ${auction['basePrice']} /-',
                                      style:
                                      TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      overflow: TextOverflow.visible,
                                      'Min Bid : ₹ ${auction['minimumBid']} /-',
                                      style:
                                      TextStyle(color: Color(0xFF333333), fontSize: 15, fontWeight: FontWeight.w400),
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
                                          overflow: TextOverflow.ellipsis,
                                          "${auction['auctionLocation']}",
                                          style: TextStyle(color: Colors.grey, fontSize: 15),
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
                  ),
                );
              },
            );
          },
        )
      ),
    );
  }
}
