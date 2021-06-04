import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool isDarker = false;

  toggleTheme() {
    return isDarker ? ThemeMode.dark : ThemeMode.light;
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
      iconTheme: IconThemeData(color: Colors.white),
      tabBarTheme: TabBarTheme(unselectedLabelColor: Colors.white));
  static final light = ThemeData(
      primarySwatch: Colors.yellow,
      buttonColor: Color(0xffFBDB6C),
      scaffoldBackgroundColor: Colors.grey[100],
      accentColor: Colors.white,
      primaryColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      colorScheme: ColorScheme.light(),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.black38,
      ));
}

class ChangeThemeButton extends StatefulWidget {
  @override
  _ChangeThemeButtonState createState() => _ChangeThemeButtonState();
}

class _ChangeThemeButtonState extends State<ChangeThemeButton> {
  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeProvider>(context, listen: true);
    return Switch.adaptive(
        activeColor: Colors.black,
        value: themeprovider.isDarker,
        onChanged: (value) {
          // final provider = Provider.of<ThemeProvider>(context, listen: false);
          print(value);
          setState(() {
            print('cheking');

            themeprovider.toggleTheme();
          });
        });
  }
}
