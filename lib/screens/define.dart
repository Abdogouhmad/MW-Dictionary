import 'package:flutter/material.dart';
import 'package:mwd/colorpalette.dart';
import 'package:mwd/components/text.dart';
import 'dart:io' as platform;

class DefinePage extends StatefulWidget {
  final String word;

  const DefinePage({super.key, required this.word});

  @override
  createState() => _DefinePageState();
}

class _DefinePageState extends State<DefinePage> {
  PreferredSizeWidget? _checkPlatform() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final barColor = isDarkMode ? primaryTextDark : primaryTextLight;

    if (platform.Platform.isLinux ||
        platform.Platform.isMacOS ||
        platform.Platform.isWindows) {
      return AppBar(
        title: AppText.text(
          "Home",
          font: "Roboto",
          sizefont: 20,
          ftweight: FontWeight.w500,
          ftcolor: barColor,
        ),
      );
    } else {
      // Return null if the platform is Android or iOS
      return null; // or you could return a SizedBox if you want a placeholder
    }
  }

  // TODO: widget combines (word, part of spch, IPA, sound)
  Widget _wordData() {
    return Container();
  }

  // TODO: widget combines (definition,  example(divider & text))
  Widget _WordDefine() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _checkPlatform(), // Call the method
      body: Center(
        child: AppText.text(
          widget.word,
          font: "Playfairdisplay",
          sizefont: 30,
          ftweight: FontWeight.w700,
          ftcolor: greenColor,
        ),
      ),
    );
  }
}
