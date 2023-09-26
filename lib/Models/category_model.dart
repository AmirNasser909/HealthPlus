import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Category {
  final String categoryId;
  final String categoryName;
  final String categoryImageLink;
  final String categoryBio;

  Category({ this.categoryId,
    @required this.categoryName,
    @required this.categoryImageLink,
    @required this.categoryBio});

  factory Category.fromDocument(DocumentSnapshot doc){
    return Category(
        categoryId: doc.id,
        categoryName: doc['categoryName'],
        categoryImageLink: doc['categoryImageLink'],
        categoryBio: doc['categoryBio']);
  }
}
