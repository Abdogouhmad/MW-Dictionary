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
var dark = ThemeData();
