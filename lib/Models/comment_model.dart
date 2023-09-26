import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Comment {
  final commentId;
  final commentText;
  final commenterId;

  Comment(
      {@required this.commentId,
      @required this.commentText,
      @required this.commenterId});

  factory Comment.fromDocument(DocumentSnapshot doc){
    return Comment(commentId: doc.id, commentText: doc['commentText'], commenterId: doc['commenterId']);
  }

}
