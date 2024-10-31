import 'package:flutter/material.dart';
import 'package:mwd/colorpalette.dart';
import 'package:mwd/components/text.dart';

class DefinePage extends StatefulWidget {
  final String word;

  const DefinePage({super.key, required this.word});

  @override
  createState() => _DefinePageState();
}

class _DefinePageState extends State<DefinePage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final barColor = isDarkMode ? primaryTextDark : primaryTextLight;
    return Scaffold(
      appBar: AppBar(
        title: AppText.text(
          "Definition of ${widget.word}",
          font: "Roboto",
          sizefont: 20,
          ftweight: FontWeight.w500,
          ftcolor: barColor,
        ),
      ),
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
