import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeModeManager extends ChangeNotifier {

  late ThemeData lightTheme;
  late ThemeData darkTheme;
  late ThemeMode themeMode;
  ThemeModeManager() {
    //?for default theme
    //* ThemeMode.system => system theme
    //* ThemeMode.light => light theme
    //* ThemeMode.dark => dark theme
    themeMode = ThemeMode.light;
    //*For light theme default settings
    lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.brown[200],
      accentColor: Colors.white70,
      backgroundColor: Colors.brown[50],
      buttonColor: Colors.brown,
      shadowColor: Colors.brown[200],
      textSelectionColor: Colors.brown[900],
      cardColor: Colors.brown[400],
    );
    //*For dark theme default settings
    darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.brown[900],
      accentColor: Colors.white10,
      backgroundColor: Colors.brown[600],
      buttonColor: Colors.amber[50],
      shadowColor: Colors.brown[900],
      textSelectionColor: Colors.brown[100],
      cardColor: Colors.brown[300],
    );
  }

  void changeTheme() {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
  
}
