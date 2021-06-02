import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Note{
  int _id;
  String _title;
  String _content;
  String _imagePath;
  Color _color;
  bool _isAchived;


  Note(this._id,this._title,this._content,this._imagePath,this._color,this._isAchived);

  int get id => _id;
  String get title => _title;
  String get content => _content;
  String get imagePath => _imagePath;
  Color get color => _color;
  bool get isAchived => _isAchived;

String get date {
  final date = DateTime.fromMicrosecondsSinceEpoch(id);
  return DateFormat('EEE h:mm a, dd/MM/yyy').format(date);
}

}