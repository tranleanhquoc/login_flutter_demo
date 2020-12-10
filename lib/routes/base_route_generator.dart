import 'package:flutter/material.dart';

abstract class BaseRouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings);

  Route<dynamic> unknownRoute(RouteSettings settings);

  Route<dynamic> errorRoute(String route, {String error = ''}) {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: const Text('Not found'),
        ),
        body: Center(
          child: Text('Error routes to $route with error $error'),
        ),
      );
    });
  }
}
