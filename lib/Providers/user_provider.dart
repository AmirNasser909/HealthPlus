import 'package:fitness_app/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider with ChangeNotifier {

  Stream fetchUser(String userId)  {
    return FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .snapshots();
  }

   fetchUserAsFuture(String userId)  {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId).get();
  }



  Future<String> checkUserType(String userId)async{
    var documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(userId).get();
      return documentSnapshot['userType'];

  }

   addFollowing(String userId, String PersontoFollow)async{
    await FirebaseFirestore.instance.collection('users').doc(userId).collection("Following").doc(PersontoFollow).set({
      'FollowedUserId' : PersontoFollow,
    });
  }

  addFollower(String userId, String PersonThatFollowed,)async{
    await FirebaseFirestore.instance.collection('users').doc(PersonThatFollowed).collection("Followers").doc(userId).set({
      'UserDoneFollowing' : userId,
    });
  }

  removeFollowing(String userId, String PersontoFollow)async{
    await FirebaseFirestore.instance.collection('users').doc(userId).collection("Following").doc(PersontoFollow).delete();
  }


  removeFollower(String userId, String PersonThatFollowed,)async{
    await FirebaseFirestore.instance.collection('users').doc(PersonThatFollowed).collection("Followers").doc(userId).delete();
  }


  checkFollowing(String userId)async{
    return await FirebaseFirestore.instance.collection('users').doc(userId).collection("Following").get();
  }

  checkFollowers(String userId)async{
    return await FirebaseFirestore.instance.collection('users').doc(userId).collection("Followers").get();
  }


  searchUser(String Name)  {
    return FirebaseFirestore.instance
        .collection("users").get();
  }

  updateUserType(String userId, String newType)async{
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'userType' : newType,
    });
  }

  verifyUser(String userId,)async{
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'verified' : "true",
    });
  }

  unverifyUser(String userId,)async{
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'verified' : "false",
    });
  }




}
