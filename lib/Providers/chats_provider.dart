import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatProvider with ChangeNotifier{
  
  sendMsg(String currentUserId,String ReciverId,String MsgText)async{
    final DateTime timestamp = DateTime.now();
    FirebaseFirestore.instance.collection("Chats").doc(currentUserId).collection("chatInfo").doc(ReciverId).collection("Messages").add({
      'currentUserId' : currentUserId,
      'ReciverId': ReciverId,
      'timestamp': timestamp,
      'MsgText' : MsgText,
      'seen' : false,
    });

    FirebaseFirestore.instance.collection("Chats").doc(ReciverId).collection("chatInfo").doc(currentUserId).collection("Messages").add({
      'currentUserId' : currentUserId,
      'ReciverId': ReciverId,
      'timestamp': timestamp,
      'MsgText' : MsgText,
      'seen' : false,

    });

    FirebaseFirestore.instance.collection("Chats").doc(currentUserId).collection("Connections").doc(ReciverId).set({
      'senderId' : currentUserId,
      'reciverId': ReciverId,
    });
    FirebaseFirestore.instance.collection("Chats").doc(ReciverId).collection("Connections").doc(currentUserId).set({
      'senderId' : currentUserId,
      'reciverId': ReciverId,
    });
  }

   Stream<QuerySnapshot> fetchMsg(String currentUserId,String ReciverId){
     return  FirebaseFirestore.instance.collection("Chats").doc(currentUserId).collection("chatInfo").doc(ReciverId).collection("Messages").orderBy("timestamp",descending: false).snapshots();
  }

   Stream<QuerySnapshot> fetchAllConnections(String currentUserId,){
    return FirebaseFirestore.instance.collection("Chats").doc(currentUserId).collection("Connections").snapshots();
  }

  updateMsgSeen (String currentUserId , String ReciverId,MsgId)async{
    FirebaseFirestore.instance.collection("Chats").doc(currentUserId).collection("chatInfo").doc(ReciverId).collection("Messages").doc(MsgId).update({
      'seen' : true,
    },);
  }
  
}