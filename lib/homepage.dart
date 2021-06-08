import 'package:animated_splash/animated_splash.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cards.dart';
import 'constants.dart';
import 'models/noteprovider.dart';
import 'mythemes.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          AnimatedSplash(
            imagePath: 'images/iconbg.png',
            home: HomePage(),
            duration: 3000,
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
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

void customLaunch(command) async {
  if (await canLaunch(command)) {
    await launch(command);
  } else {
    print('could not launch $command');
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<NoteProvider>(context, listen: false).getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: Provider.of<NoteProvider>(context, listen: false).getNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SafeArea(
              child: Scaffold(
                body: Center(
                  child: SpinKitFoldingCube(
                    size: 30,
                    color: Color(0xffFBDB6C),
                  ),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return SafeArea(
                child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                title: Text(
                  "TinyNotes",
                  maxLines: 5,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      // color: Colors.black,
                      fontFamily: 'Quicksand'),
                ),
                backgroundColor: Colors.transparent,
                actions: [
                  // ChangeThemeButton(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      onTap: () {
                        showBtnsheet(context);
                      },
                      child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage("images/male_avatar_.png")),
                    ),
                  )
                ],
              ),
              body: Consumer<NoteProvider>(
                builder: (context, noteprovider, child) =>
                    noteprovider.items.length <= 0
                        ? child
                        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: noteprovider.items.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Container(
                                    // child: Column(
                                    //   children: [
                                    //     Spacer(),
                                    //     SvgPicture.asset(
                                    //       'images/Add_files.svg',
                                    //       width: 200,
                                    //       height: 150,
                                    //       fit: BoxFit.cover,
                                    //     ),
                                    //     SizedBox(
                                    //       height: 20,
                                    //     ),
                                    //     Padding(
                                    //       padding: const EdgeInsets.symmetric(
                                    //           horizontal: 15, vertical: 5),
                                    //       child: Text(
                                    //         "No Notes Yet \nTap on the Plus Icon to add notes",
                                    //         maxLines: 5,
                                    //         style: TextStyle(
                                    //             fontSize: 20,
                                    //             fontWeight: FontWeight.w400,
                                    //             color: Colors.black,
                                    //             fontFamily: 'Quicksand'),
                                    //       ),
                                    //     ),
                                    //     Spacer(),
                                    //   ],
                                    // ),
                                    );
                              } else {
                                // SizedBox(height: 30,);
                                final i = index - 1;
                                final item = noteprovider.items[i];
                                return NoteCard(
                                  id: item.id,
                                  title: item.title,
                                  content: item.content,
                                  imagePath: item.imagePath,
                                  color: hexToColor(item.color),
                                  isAchived: item.isAchived,
                                  date: item.date,
                                );
                              }
                            }),
                child: Center(
                  child: Column(
                    children: [
                      Spacer(),
                      SvgPicture.asset(
                        'images/Add_files.svg',
                        width: 200,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Text(
                          "No Notes Yet \nTap on the Plus Icon to add notes",
                          maxLines: 5,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              // color: Colors.black,
                              fontFamily: 'Quicksand'),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                
                elevation: 0,
                onPressed: () {
                  Navigator.of(context).pushNamed('noteEdit');
                },
                // backgroundColor: Color(0xffFBDB6C),
                child: Icon(
                  LineIcons.plus,
                  size: 25,
                  // color: Colors.white,
                ),
              ),
            ));
          }
          return Container();
        });
  }

  void showBtnsheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setBtnState) {
            return new Container(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height - 455,
                    left: 13,
                    right: 13),
                child: Container(
                  height: 455,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: IconButton(
                                icon: Icon(LineIcons.times),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Settings",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                // color: Colors.black,
                                fontFamily: 'Quicksand'),
                          ),
                        ),
                        Center(
                          child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage("images/male_avatar_.png")),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListTile(
                            title: Text(
                              'Add Note',
                              style: TextStyle(
                                  // color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Quicksand'),
                            ),
                            leading: Icon(
                              LineIcons.stickyNote,
                              // color: Colors.black,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).pushNamed('noteEdit');
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListTile(
                            title: Text(
                              'Theme',
                              style: TextStyle(
                                  // color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Quicksand'),
                            ),
                            leading: Icon(
                             EasyDynamicTheme.of(context).themeMode == ThemeMode.light? LineIcons.moon :LineIcons.sun,
                              // color: Colors.black,
                              
                            ),
                            // trailing: ChangeThemeButton(),
                            trailing:EasyDynamicThemeSwitch(),
                            onTap: () {
                              // Navigator.pop(context);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListTile(
                            title: Text(
                              'Contact Developer',
                              style: TextStyle(
                                  // color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Quicksand'),
                            ),
                            leading: Icon(
                              LineIcons.envelope,
                              // color: Colors.black,
                            ),
                            onTap: () {
                              customLaunch(
                                  'mailto:philipabakahmensah@gmail.com?subject=TinyNotes&body=');
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListTile(
                            title: Text(
                              'Help & feedback',
                              style: TextStyle(
                                  // color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Quicksand'),
                            ),
                            leading: Icon(
                              LineIcons.questionCircle,
                              // color: Colors.black,
                            ),
                            onTap: () {
                              customLaunch(
                                  'mailto:philipabakahmensah@gmail.com?subject=TinyNotes&body=');
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Center(
                          child: Text(
                                'Developed by • Philip',
                                style: TextStyle(
                                   fontFamily: 'Quicksand',
                                    fontSize: 14,))
                                  
                      
                        ),],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  check(val) {
    print(val);
  }
}
