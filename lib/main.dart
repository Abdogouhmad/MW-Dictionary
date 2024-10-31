import 'package:flutter/material.dart';
import 'package:mwd/utils/genroutes.dart';
import './theme_configuration.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: light,
      darkTheme: dark,
      themeMode: ThemeMode.system,
      initialRoute: "/",
      onGenerateRoute: Genroutes.routesGenerator,
    );
  }
}
