import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Post {
  final String uid;
  final String postId;
  final String post;
  final Timestamp publishDate;
  final String imageUrl;
  final String location;
  final int likesCount;
  List<dynamic> postLikers;

  Post(
      {@required this.uid,
      this.postId,
      @required this.post,
      @required this.publishDate,
      this.imageUrl,
      this.location,
      @required this.likesCount});

  factory Post.fromDocument(DocumentSnapshot doc){
    return Post(uid: doc['User'], post: doc['post'], publishDate: doc['publishDate'], likesCount: doc['postLikesCount'],imageUrl: doc['postImageUrl'],postId: doc.id,location: doc['postLocation'] );
  }


}
