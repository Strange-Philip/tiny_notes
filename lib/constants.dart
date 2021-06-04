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

// / Construct a color from a hex code string, of the format #RRGGBB.
Color hexToColor(String code) {
  return new Color(int.parse(code.substring(2), radix: 16) + 0xFF000000);
}
// Color hexToColor(String code) {
//   return new Color(int.parse(code));
// }


const kColorPickerBorderColor = Color(0x21000000);
const Iterable<Color> kNoteColors = [
  Colors.white,
  Colors.redAccent,
  Colors.yellow,
  Colors.limeAccent,
  Colors.orangeAccent,
  Colors.greenAccent,
  Colors.lightGreenAccent,
  Colors.tealAccent,
  Colors.lightBlueAccent,
  Colors.blueAccent,
  Colors.pinkAccent,
  Colors.purpleAccent,
];
final kDefaultNoteColor = kNoteColors.first;

// // ignore: must_be_immutable
// class LinearColorPicker extends StatefulWidget {
//   @override
//   _LinearColorPickerState createState() => _LinearColorPickerState();
// }

// class _LinearColorPickerState extends State<LinearColorPicker> {
//   /// Returns color of the note, fallbacks to the default color.
//   Color _currColor = kDefaultNoteColor;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: kNoteColors.
//             .flatMapIndexed((i, color) => [
//                   if (i == 0) const SizedBox(width: 17),
//                   InkWell(
//                     child: Container(
//                       width: 36,
//                       height: 36,
//                       decoration: BoxDecoration(
//                         color: color,
//                         shape: BoxShape.circle,
//                         border: Border.all(color: kColorPickerBorderColor),
//                       ),
//                       child: color == _currColor
//                           ? const Icon(Icons.check,
//                               color: kColorPickerBorderColor)
//                           : null,
//                     ),
//                     onTap: () {
//                       if (color != _currColor) {
//                         setState(() {
//                           color = _currColor;
//                         });
//                       }
//                     },
//                   ),
//                   SizedBox(width: i == kNoteColors.length - 1 ? 17 : 20),
//                 ])
//             .asList(),
//       ),
//     );
//   }
// }
