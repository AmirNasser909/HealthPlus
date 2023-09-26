import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class userInfo {
  final String userId;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String phoneNumber;
  final String verified;
  final String userType;
  final String imageUrl;
  final String bio;
  final String location;

  userInfo({
    @required this.firstName,
    @required this.lastName,
    @required this.userName,
    @required this.email,
    @required this.phoneNumber,
    @required this.verified,
    @required this.userType,
    @required this.userId,
    @required this.imageUrl,
    @required this.bio,
    @required this.location,
  });

  factory userInfo.fromDocument(DocumentSnapshot doc) {
    return userInfo(
        firstName: doc['firstName'],
        lastName: doc['lastName'],
        userName: doc['userName'],
        email: doc['email'],
        phoneNumber: doc['phoneNumber'],
        verified: doc['verified'],
        userType: doc['userType'],
        userId: doc['userId'],
        imageUrl: doc['imageUrl'],
        bio: doc['bio'],
        location: doc['location']);
  }
}
