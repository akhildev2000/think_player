import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isLightMode => themeMode == ThemeMode.dark;
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: const Color.fromARGB(255, 3, 31, 71),
      primaryColor: const Color.fromARGB(255, 3, 31, 71),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 3, 31, 71),
      ),
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.white,
        textColor: Color.fromARGB(255, 3, 31, 71),
        iconColor: Color.fromARGB(255, 3, 31, 71),
      )
      //colorScheme: ColorScheme.dark(),
      );
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Color.fromARGB(255, 3, 31, 71),
      ),
      appBarTheme: const AppBarTheme(
          foregroundColor: Color.fromARGB(255, 3, 31, 71),
          backgroundColor: Colors.white),
      listTileTheme: const ListTileThemeData(
          tileColor: Color.fromARGB(255, 3, 31, 71),
          textColor: Colors.white,
          iconColor: Colors.white)
      //colorScheme: ColorScheme.light(),
      );
}
