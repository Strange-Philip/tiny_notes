import 'dart:io';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'models/noteprovider.dart';

class NoteCard extends StatefulWidget {
  final int? id;
  final String? title;
  final String? content;
  final String? imagePath;
  final Color? color;
  final int? isAchived;
  final String? date;

  const NoteCard(
      {Key? key,
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('noteView', arguments: widget.id);
        },
        child: Container(
          height: widget.imagePath == null ? 150 : 230,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.color,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (widget.imagePath != null)
              Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          image: DecorationImage(
                              image: FileImage(File(widget.imagePath!)),
                              fit: BoxFit.cover)),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: 220,
                    child: Text(widget.title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Quicksand',
                            color: Colors.black,
                            fontSize: 20)),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(
                        LineIcons.trash,
                        size: 27,
                        color: Colors.black
                      ),
                      onPressed: () async {
                        await Provider.of<NoteProvider>(context, listen: false)
                            .deleteNote(widget.id);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          elevation: 0,
                          content: const Text('Note Deleted'),
                          duration: const Duration(seconds: 2),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        ));
                      })
                ],
              ),
            ),
            // SizedBox(height: 2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(
                  LineIcons.clock,
                  size: 20,
                  color: Colors.black54
                  
                ),
                SizedBox(
                  width: 4,
                ),
                  Text(widget.date!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Quicksand',
                          color: Colors.black54,
                          fontSize: 14)),
                ],
              ),
            ),
            SizedBox(height:widget.imagePath == null ? 4:2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height:widget.imagePath == null ?  70 :40,
                child: Text(widget.content!,
                    maxLines: widget.imagePath == null ?  3 :1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Quicksand',
                        color: Colors.black54,
                        fontSize: 16)),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
