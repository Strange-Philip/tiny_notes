import 'dart:io';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:tiny_notes/models/noteprovider.dart';

import 'constants.dart';
import 'models/notes.dart';

class NoteView extends StatefulWidget {
  static const route = 'noteView';
  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  Note? selectedNote;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final id = ModalRoute.of(context)!.settings.arguments;
    final provider = Provider.of<NoteProvider>(context);

    if (provider.getNote(id as int?) != null) {
      selectedNote = provider.getNote(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = hexToColor(selectedNote!.color!);
    return SafeArea(
        child: Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(LineIcons.times,color: Colors.black,),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
              icon: Icon(LineIcons.trash,color: Colors.black),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        // title: Text('Error'),
                        content: Text(
                          "Sure you want to delete note?",
                          style: TextStyle(
                              // color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Quicksand'),
                        ),
                        actions: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              child: Text(
                                'No',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Quicksand'),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: SizedBox(
                              width: 100.0,
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xffFBDB6C)),
                                ),
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                      color: Colors.white,
                                       fontWeight: FontWeight.w600,
                                      fontSize: 14.0,
                                      fontFamily: 'Quicksand'),
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await Provider.of<NoteProvider>(context,
                                          listen: false)
                                      .deleteNote(selectedNote!.id);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    elevation: 0,
                                    content: const Text('Note Deleted'),
                                    duration: const Duration(seconds: 2),
                                    backgroundColor: Colors.green,
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          Navigator.of(this.context)
              .pushNamed('noteEdit', arguments: selectedNote!.id);
        },
        backgroundColor: Color(0xffFBDB6C),
        child: Icon(
          LineIcons.edit,
          size: 25,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                selectedNote!.title!,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'Quicksand'),
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  LineIcons.clock,
                  color: Colors.black54,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  selectedNote!.date,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                      fontFamily: 'Quicksand'),
                ),
              ],
            ),
          ),
          if (selectedNote!.imagePath != null)
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: FileImage(File(selectedNote!.imagePath!)),
                            fit: BoxFit.cover)),
                  ),
                ],
              ),
            ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                selectedNote!.content!,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                    fontFamily: 'Quicksand'),
              )),
        ],
      )),
    ));
  }
}
