import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final String comment;

  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        comment,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black87,
        ),
      ),
    );
  }
}
