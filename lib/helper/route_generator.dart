import 'package:flutter/material.dart';
import 'package:jobcdp/helper/config.dart';
import 'package:jobcdp/model/image.dart';
import 'package:jobcdp/views/Dashboard/dashboard.dart';
import 'package:jobcdp/views/LoginScreen/login.dart';
import 'package:jobcdp/views/ThankYou/thanks.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case RoutePaths.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case RoutePaths.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RoutePaths.thanks:
        return MaterialPageRoute(builder: (_) => ThanksScreen(imageData: args as List<ImageData>,));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
