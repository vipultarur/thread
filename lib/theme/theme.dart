import 'package:flutter/material.dart';

final ThemeData theme=ThemeData(

  iconTheme: IconThemeData(
    color: Colors.white, // Default icon color
    size: 24, // Default icon size
  ),
  navigationBarTheme: NavigationBarThemeData(
    labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    indicatorColor:Colors.white24 ,
    backgroundColor: Colors.black,
    iconTheme: MaterialStateProperty.all<IconThemeData>(
      IconThemeData(
        color: Colors.white, // Icon color for the navigation bar
        size: 28, // Icon size for the navigation bar
      ),
    ),
  ),
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0.0,
    surfaceTintColor: Colors.black
  ),
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: Colors.white,
      onPrimary: Colors.black,
      onSurface: Colors.white

      ),


);
