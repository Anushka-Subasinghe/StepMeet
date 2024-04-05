import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final String comment;
  final VoidCallback onDelete;

  const CommentWidget({Key? key, required this.comment, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffd6a4e5).withOpacity(.6),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top:10.0),
                child: Text(
                  comment,
                    style: const TextStyle(
                        color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18)
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Delete Comment"),
                    content: Text("Are you sure you want to delete this comment?"),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      TextButton(
                        child: Text('Delete'),
                        onPressed: () {
                          onDelete();
                          Navigator.of(context).pop(); // Close the dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Comment Deleted"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class CommentWidgetState {
  static List<String> comments = [];

  static void removeComment(String comment) {
    comments.remove(comment);
  }
}
