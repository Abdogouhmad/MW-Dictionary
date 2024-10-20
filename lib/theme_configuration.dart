import 'package:flutter/material.dart';
import './colorpalette.dart';

// theme configuration
var light = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: lightBackgroundColor,
    brightness: Brightness.light,
  ).copyWith(
    surface: lightBackgroundColor,
    onPrimary: Colors.white,
  ),
  scaffoldBackgroundColor: lightBackgroundColor,
  brightness: Brightness.light,
  useMaterial3: true,
);
var dark = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: darkBackgroundColor,
    brightness: Brightness.dark,
  ).copyWith(
    surface: lightBackgroundColor,
    onPrimary: Colors.white,
  ),
  scaffoldBackgroundColor: darkBackgroundColor,
  brightness: Brightness.dark,
  useMaterial3: true,
);
