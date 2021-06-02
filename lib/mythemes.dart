import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {
  static final dark = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade800,
      primarySwatch: Colors.yellow,
      buttonColor: Color(0xffFBDB6C),
      accentColor: Colors.grey.shade900,
      colorScheme: ColorScheme.dark(),
      primaryColor: Colors.black,
      iconTheme: IconThemeData(color:Colors.white),
      tabBarTheme: TabBarTheme(unselectedLabelColor: Colors.white));
  static final light = ThemeData(
      primarySwatch: Colors.yellow,
      buttonColor: Color(0xffFBDB6C),
      scaffoldBackgroundColor: Colors.grey[100],
      accentColor: Colors.white,
      primaryColor: Colors.white,
      iconTheme: IconThemeData(color:Colors.black),
      colorScheme: ColorScheme.light(),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.black38,
      ));
}

class ChangeThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
        activeColor: Colors.black,
        value: themeprovider.isDarMode,
        onChanged: (value) {
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          provider.toggleTheme(value);
        });
  }
}
