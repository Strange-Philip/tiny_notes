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
              imagePath: 'images/icon.jpg',
              home: OnboardingHome(),
              duration: 2500,
              type: AnimatedSplashType.StaticDuration,
            ),
            Center(
              child: Text("Take litte notes anywhere,anytime.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Quicksand',
                    color: Colors.black,
                    fontSize: 16
                  )),
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
          showDoneButton: true,
      pages: [
        PageViewModel(
            title: "Add Notes",
            image: SvgPicture.asset(
              "images/add_notes.svg",
             
            ),
            body:
                "Consectetur voluptate id exercitation qui cillum commodo veniam nisi enim ad dolore veniam dolor aliqua.",
            decoration: PageDecoration(
                pageColor: Colors.white,
                imagePadding: EdgeInsets.all(50),
                titleTextStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w500),
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
                "Consectetur voluptate id exercitation qui cillum commodo veniam nisi enim ad dolore veniam dolor aliqua.",
            decoration: PageDecoration(
                pageColor: Colors.white,
                imagePadding: EdgeInsets.all(50),
                titleTextStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w500),
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
                "Consectetur voluptate id exercitation qui cillum commodo veniam nisi enim ad dolore veniam dolor aliqua.",
            decoration: PageDecoration(
                pageColor: Colors.white,
                imagePadding: EdgeInsets.all(50),
                titleTextStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w500),
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
                "Consectetur voluptate id exercitation qui cillum commodo veniam nisi enim ad dolore veniam dolor aliqua.",
            decoration: PageDecoration(
                pageColor: Colors.white,
                imagePadding: EdgeInsets.all(50),
                titleTextStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w500),
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
          fontWeight: FontWeight.w400,
          fontFamily: 'Quicksand',
        ),
      ),
      showSkipButton: true,
      skip: Text(
        "Skip",
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: 'Quicksand',
        ),
      ),
      dotsDecorator: DotsDecorator(
        activeColor: Color(0xffFBDB6C),
      ),
    ));
  }
}
