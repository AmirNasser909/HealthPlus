import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
class UserImagePicker extends StatefulWidget {
 final typeOfNav;
  final void Function(File pickedImage) imagePickFn;
  UserImagePicker({this.imagePickFn,@required this.typeOfNav});

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;


  void _pickImage(ImageSource src)async{
    final pickedFile = await ImagePicker().getImage(source: src);
    if(pickedFile !=null){
     setState(() {
       _pickedImage = File(pickedFile.path);
     });
     widget.imagePickFn(_pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.typeOfNav == "EditUser")
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : NetworkImage(FirebaseAuth.instance.currentUser.photoURL)
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(
                onPressed: () {
                  _pickImage(ImageSource.camera);
                },
                icon: Icon(Icons.camera_alt_outlined),
                label: Text('Add Image \nfrom Camera ',style: TextStyle(color: Colors.teal),textAlign: TextAlign.center,),),
            FlatButton.icon(
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                },
                icon: Icon(Icons.camera_alt_outlined),
                label: Text('Add Image \nfrom Gallery ',style: TextStyle(color: Colors.teal),textAlign: TextAlign.center,),),
          ],
        )
      ],
    );
    if(widget.typeOfNav == "EditSSN")
      return Column(
        children: [
          CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : NetworkImage(FirebaseAuth.instance.currentUser.photoURL)
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton.icon(
                onPressed: () {
                  _pickImage(ImageSource.camera);
                },
                icon: Icon(Icons.camera_alt_outlined),
                label: Text('Add SSN \nfrom Camera ',style: TextStyle(color: Colors.teal),textAlign: TextAlign.center,),),
              FlatButton.icon(
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                },
                icon: Icon(Icons.camera_alt_outlined),
                label: Text('Add SSN \nfrom Gallery ',style: TextStyle(color: Colors.teal),textAlign: TextAlign.center,),),
            ],
          )
        ],
      );
  }
}
