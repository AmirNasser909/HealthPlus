import 'package:fitness_app/Models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/Models/excersices_model.dart';
class AdminProvider with ChangeNotifier{

  Future<DocumentSnapshot> fetchAppWelcomingData()async{
    var querySnapshot = await FirebaseFirestore.instance.collection("AppWelcomingData").doc("App_Welcoming_Fields").get();
    return querySnapshot;
  }

  updateAppWelcomingData(String Msg, String fLink, String sLink, String tLink)async{
     await FirebaseFirestore.instance.collection("AppWelcomingData").doc("App_Welcoming_Fields").update(
         {
           'AppWelcomingMessage' : Msg,
           'FirstImageLink':fLink,
           'SecondImageLink':sLink,
           'ThirdImageLink' :tLink,
         });
  }

   fetchCategoriesData()async{
    return await FirebaseFirestore.instance.collection("exercisesCategories").get();
  }

  addNewCategory(Category category)async{
    await FirebaseFirestore.instance.collection("exercisesCategories").doc().set(
        {
          'categoryName' : category.categoryName,
          'categoryImageLink':category.categoryImageLink,
          'categoryBio':category.categoryBio,
        });
  }

  fetchExercises(String categoryId)async{
    return await FirebaseFirestore.instance.collection("exercisesCategories").doc(categoryId).collection("exercises").get();
  }

  addExerciseToCategory(Exercise exerciese,String categoryId)async{
    await FirebaseFirestore.instance.collection("exercisesCategories").doc(categoryId).collection("exercises").doc().set(
        {
          'exName': exerciese.ExName,
          'exBio' : exerciese.ExBio,
          'exImageLink' :  exerciese.ExImageLink,
          'exVideoLink': exerciese.ExVideoLink,
          'exSteps': exerciese.ExSteps,
        });
  }

}