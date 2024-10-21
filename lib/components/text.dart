import 'package:flutter/material.dart';

/// A customizable text widget that allows the display of styled text
/// with optional parameters for font family, font size, font weight, and color.
///
/// You can use the widget like this:
///
/// ```dart
/// AppText.text("Hello", font: "Roboto", sizefont: 20, ftweight: FontWeight.bold, ftcolor: Colors.blue);
/// ```
///
/// If you don't provide any parameters, default styles are applied:
///
/// ```dart
/// AppText.text("Hello");
/// ```
class AppText extends StatelessWidget {
  /// The text to be displayed.
  final String text;

  /// The style of the text, which combines the provided or default values.
  final TextStyle style;

  /// Private constructor used by the factory method to initialize the widget.
  const AppText._({
    required this.text,
    required this.style,
  });

  /// Factory method to create a text widget with optional style parameters.
  ///
  /// [text] is the main string content to be displayed.
  /// [font] allows customization of the font family. Defaults to "Roboto".
  /// [sizefont] is the font size. Defaults to 16.0.
  /// [ftweight] is the font weight. Defaults to `FontWeight.normal`.
  /// [ftcolor] is the text color. Defaults to `Colors.black`.
  factory AppText.text(
    String text, {
    String font = "Roboto",
    double sizefont = 16.0,
    FontWeight ftweight = FontWeight.normal,
    Color ftcolor = Colors.black,
  }) {
    return AppText._(
      text: text,
      style: TextStyle(
        fontFamily: font,
        fontSize: sizefont,
        fontWeight: ftweight,
        color: ftcolor,
      ),
    );
  }

  /// Method to create a [TextSpan] with optional style parameters.
  ///
  /// [text] is the main string content to be displayed.
  /// [font] allows customization of the font family. Defaults to "Roboto".
  /// [sizefont] is the font size. Defaults to 16.0.
  /// [ftweight] is the font weight. Defaults to `FontWeight.normal`.
  /// [ftcolor] is the text color. Defaults to `Colors.black`.
  static TextSpan textSpan(
    String text, {
    String font = "Roboto",
    double sizefont = 16.0,
    FontWeight ftweight = FontWeight.normal,
    Color ftcolor = Colors.black,
  }) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontFamily: font,
        fontSize: sizefont,
        fontWeight: ftweight,
        color: ftcolor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
