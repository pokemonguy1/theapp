import 'package:flutter/material.dart';
import 'package:flutter_vendure_stor/app/constants/configConstant.dart';
import 'package:flutter_vendure_stor/app/constants/theme.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:http/http.dart' as http;

void main() async {
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    ConfigConstant.httpLink,
    httpClient: http.Client(),
  );
  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer <>',
  );

  final Link link = authLink.concat(httpLink);
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );
  runApp(
    GraphQLProvider(
      client: client,
      child: GetMaterialApp(
        title: "Application",
        debugShowCheckedModeBanner: false,
        theme: light,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}
