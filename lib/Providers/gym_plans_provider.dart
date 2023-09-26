import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class GymPlansProvider with ChangeNotifier{

  addGymPlan(String GymPlanId,String CoachId,String CoachImageUrl,String CoachName,String GymPlanName, String MonthsOfPlan,String Instructions , String ExercisesToBeLearnt, String GymName,String PlanType,String TimesOfWatch,String Price)async{
    FirebaseFirestore.instance.collection("GymPlans").doc().set({
      'GymPlanId': GymPlanId,
      'CoachId' : CoachId,
      'CoachImageUrl': CoachImageUrl,
      'CoachName' : CoachName,
      'GymPlanName': GymPlanName,
      'MonthsOfPlan': MonthsOfPlan,
      'Instructions':Instructions,
      'ExercisesToBeLearnt':ExercisesToBeLearnt,
      'GymName': GymName,
      'PlanType':PlanType,
      'TimesOfWatch':TimesOfWatch,
      'Price':Price
    });
  }

  fetchGymPlans()async{
    return FirebaseFirestore.instance.collection("GymPlans").get();
  }
  
  
  FitInGymPlan(userData)async{
    FirebaseFirestore.instance.collection("GymPlans").doc(userData['GymPlanId'],).collection("Subscribers").doc(userData['userId'],).set({
      'userId' : userData['userId'],
      'userDisplayName' : userData['userDisplayName'],
      'GymPlanId':  userData['GymPlanId'],
      'Situation': userData['Situation'],
      'Notes':userData['Notes'],
      'PhoneNo':userData['PhoneNo'],
      'Address': userData['Address'],
      'Length':userData['Length'],
      'Weight':userData['Weight'],
    });
    
  }

  fetchSubscribersData(String GymPlanId)async{
    return await FirebaseFirestore.instance.collection("GymPlans").doc(GymPlanId).collection("Subscribers").get();
  }

  changeSituationToApproved(String GymPlanId,String userId)async{
    FirebaseFirestore.instance.collection("GymPlans").doc(GymPlanId).collection("Subscribers").doc(userId).update({
      'Situation' : 'Approved',
    });
  }

  changeSituationToRefused(String GymPlanId,String userId)async{
    FirebaseFirestore.instance.collection("GymPlans").doc(GymPlanId).collection("Subscribers").doc(userId).update({
      'Situation' : 'Refused',
    });
  }


  requestBeingCoach(RequestedCoachData)async{
    FirebaseFirestore.instance.collection("RequestedBeingCoach").doc(RequestedCoachData['CoachId']).set({
      'CoachId': RequestedCoachData['CoachId'],
      'CoachName': RequestedCoachData['CoachName'],
      'CoachImageUrl' : RequestedCoachData['CoachImageUrl'],
      'CoachBio':RequestedCoachData['CoachBio'],
      'CoachGymName': RequestedCoachData['CoachGymName'],
      'CoachGymAddress': RequestedCoachData['CoachGymAddress'],
      'CoachExperienceYears': RequestedCoachData['CoachExperienceYears'],
      'CoachSSN': RequestedCoachData['CoachSSN'],
      'CoachSSNImageUrl' : RequestedCoachData['CoachSSNImageUrl'],
      'CoachPhoneNo': RequestedCoachData['CoachPhoneNo'],
      'CoachWeight': RequestedCoachData['CoachWeight'],
      'CoachWork': RequestedCoachData['CoachWork'],
    });
  }


  Future<QuerySnapshot> fetchRequestedCoachesData()async{
    return await FirebaseFirestore.instance.collection("RequestedBeingCoach").get();
  }

  deleteApprovedUsers(String CoachId)async{
    return FirebaseFirestore.instance.collection("RequestedBeingCoach").doc(CoachId).delete();
  }


}