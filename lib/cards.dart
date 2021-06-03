import 'dart:io';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class NoteCard extends StatefulWidget {
  final int id;
  final String title;
  final String content;
  final String imagePath;
  final Color color;
  final bool isAchived;
  final String date;

  const NoteCard(
      {Key key,
      this.id,
      this.title,
      this.content,
      this.imagePath,
      this.color,
      this.isAchived,
      this.date})
      : super(key: key);

  @override
  _NoteCardState createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:12,vertical:8),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushReplacementNamed('noteView', arguments: widget.id);
        },
        child: Container(
          height: widget.imagePath == null ? 150 : 230,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.color.withOpacity(0.5),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (widget.imagePath != null)
              Container(
                // padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          image: DecorationImage(
                              image: FileImage(File(widget.imagePath)),
                              fit: BoxFit.cover)),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Quicksand',
                          color: Colors.black,
                          fontSize: 20)),
                  Spacer(),
                  IconButton(
                      icon: Icon(LineIcons.bookmark,
                      size: 30,
                          color: widget.isAchived == false
                              ? Colors.black54
                              : Colors.black),
                      onPressed: () {
                        setState(() {
                          widget.isAchived == true;
                        });
                      })
                ],
              ),
            ),
            SizedBox(height: 4),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(widget.date,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Quicksand',
                      color: Colors.black26,
                      fontSize: 16)),
            ),
            SizedBox(height: 4),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Expanded(
                child: Text(widget.content,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Quicksand',
                        color: Colors.black38,
                        fontSize: 16)),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
