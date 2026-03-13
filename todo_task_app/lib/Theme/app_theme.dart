import 'package:flutter/material.dart';

class AppTheme {
  ThemeData get lightTheme => ThemeData(
    appBarTheme: AppBarThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.deepPurple.shade900,
    ),
    cardColor: Colors.white,
    cardTheme: CardThemeData(color: Colors.white),
    dividerColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.deepPurple,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        fixedSize: WidgetStatePropertyAll(Size(500, 40)),
        backgroundColor: WidgetStatePropertyAll(Colors.deepPurple),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: .circular(20)),
        ),
      ),
    ),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
    iconTheme: IconThemeData(color: Colors.black),
  );
  ThemeData get darkTheme => ThemeData(
    cardTheme: CardThemeData(color: Colors.grey.shade800),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.white),
        foregroundColor: WidgetStatePropertyAll(Colors.deepPurple.shade900),
      ),
    ),
    dividerColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.black,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: Colors.white,
      textColor: Colors.white,
    ),
    cardColor: Colors.grey.shade900,
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
    iconTheme: IconThemeData(color: Colors.white),
  );
}
