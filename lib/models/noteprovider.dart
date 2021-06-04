import 'package:flutter/material.dart';
import 'package:tiny_notes/models/databasehelper.dart';
import 'package:tiny_notes/models/notes.dart';

import '../constants.dart';

class NoteProvider with ChangeNotifier {
  List _items = [];

  List get items {
    return [..._items];
  }

  Note getNote(int id) {
    return _items.firstWhere((note) => note.id == id, orElse: () => null);
  }

  Future deleteNote(int id) async {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    return DatabaseHelper.delete(id);
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
      String color, int isAchived, EditMode editMode) async {
    final note = Note(id, title, content, imagePath, color, isAchived);

    if (EditMode.ADD == editMode) {
      _items.insert(0, note);
    } else {
      _items[_items.indexWhere((note) => note.id == id)] = note;
    }
    notifyListeners();

    DatabaseHelper.insert({
      'id': note.id,
      'title': note.title,
      'content': note.content,
      'imagePath': note.imagePath,
      'color': note.color,
      'isAchived': note.isAchived
    });
  }
}
