import 'package:flutter/material.dart';
import 'package:tiny_notes/models/databasehelper.dart';
import 'package:tiny_notes/models/notes.dart';

import '../constants.dart';

class NoteProvider with ChangeNotifier {
  List _items = [];

  List get items {
    return [..._items];
  }

  Future getNotes() async {
    final noteList = await DatabaseHelper.getNotedFromDb();

    _items = noteList
        .map((item) => Note(item['id'], item['title'], item['content'],
            item['imagePath'], item['color'], item['isAchived']))
        .toList();

    notifyListeners();
  }

  Future addOrUpdateNote(int id, String title, String content, String imagePath,
      Color color, bool isAchived, EditMode editMode) async {
       final note = Note(id,title,content,imagePath,color,isAchived);

       if(EditMode.ADD== editMode){
         _items.insert(0,note);
       }else{
         _items[_items.indexWhere((note)=> note.id == id)] = note;
       }
       notifyListeners();

       DatabaseHelper.insert({
         'id':note.id,
         'title': note.title,
         'content': note.content,
         'imagePath': note.imagePath,
         'color': note.color,
         'isAchived':note.isAchived
       });
      }
}
