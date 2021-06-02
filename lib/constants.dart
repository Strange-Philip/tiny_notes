import 'package:flutter/material.dart';
const grey = Color(0xFFEAEAEA);
const grey2 = Color(0xFF6D6D6D);
const black = Color(0xFF1C1C1C);
const black2 = Color(0xFF424242);
const headerColor = Color(0xFFFD5872);
const white = Colors.white;


enum EditMode {
  ADD,
  UPDATE,
}


var shadow = [
  BoxShadow(
    color: Colors.grey[300],
    blurRadius: 30,
    offset: Offset(0, 10),
  )
];