import 'package:flutter/material.dart';

class NavigatorService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> pushNamed(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> push(dynamic route) {
    return navigatorKey.currentState
        .push(MaterialPageRoute(builder: (context) => route));
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object arguments}) {
    return navigatorKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName) {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }

  void popUntil(var route) {
    navigatorKey.currentState.popUntil((route) => route.isFirst);
  }

  void pop() {
    navigatorKey.currentState.pop();
  }

  void popWithData(dynamic data) {
    navigatorKey.currentState.pop(data);
  }

  void popRootNavigator() {
    Navigator.of(currentContext(), rootNavigator: true).pop('dialog');
  }

  BuildContext currentContext() {
    return navigatorKey.currentState.overlay.context;
  }
}
