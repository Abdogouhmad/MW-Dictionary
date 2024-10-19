import 'package:flutter/material.dart';
import './colorpalette.dart';

// theme configuration
var light = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: appBackgroundColor,
    brightness: Brightness.light,
  ).copyWith(
    surface: lightBackgroundColor,
    onPrimary: Colors.white,
  ),
  scaffoldBackgroundColor: appBackgroundColor,
  brightness: Brightness.light,
  useMaterial3: true,
);
var dark = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: darkAppBackgroundColor,
    brightness: Brightness.dark,
  ).copyWith(
    surface: lightBackgroundColor,
    onPrimary: Colors.white,
  ),
  scaffoldBackgroundColor: darkAppBackgroundColor,
  brightness: Brightness.dark,
  useMaterial3: true,
);
