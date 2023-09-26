import 'dart:io';

import 'package:fitness_app/Models/post_model.dart';
import 'package:fitness_app/Providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  var _postController = TextEditingController();
  File _pickedImage;
  String Location;

  void _pickImage(ImageSource src) async {
    final pickedFile = await ImagePicker().getImage(source: src);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(95, 0, 27, 1),
        title: Text(FirebaseAuth.instance.currentUser.displayName),
        actions: [
          IconButton(
              icon: CircleAvatar(
                  backgroundImage:
                      NetworkImage(FirebaseAuth.instance.currentUser.photoURL)),
              onPressed: () {})
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black12,
          image: DecorationImage(
            image: AssetImage("assets/images/SHA5BET.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(_pickedImage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InteractiveViewer(
                    panEnabled: false,
                    boundaryMargin: EdgeInsets.all(100),
                    minScale: 0.5,
                    maxScale: 2,
                    child: Image.file(_pickedImage),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: _postController,
                  toolbarOptions: ToolbarOptions(
                    selectAll: true,
                    paste: true,
                    cut: true,
                    copy: true,
                  ),
                  cursorColor: Color.fromRGBO(95, 0, 27, .7),
                  decoration: InputDecoration(
                    labelText: "Add Post To The Flow",
                    suffixIcon: Icon(
                      Icons.post_add,
                      color: Color.fromRGBO(95, 0, 27, .7),
                    ),
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(95, 0, 27, .7),
                    ),
                    contentPadding: EdgeInsets.all(20),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  maxLines: 10,
                  autofocus: false,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.location_on),
                    onPressed: () {
                      getUserLocation();

                    },
                    color: Color.fromRGBO(95, 0, 27, .7),
                  ),
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () {
                      _pickImage(ImageSource.gallery);
                    },
                    color: Color.fromRGBO(95, 0, 27, .7),
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {
                      _pickImage(ImageSource.camera);
                    },
                    color: Color.fromRGBO(95, 0, 27, .7),
                  ),
                  if (_postController.text.isEmpty)
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.only(left: 30, right: 30)),
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(95, 0, 27, .7),
                        ),
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  else
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.only(left: 30, right: 30)),
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(95, 0, 27, .7),
                        ),
                      ),
                      onPressed: () {
                        _submit();
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              if(Location !=null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.location_city,color:  Color.fromRGBO(95, 0, 27, .7),),
                  SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(Location,style: TextStyle(color:  Color.fromRGBO(95, 0, 27, .7),),),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  _submit() async{
    final DateTime timestamp = DateTime.now();
    FocusScope.of(context).unfocus();
    String url;
    if(_pickedImage != null){
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_posts').child(FirebaseAuth.instance.currentUser.uid)
          .child('${DateTime.now()}.jpg');
      await ref.putFile(_pickedImage);
      url = await ref.getDownloadURL();
    }

    Post post = Post(
      imageUrl: url,
      location: Location!=null? Location : null,
      post: _postController.text,
      publishDate: Timestamp.fromDate(timestamp),
      uid: FirebaseAuth.instance.currentUser.uid,
      likesCount: 0,
    );
    Provider.of<PostProvider>(context, listen: false).addPost(post);
    Fluttertoast.showToast(
        msg: "POST SUBMITTED!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.of(context).pop();
  }


  getUserLocation() async {

    try {
      Position position = await Geolocator().getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placemark = placemarks[0];
      String completeAddress =
          '${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark
          .subLocality} ${placemark.locality}, ${placemark
          .subAdministrativeArea}, ${placemark.administrativeArea} ${placemark
          .postalCode}, ${placemark.country}';
      print(completeAddress);
      String formattedAddress = "${placemark.locality}, ${placemark.country}";

      setState(() {
        Location = formattedAddress;
      });
    }
    catch(ex){
      print("ERROR");
    }
  }

}
