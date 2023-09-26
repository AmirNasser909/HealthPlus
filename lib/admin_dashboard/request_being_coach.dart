import 'dart:io';

import 'package:fitness_app/Models/user_model.dart';
import 'package:fitness_app/Providers/gym_plans_provider.dart';
import 'package:fitness_app/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
class RequestBeingCoach extends StatefulWidget {
  final userData;

  const RequestBeingCoach({@required this.userData});

  @override
  _RequestBeingCoachState createState() => _RequestBeingCoachState();
}

class _RequestBeingCoachState extends State<RequestBeingCoach> {
  GlobalKey<FormState> _formKey = GlobalKey();

  var RequestedCoachData = {
    'CoachId': FirebaseAuth.instance.currentUser.uid,
    'CoachName': '',
    'CoachImageUrl' : '',
    'CoachBio': '',
    'CoachGymName': '',
    'CoachGymAddress':'',
    'CoachExperienceYears': '',
    'CoachSSN': '',
    'CoachSSNImageUrl' : '',
    'CoachPhoneNo': '',
    'CoachWeight': '',
    'CoachWork': ''
  };

  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Being Coach"),
        flexibleSpace: Container(

          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/SHA5BET.png"),
                fit: BoxFit.cover,
                colorFilter:
                ColorFilter.mode(Colors.black26, BlendMode.darken)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(0, 18, 94, 1),
                  Color.fromRGBO(95, 0, 27, 1),
                ]),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 20, top: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.black12,
            image: DecorationImage(
              image: AssetImage("assets/images/SHA5BET.png"),
              fit: BoxFit.cover,
            )),
        child: Container(
          padding: EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.height * 70 / 100,
          child: SizedBox.expand(
              child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          borderOnForeground: true,
                          shadowColor: Color.fromRGBO(0, 18, 94, 1),
                          margin: EdgeInsets.all(40),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CircleAvatar(radius: 50,backgroundImage: NetworkImage(widget.userData['imageUrl']),),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Coach Name",
                                  ),
                                  initialValue: widget.userData['firstName'] + " "+widget.userData['lastName'],
                                  readOnly: true,
                                  onSaved: (newValue) {
                                    RequestedCoachData['CoachName'] = newValue;
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Coach Bio",
                                  ),
                                  initialValue: widget.userData['bio'],
                                  onSaved: (newValue) {
                                    RequestedCoachData['CoachBio'] = newValue;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Invalid Bio";
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Coach Gym Name",
                                  ),
                                  onSaved: (newValue) {
                                    RequestedCoachData['CoachGymName'] = newValue;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Invalid Gym Name";
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Gym Address",
                                  ),
                                  initialValue: widget.userData['location'],
                                  maxLines: 2,
                                  onSaved: (newValue) {
                                    RequestedCoachData['CoachGymAddress'] = newValue;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Invalid Data";
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Coach Experienced Years",
                                  ),
                                  onSaved: (newValue) {
                                    RequestedCoachData['CoachExperienceYears'] = newValue;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "invalid Plan Type";
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Coach SSN",
                                  ),
                                  onSaved: (newValue) {
                                    RequestedCoachData['CoachSSN'] = newValue;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty || value.length < 14) {
                                      return "Invalid SSN";
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Coach PhoneNo",
                                  ),

                                  initialValue: widget.userData['phoneNumber'],
                                  onSaved: (newValue) {
                                    RequestedCoachData['CoachPhoneNo'] = newValue;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty || value.length <= 10) {
                                      return "Invalid Phone";
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Coach Weight",
                                  ),
                                  onSaved: (newValue) {
                                    RequestedCoachData['CoachWeight'] = newValue;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty ) {
                                      return "Invalid Weight";
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Coach Work",
                                  ),
                                  maxLines: 3,
                                  onSaved: (newValue) {
                                    RequestedCoachData['CoachWork'] = newValue;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty ) {
                                      return "Invalid Data";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10,),
                                UserImagePicker(imagePickFn: _pickedImage,typeOfNav: "EditSSN",),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(10),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromRGBO(0, 18, 94, 1)),
                                    padding:
                                    MaterialStateProperty.all(EdgeInsets.fromLTRB(
                                      100,
                                      5,
                                      100,
                                      5,
                                    )),
                                  ),
                                  onPressed: () {
                                    if (!_formKey.currentState.validate()) {
                                      return;
                                    } else {
                                      _formKey.currentState.save();
                                      FocusScope.of(context).unfocus();
                                    }
                                    _submit();
                                  },
                                  child: Text(
                                    "Submit",
                                    style: GoogleFonts.novaRound(fontSize: 25),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ))),
          margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        
      ),
    );
  }

  _submit() async {
    try {
      String newImageUrl;
      if (_userImageFile != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('CoachSSNs')
            .child(FirebaseAuth.instance.currentUser.uid + '.jpg');
        await ref.putFile(_userImageFile);
        newImageUrl = await ref.getDownloadURL();
        _userImageFile = null;
        RequestedCoachData['CoachImageUrl'] = FirebaseAuth.instance.currentUser.photoURL;
        RequestedCoachData['CoachSSNImageUrl'] = newImageUrl;

        Provider.of<GymPlansProvider>(context, listen: false).requestBeingCoach(
            RequestedCoachData);
        Fluttertoast.showToast(
            msg: "Plan Added Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.blueGrey,
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.of(context).pop(true);
      }
      else{
        Fluttertoast.showToast(
            msg: "NO SSN IMAGE DETECTED!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.blueGrey,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (error) {
      Fluttertoast.showToast(
          msg: "We have detected A Problem!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);

      print(error);
      Navigator.of(context).pop(true);
    }
  }



}
