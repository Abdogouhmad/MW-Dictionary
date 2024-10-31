import 'package:flutter/material.dart';
import 'package:mwd/widgets/card.dart';
import '../widgets/searchbar.dart';
import '../colorpalette.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController input = TextEditingController();

  void checkInput(String word) {
    // Accept a String parameter
    if (word.isEmpty) {
      debugPrint("Input is empty");
    } else {
      debugPrint("Input is: $word");
      Navigator.pushNamed(context, '/define/$word');
      input.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDarkMode ? darkBackgroundColor : lightBackgroundColor,
        systemNavigationBarColor:
            isDarkMode ? darkBackgroundColor : lightBackgroundColor,
        systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Text(
                'MW-Dictionary',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoCondensed',
                  color: isDarkMode ? lightTitlesAndIcons : darkTitlesAndIcons,
                ),
              ),
            ),
            SearchBarWidget(
              input: input, // Pass the controller directly
              hintTextWidget: "Search Dictionary",
              onSubmit: checkInput, // Pass the function reference
            ),

            // card
            const CardWidget()
          ],
        ),
      ),
    );
  }
}
