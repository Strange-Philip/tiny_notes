import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tiny_notes/homepage.dart';

class Onboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          AnimatedSplash(
            imagePath: 'images/iconbg.png',
            home: OnboardingHome(),
            duration: 2500,
            type: AnimatedSplashType.StaticDuration,
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.8),
                Center(
                  child: Text("Take notes anywhere,anytime.",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Quicksand',
                          color: Colors.black,
                          fontSize: 20)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OnboardingHome extends StatefulWidget {
  @override
  _OnboardingHomeState createState() => _OnboardingHomeState();
}

class _OnboardingHomeState extends State<OnboardingHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: IntroductionScreen(
      showNextButton: true,
      pages: [
        PageViewModel(
            title: "Add Notes",
            image: SvgPicture.asset(
              "images/add_notes.svg",
            ),
            body: "Tiny Notes allow users to easily add notes no matter how small they are. Best part is you dont need internet connection for this.",
            decoration: PageDecoration(
                pageColor: Colors.white,
                imagePadding: EdgeInsets.all(50),
                titleTextStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600),
                bodyTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Quicksand',
                ))),
        PageViewModel(
            title: "Add Photos to Notes",
            image: SvgPicture.asset(
              "images/add_photo.svg",
            ),
            body:
                "We at Tiny Notes believe that some notes are better if you add your cool and exciting photos. Feel free to snap photos or just fetch from your gallery.",
            decoration: PageDecoration(
                pageColor: Colors.white,
                imagePadding: EdgeInsets.all(50),
                titleTextStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600),
                bodyTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Quicksand',
                ))),
        PageViewModel(
            title: "Simple U.I Design",
            image: SvgPicture.asset(
              "images/work_from_anywhere.svg",
            ),
            body:
                "Our simple but cool interface makes it easy to view and add notes. Enjoy.",
            decoration: PageDecoration(
                pageColor: Colors.white,
                imagePadding: EdgeInsets.all(50),
                titleTextStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600),
                bodyTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Quicksand',
                ))),
        PageViewModel(
            title: "Dark and Light Modes",
            image: SvgPicture.asset(
              "images/dark_mode.svg",
            ),
            body:
                "Try our exciting dark mode theme. Remember to share with your friends too.",
            decoration: PageDecoration(
                pageColor: Colors.white,
                imagePadding: EdgeInsets.all(50),
                titleTextStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600),
                bodyTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Quicksand',
                ))),
      ],
      onDone: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomePage()));
      },
      done: Text(
        "Done",
        style: TextStyle(
          color: Colors.yellow,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Quicksand',
        ),
      ),
      showSkipButton: true,
      skip: Text(
        "Skip",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          fontFamily: 'Quicksand',
        ),
      ),
      dotsDecorator: DotsDecorator(
        activeColor: Color(0xffFBDB6C),
      ),
    ));
  }
}
