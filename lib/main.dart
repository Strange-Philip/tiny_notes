import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiny_notes/models/noteprovider.dart';
import 'homepage.dart';
import 'noteview.dart';
import 'onboarding.dart';

int intScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefences = await SharedPreferences.getInstance();
  // ignore: await_only_futures
  intScreen = await prefences.getInt('intScreen');
  await prefences.setInt('intScreen', 1);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: NoteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          buttonColor: Color(0xffFBDB6C),
          scaffoldBackgroundColor: Colors.grey[100],
        ),
        initialRoute: intScreen == 0 || intScreen == null ? 'onBoard' : 'home',
        routes: {
          'home': (context) => Home(),
          'onBoard': (context) => Onboard(),
          'homepage': (context) => HomePage(),
          'noteView': (context) => NoteView(),
        },
      ),
    );
  }
}
