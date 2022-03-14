import 'package:flutter/material.dart';

class ThemProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode => themeMode == ThemeMode.light;

  void toggleThem(bool isOne) {
    themeMode = isOne ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class Mytheme {
  static final darkthem = ThemeData(
      scaffoldBackgroundColor: const Color(0xff3450A1),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xff3450A1)),
      primaryColor: Colors.white,
      cardColor: const Color(0xff0A155A),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFF00FF)));

  static final lightthem = ThemeData(
    scaffoldBackgroundColor: const Color(0xffF4F6FD),
    primaryColor: Colors.black,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF002FFF)),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xffF4F6FD)),
  );
}
