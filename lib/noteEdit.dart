import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'models/noteprovider.dart';

class NoteEditScreen extends StatefulWidget {
  @override
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  File _image;
  final picker = ImagePicker();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(LineIcons.times),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
              icon: Icon(LineIcons.image),
              onPressed: () {
                getImage(ImageSource.gallery);
              }),
          IconButton(
              icon: Icon(LineIcons.camera),
              onPressed: () {
                getImage(ImageSource.camera);
              }),
          IconButton(
              icon: Icon(LineIcons.trash),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          if (titleController.text.isEmpty) {
            titleController.text = "Untitled Note";
            saveNote();
          }
        },
        backgroundColor: Color(0xffFBDB6C),
        child: Icon(
          LineIcons.save,
          size: 25,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: TextField(
              controller: titleController,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                  fontFamily: 'Quicksand'),
              decoration: InputDecoration(
                  hintText: "Enter Note Title", border: InputBorder.none),
            ),
          ),
          if (_image != null)
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
                            image: FileImage(_image), fit: BoxFit.cover)),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffFBDB6C),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _image = null;
                            });
                          },
                          child: Icon(
                            LineIcons.trash,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: TextField(
              controller: contentController,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black45,
                  fontFamily: 'Quicksand'),
              decoration: InputDecoration(
                  hintText: "Enter Something...", border: InputBorder.none),
            ),
          ),
        ],
      )),
    ));
  }

  getImage(ImageSource imageSource) async {
    PickedFile imageFile = await picker.getImage(source: imageSource);
    if (imageFile = null) return;
    File tempFile = File(imageFile.path);
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);

    tempFile = await tempFile.copy('${appDir.path}/$fileName');
    setState(() {
      _image = tempFile;
    });
  }

  void saveNote() {
    String title = titleController.text.trim();
    String content = contentController.text.trim();

    String imagePath = _image != null ? _image.path : null;

    int id = DateTime.now().microsecondsSinceEpoch;

    bool isAchived = false;

    Color color = Colors.white;

    Provider.of<NoteProvider>(this.context, listen: false).addOrUpdateNote(
        id, title, content, imagePath, color, isAchived, EditMode.ADD);
    Navigator.of(this.context).pushReplacementNamed(
             ('/homepage'),arguments:id);
  }
}
