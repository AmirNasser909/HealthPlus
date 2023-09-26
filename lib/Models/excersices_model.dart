import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String ExId;
  final String ExName;
  final String ExBio;
  final String ExImageLink;
  final String ExVideoLink;
  final String ExSteps;

  Exercise(
      {this.ExId,
      this.ExName,
      this.ExBio,
      this.ExImageLink,
      this.ExVideoLink,
      this.ExSteps});

  factory Exercise.fromDocument(DocumentSnapshot doc){
    return Exercise(
      ExId: doc.id,
      ExName: doc['exName'],
      ExBio: doc['exBio'],
      ExImageLink: doc['exImageLink'],
      ExVideoLink: doc['exVideoLink'],
      ExSteps: doc['exSteps'],
    );
  }

}