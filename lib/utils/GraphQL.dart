import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';

final HttpLink httpLink = HttpLink('http://192.168.0.103:8000/graphql/');
final httpLinkC = 'http://192.168.0.103:8000';
final httpLinkImage = 'http://192.168.0.103:8000/media/';

final ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  ),
);
