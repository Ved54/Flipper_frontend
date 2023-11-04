import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../../utils/GraphQL.dart';

class ViewBarter extends StatefulWidget {
  const ViewBarter({super.key, required this.id});

  final String id;

  @override
  State<ViewBarter> createState() => _ViewBarterState();
}

class _ViewBarterState extends State<ViewBarter> {

  @override
  Widget build(BuildContext context) {

    final String getAuctionDetails = '''
  query{
  infoBarter(id: ${widget.id}){
    flipperUser
    barterTitle
    barterDescription
    barterRequirement
    barterLocation
    barterImage
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

            final Map<String, dynamic> data = result.data?['infoBarter'];

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
                            NetworkImage(httpLinkImage + data['barterImage']),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              overflow: TextOverflow.visible,
                              '${data['barterTitle']}', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
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
                              '${data['barterLocation']}', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
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
                              Icon(Icons.description),
                              SizedBox(width: 5,),
                              Text("Description", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),)
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text(
                            '${data['barterDescription']}', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
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
                              Text("Requirements", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),)
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text(
                            '${data['barterRequirement']}', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
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
