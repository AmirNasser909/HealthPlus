import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Message{
  final MsgId;
  final currentUserId;
  final ReciverId;
  final String MsgText;
  final timestamp;
  final seen;

  Message(
      {
        @required this.MsgId,
        @required this.MsgText,
      @required this.timestamp,
      @required this.currentUserId,
      @required this.ReciverId
      , this.seen });

  factory Message.fromDocument(DocumentSnapshot doc) {
    return Message(MsgId: doc.id,MsgText: doc['MsgText'], timestamp: doc['timestamp'], currentUserId: doc['currentUserId'], ReciverId: doc['ReciverId'],seen:doc['seen']);
  }

}