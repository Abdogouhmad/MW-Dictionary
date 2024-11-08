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
      return null;
    }
  }

  // Widget that combines word, part of speech, IPA, and sound button
  Widget _wordData(BuildContext ctx) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final wordColored = isDarkMode ? primaryTextDark : primaryTextLight;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppText.text(
                  "Dilemma",
                  font: "Playfairdisplay",
                  sizefont: 30,
                  ftcolor: wordColored,
                  ftweight: FontWeight.w700,
                  selectable: true,
                ),
                AppText.text(
                  " . Noun",
                  ftcolor: blueColor,
                  font: "Playfairdisplay",
                  sizefont: 30,
                  ftweight: FontWeight.w700,
                  selectable: true,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: AppText.text(
                "di·​lem·​ma",
                font: "Roboto",
                sizefont: 20.0,
                ftcolor: yellowColor,
                ftweight: FontWeight.w500,
                selectable: true,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            debugPrint("Pressed Listen");
          },
          tooltip: "listen to word: ${widget.word}",
          iconSize: 20.0,
          color: Colors.orange,
          icon: const Icon(Icons.volume_up),
        ),
      ],
    );
  }

  // Widget that combines definition, example, and numbering
  Widget _wordDefine(
      BuildContext ctx, String definition, String example, int number) {
    final isDarkMode = Theme.of(ctx).brightness == Brightness.dark;
    final defColor = isDarkMode ? primaryTextDark : primaryTextLight;
    final exmplColor = isDarkMode ? secondaryTextDark : secondaryTextLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '$number. ', // Dynamic numbering
            style: TextStyle(
                fontSize: 18, color: defColor, fontWeight: FontWeight.w500),
            children: [
              AppText.textSpan(
                definition,
                font: "Roboto",
                sizefont: 18,
                ftweight: FontWeight.w500,
                ftcolor: defColor,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 8),
              Container(
                width: 2.5, // Width of the line
                color: redColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: AppText.text(
                    example,
                    font: "Roboto",
                    sizefont: 15,
                    ftweight: FontWeight.w400,
                    ftcolor: exmplColor,
                    selectable: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Define platform-specific padding
    EdgeInsets platformPadding = (platform.Platform.isLinux ||
            platform.Platform.isMacOS ||
            platform.Platform.isWindows)
        ? const EdgeInsets.all(30.0)
        : const EdgeInsets.only(top: 50.0, right: 15, left: 15);

    // Dictionary data
    final Map<String, List<String>> dictionary = {
      "definitions": [
        "a usually undesirable or unpleasant choice",
        "a problem involving a difficult choice"
      ],
      "examples": [
        "faces this dilemma: raise interest rates and slow the economy or lower them and risk serious inflation",
        "the dilemma of \"liberty versus order\"\n— J. M. Burns"
      ]
    };

    return Scaffold(
      appBar: _checkPlatform(),
      body: Center(
        child: Padding(
          padding: platformPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _wordData(context),
              const SizedBox(height: 20),
              for (int i = 0; i < dictionary['definitions']!.length; i++)
                _wordDefine(
                  context,
                  dictionary['definitions']![i],
                  dictionary['examples']![i],
                  i + 1,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
