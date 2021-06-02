import 'package:flutter/material.dart';
import 'package:tiny_notes/models/databasehelper.dart';
import 'package:tiny_notes/models/notes.dart';

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
}
