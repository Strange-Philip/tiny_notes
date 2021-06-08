import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool isDarker = false;

  toggleTheme(bool value) {
    isDarker = value;

    return {
      isDarker == true
          ? themeMode = ThemeMode.dark
          : themeMode = ThemeMode.light,
      notifyListeners(),
      print(themeMode),
      notifyListeners()
    };
  }

  notifyListeners();
}

class MyTheme {
  static final dark = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade800,
      primarySwatch: Colors.yellow,
      buttonColor: Color(0xffFBDB6C),
      accentColor: Colors.grey.shade900,
      colorScheme: ColorScheme.dark(),
      
      toggleableActiveColor: Color(0xffFBDB6C),
      primaryColor: Colors.black,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xffFBDB6C),
          elevation: 0,
          foregroundColor: Colors.black),
      iconTheme: IconThemeData(color: Colors.white),
      tabBarTheme: TabBarTheme(unselectedLabelColor: Colors.white));
  static final light = ThemeData(
      primarySwatch: Colors.yellow,
      buttonColor: Color(0xffFBDB6C),
      scaffoldBackgroundColor: Colors.grey[100],
      accentColor: Colors.white,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xffFBDB6C),
          elevation: 0,
          foregroundColor: Colors.white),
      toggleableActiveColor: Color(0xffFBDB6C),
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
          EasyDynamicTheme.of(context).changeTheme();
          // final provider = Provider.of<ThemeProvider>(context, listen: false);
          print(value);
          setState(() {
            print('cheking');

            // themeprovider.toggleTheme( value);
          });
        });
  }
}
