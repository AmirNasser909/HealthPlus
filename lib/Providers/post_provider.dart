import 'package:fitness_app/Models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class PostProvider with ChangeNotifier {


  addPost(Post post) async {
    await FirebaseFirestore.instance.collection("posts").doc().set({
      'User': post.uid,
      'post': post.post,
      'postImageUrl': post.imageUrl,
      'postLocation': post.location,
      'postLikesCount': post.likesCount,
      'publishDate': post.publishDate
    });
  }

  Future<QuerySnapshot> fetchPostsData()async{
    return await FirebaseFirestore.instance.collection("posts").orderBy("publishDate",descending: true).get();
  }
  
  fetchPostsLikers(String postId)async{
    return await FirebaseFirestore.instance.collection("posts").doc(postId).collection("PostLikers").get();
  }

  addLikeToPost(String postId,String UID,int NewLikesCount)async{
    await FirebaseFirestore.instance.collection("posts").doc(postId).update({
      'postLikesCount':NewLikesCount,
    });
    await FirebaseFirestore.instance.collection("posts").doc(postId).collection("PostLikers").doc(UID).set({
      'UserThatLiked' : UID,
    });
  }

  removeLikeFromPost(String postId,String UID,int NewLikesCount)async{
    await FirebaseFirestore.instance.collection("posts").doc(postId).update({
      'postLikesCount':NewLikesCount,
    });
    await FirebaseFirestore.instance.collection("posts").doc(postId).collection("PostLikers").doc(UID).delete();
  }


  fetchPostsComments(String postId)async{
    return await FirebaseFirestore.instance.collection("posts").doc(postId).collection("Comments").get();
  }

  addCommentToPost(String postId,String UID,String commentText)async{
    await FirebaseFirestore.instance.collection("posts").doc(postId).collection("Comments").doc().set({
      'commenterId':UID,
      'commentText': commentText,
    });
  }
}
