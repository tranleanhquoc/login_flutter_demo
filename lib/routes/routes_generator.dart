import '../routes/base_route_generator.dart';
import '../routes/routes_name.dart';
import '../screens/authentication/authentication_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/register_1/register_1_screen.dart';
import '../screens/register_2/register_2_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoutesGenerator extends BaseRouteGenerator {
  @override
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RoutesName.authen:
        return CupertinoPageRoute(builder: (_) => AuthenticationScreen());
      case RoutesName.register1:
        return CupertinoPageRoute(builder: (_) => Register1Screen());
      case RoutesName.login:
        return CupertinoPageRoute(builder: (_) => LoginScreen());
      case RoutesName.register2:
        return CupertinoPageRoute(
            builder: (_) => Register2Screen(registerValue: args));
      case RoutesName.dashboard:
        return CupertinoPageRoute(builder: (_) => DashboardScreen());
      default:
        return errorRoute(settings.name, error: "unknown error");
    }
  }

  @override
  Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
      builder: (context) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(title: Text(settings.name)),
        body: Center(
          child: Text('No route defined for ${settings.name}'),
        ),
      ),
    );
  }
}
