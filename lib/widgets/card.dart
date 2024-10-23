import 'package:flutter/material.dart';
import 'package:mwd/colorpalette.dart';
import 'package:mwd/components/text.dart';
import 'package:mwd/services/wordofday.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  late String wordOfTheDay = "";
  late String partOfSpch = "";
  late String phonetics = "";
  late String definition = ""; // NOTE: possible a list of strings
  late String example = ""; // NOTE: possible a list of strings

  @override
  void initState() {
    super.initState();
    _fetchWordOfTheDay();
  }

  Future<void> _fetchWordOfTheDay() async {
    try {
      RandomWord wordGenerator = RandomWord();
      String word = await wordGenerator.getRandomWord();
      setState(() {
        wordOfTheDay = word;
      });
      debugPrint('Fetched word: $wordOfTheDay');
    } catch (e) {
      debugPrint('Error fetching word: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final wordTextColor = isDarkMode ? primaryTextDark : primaryTextLight;
    final partOfSpchAndDef =
        isDarkMode ? secondaryTextDark : secondaryTextLight;
    final borderColor = isDarkMode ? borderColorDark : borderColorDark;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: borderColor, width: 1.5)),
        color: isDarkMode ? darkCardBg : lightCardBg,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.text(
                "the word of the day".toUpperCase(),
                font: "Roboto",
                sizefont: 16,
                ftweight: FontWeight.w600,
                ftcolor: wordTextColor,
              ),
              const SizedBox(height: 10),
              // Word of the day
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 20,
                    color: wordTextColor,
                  ),
                  children: [
                    AppText.textSpan(
                      wordOfTheDay, // Display the fetched word
                      font: "PlayfairDisplay",
                      sizefont: 20,
                      ftweight: FontWeight.w600,
                      ftcolor: wordTextColor,
                    ),
                    AppText.textSpan(
                      " · noun",
                      font: "PlayfairDisplay",
                      sizefont: 18,
                      ftweight: FontWeight.w500,
                      ftcolor: partOfSpchAndDef,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              // Pronunciation
              AppText.text(
                "/zɛst/",
                font: "Roboto",
                sizefont: 16,
                ftweight: FontWeight.w600,
                ftcolor: partOfSpchAndDef,
              ),
              const SizedBox(height: 10),
              // Definitions with examples in list format
              _buildDefinitionWithExample(
                  "a piece of the peel of a citrus fruit (such as an orange or lemon) used as flavoring",
                  "",
                  isDarkMode,
                  partOfSpchAndDef),
              // const SizedBox(height: 10),
              _buildDefinitionWithExample("an enjoyably exciting quality",
                  "adds zest to the performance", isDarkMode, partOfSpchAndDef),
              const SizedBox(height: 10),
              _buildDefinitionWithExample("keen enjoyment",
                  "has a zest for living", isDarkMode, partOfSpchAndDef),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefinitionWithExample(
      String definition, String? example, bool isDarkMode, Color cuColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Definition
        AppText.text(
          definition,
          sizefont: 16,
          ftweight: FontWeight.w500,
          ftcolor: cuColor,
        ),
        // const SizedBox(height: 5),
        // Example
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: AppText.text(
            example ?? '',
            sizefont: 16,
            ftweight: FontWeight.w400,
            ftcolor: yellowColor,
          ),
        ),
      ],
    );
  }
}
