import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../colorpalette.dart';

class SearchBarWidget extends StatelessWidget {
  // Needed arguments
  final TextEditingController input;
  final String hintTextWidget;
  final double fontsize;
  final Color lightTextMode;
  final Color darkTextMode;
  final Color lightBgMode;
  final Color darkBgMode;
  final void Function(String) onSubmit;

  // Call theme here
  const SearchBarWidget({
    super.key,
    required this.input,
    required this.onSubmit,
    this.lightTextMode = lightTitlesAndIcons,
    this.darkTextMode = darkTitlesAndIcons,
    this.lightBgMode = lightCardBg,
    this.darkBgMode = darkCardBg,
    this.hintTextWidget = "Word to be defined",
    this.fontsize = 16.0,
  });

  // Widget build
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // configuration of system ui
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(
          height: 50.0,
          child: SearchBar(
            onSubmitted: onSubmit,
            autoFocus: true,
            controller: input,
            hintText: hintTextWidget,
            hintStyle: WidgetStatePropertyAll(TextStyle(
              fontFamily: 'Roboto',
              fontSize: fontsize,
              color: isDarkMode ? darkTextMode : lightTextMode,
            )),
            textStyle: WidgetStatePropertyAll(TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              fontSize: fontsize,
              color: isDarkMode ? darkTextMode : lightTextMode,
            )),
            backgroundColor: WidgetStatePropertyAll(
              Color((isDarkMode ? darkBgMode : lightBgMode).value),
            ),
            elevation: const WidgetStatePropertyAll(0), // Remove shadow
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(5), // Reduce corner radius to 5px
              ),
            ),
            leading: Icon(Icons.search,
                color: isDarkMode ? darkTextMode : lightTextMode),
          ),
        ),
      ),
    );
  }
}
