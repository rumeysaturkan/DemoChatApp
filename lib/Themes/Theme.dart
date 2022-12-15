import 'package:flutter/material.dart';
import 'package:chat_app/Themes/constants.dart';

class Themes {
  ThemeData darkTheme = ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedLabelStyle: TextStyle(
            color: purple,
            fontSize: 14,
          ),
          unselectedLabelStyle: TextStyle(color: Colors.white, fontSize: 14),
          backgroundColor: darkBackground,
          selectedItemColor: purple,
          unselectedItemColor: Colors.white),
      backgroundColor: darkBackground,
      fontFamily: "Montserrat",
      cardColor: darkGray,
      primaryColor: Colors.white,
      primaryIconTheme: IconThemeData(color: Colors.white, size: 28));

  ThemeData lightTheme = ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedLabelStyle: TextStyle(color: purple, fontSize: 14),
          unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 14),
          backgroundColor: lightGray,
          selectedItemColor: purple,
          unselectedItemColor: Colors.black),
      primaryColor: Colors.black,
      fontFamily: "Montserrat",
      backgroundColor: lightGray,
      cardColor: Colors.white,
      primaryIconTheme: IconThemeData(color: Colors.black, size: 28));
}
