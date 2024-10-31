import 'package:flutter/material.dart';
import 'package:mwd/colorpalette.dart';
import 'package:mwd/components/text.dart';
import 'package:mwd/screens/define.dart';
import 'package:mwd/screens/home.dart';

class Genroutes {
  static Route<dynamic> routesGenerator(RouteSettings settings) {
    // Parse the URI to get the path segments
    final uri = Uri.parse(settings.name!);

    switch (uri.pathSegments.isNotEmpty ? '/${uri.pathSegments[0]}' : '/') {
      case '/':
        return MaterialPageRoute(builder: (_) => const MyHomePage());

      case '/define':
        // Check if there is an additional segment for the dynamic parameter
        if (uri.pathSegments.length == 2) {
          final word = uri.pathSegments[1];
          return MaterialPageRoute(
            builder: (_) => DefinePage(word: word),
          );
        }
        return _errorRoute();

      default:
        // Handle unknown routes
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: AppText.text(
          'ERROR: Page not found',
          font: "Roboto",
          sizefont: 30,
          ftweight: FontWeight.w700,
          ftcolor: redColor,
        ),
      ),
    );
  }
}
