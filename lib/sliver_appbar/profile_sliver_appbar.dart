import 'dart:io';

import 'package:fitness_app/Models/user_model.dart';
import 'package:fitness_app/Providers/user_provider.dart';
import 'package:fitness_app/gym_plans/gymplans.dart';
import 'package:fitness_app/profile_screens/show_friends.dart';
import 'package:fitness_app/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:image_picker/image_picker.dart';

class ProfileAppbar extends StatefulWidget {
  final userId;

  const ProfileAppbar({@required this.userId});

  @override
  _ProfileAppbarState createState() => _ProfileAppbarState();
}

class _ProfileAppbarState extends State<ProfileAppbar> {
  GlobalKey<FormState> _formKey = GlobalKey();
  userInfo user;

  var _updatedData = {
    'firstName': '',
    'lastName': '',
    'userName': '',
    'bio': '',
    'phoneNumber': '',
    'location': '',
    'userType': '',
  };
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<UserProvider>(context).fetchUser(widget.userId),
      builder: (context, snapshotUserInfo) {
        if (snapshotUserInfo.hasData) {
          return SliverAppBar(
            floating: true,
            collapsedHeight: MediaQuery.of(context).size.height * 50 / 100,
            flexibleSpace: Container(
                width: MediaQuery.of(context).size.width,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    if (snapshotUserInfo.data['imageUrl'] != "")
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshotUserInfo.data['imageUrl']),
                        radius: MediaQuery.of(context).size.height *
                            MediaQuery.of(context).size.width /
                            4000,
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (snapshotUserInfo.data['firstName'] != "" &&
                              snapshotUserInfo.data['lastName'] != "")
                            Text(
                              snapshotUserInfo.data['firstName'] +
                                  " " +
                                  snapshotUserInfo.data['lastName'],
                              style: GoogleFonts.novaRound(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          if (snapshotUserInfo.data['verified'] == "true")
                            Icon(
                              Icons.verified_user,
                              color: Colors.white,
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (snapshotUserInfo.data['bio'] != "")
                      Text(
                        snapshotUserInfo.data['bio'],
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.novaRound(
                            color: Colors.white, fontSize: 15),
                      ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (snapshotUserInfo.data['phoneNumber'] != "")
                            Container(
                                color: Colors.black26.withOpacity(0.2),
                                child: TextButton.icon(
                                  icon: Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    snapshotUserInfo.data['phoneNumber'],
                                    style: GoogleFonts.novaRound(
                                        color: Colors.white),
                                  ),
                                )),
                          if (snapshotUserInfo.data['location'] != "")
                            Container(
                                color: Colors.black26.withOpacity(0.2),
                                child: TextButton.icon(
                                  icon: Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    snapshotUserInfo.data['location'],
                                    style: GoogleFonts.novaRound(
                                        color: Colors.white),
                                  ),
                                )),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FutureBuilder(
                          future: Provider.of<UserProvider>(context).checkFollowing(snapshotUserInfo.data['userId']),
                          builder:(context,followingSnap)=> InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ShowFriends(showType: "Following",)));

                            },
                            child: Tab(
                              child: Column(
                                children: [
                                  Text(
                                    "Following",
                                    style: GoogleFonts.novaRound(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    followingSnap.data!=null? followingSnap.data.size.toString() : "0",
                                    style: GoogleFonts.novaRound(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ],
                              ),
                              icon: Icon(
                                Icons.accessibility,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        FutureBuilder(
                          future: Provider.of<UserProvider>(context).checkFollowers(snapshotUserInfo.data['userId']),
                          builder:(context,followingSnap)=> InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ShowFriends(showType: "Followers",)));
                            },
                            child: Tab(
                              child: Column(
                                children: [
                                  Text(
                                    "Followers",
                                    style: GoogleFonts.novaRound(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    followingSnap.data!=null? followingSnap.data.size.toString() : "0",
                                    style: GoogleFonts.novaRound(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ],
                              ),
                              icon: Icon(
                                Icons.foundation_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (snapshotUserInfo.data['userId'] ==
                        FirebaseAuth.instance.currentUser.uid)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              showDialog(snapshotUserInfo);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            label: Text("Edit Profile",
                                style: GoogleFonts.novaRound(
                                  color: Colors.black,
                                )),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.only(right: 30, left: 30))),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => GymPlans(UID:snapshotUserInfo.data['userId'] ,user_type:snapshotUserInfo.data['userType'] ,userImageUrl:snapshotUserInfo.data['imageUrl'] ,userDisplayName: snapshotUserInfo.data['firstName']+" "+snapshotUserInfo.data['lastName'],)));
                            },
                            icon: Icon(
                              Icons.timelapse,
                              color: Colors.black,
                            ),
                            label: Text(
                              "My Gym Plans",
                              style: GoogleFonts.novaRound(
                                color: Colors.black,
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.only(right: 25, left: 25))),
                          ),
                        ],
                      ),

                  ],
                )),
            actions: [

              IconButton(
                  icon: Icon(
                    Icons.logout,
                  ),
                  onPressed: () async {
                    await GoogleSignIn().signOut().then((_) async {
                      await FirebaseAuth.instance.signOut();
                    });
                    Navigator.of(context).pop();
                  }),
            ],
          );
        } else {
          return SliverAppBar(
            floating: true,
            collapsedHeight: MediaQuery.of(context).size.height * 40 / 100,
            flexibleSpace: Container(
                //height: MediaQuery.of(context).size.height * 40 / 100,
                width: MediaQuery.of(context).size.width,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: LinearProgressIndicator(),
                    )
                  ],
                )),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.notifications_none,
                  ),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(
                    Icons.logout,
                  ),
                  onPressed: () async {
                    await GoogleSignIn().signOut().then((_) async {
                      await FirebaseAuth.instance.signOut();
                    });
                  }),
            ],
          );
        }
      },
    );
  }

  void showDialog(AsyncSnapshot snapshot) {
    _userImageFile = null;
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height * 70 / 100,
            child: SizedBox.expand(
                child: Center(
                    child: SingleChildScrollView(
              child: Column(
                children: [
                  UserImagePicker(
                    typeOfNav: "EditUser",
                    imagePickFn: _pickedImage
                  ),
                  Card(
                    borderOnForeground: true,
                    shadowColor: Color.fromRGBO(0, 18, 94, 1),
                    margin: EdgeInsets.all(40),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "First Name",
                            ),
                            initialValue: snapshot.data['firstName'],
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid Name";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _updatedData['firstName'] = newValue;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Last Name",
                            ),
                            initialValue: snapshot.data['lastName'],
                            onSaved: (newValue) {
                              _updatedData['lastName'] = newValue;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid Name";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Bio",
                            ),
                            initialValue: snapshot.data['bio'],
                            onSaved: (newValue) {
                              _updatedData['bio'] = newValue;
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
                              labelText: "Username",
                            ),
                            initialValue: snapshot.data['userName'],
                            onSaved: (newValue) {
                              _updatedData['userName'] = newValue;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid userName";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                            ),
                            initialValue: snapshot.data['phoneNumber'],
                            onSaved: (newValue) {
                              _updatedData['phoneNumber'] = newValue;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email",
                            ),
                            initialValue: snapshot.data['email'],
                            readOnly: true,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "User Type",
                            ),
                            initialValue: snapshot.data['userType'],
                            onSaved: (newValue) {
                              _updatedData['userType'] = newValue;
                            },
                           readOnly: true,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Location",
                            ),
                            initialValue: snapshot.data['location'],
                            onSaved: (newValue) {
                              _updatedData['location'] = newValue;
                            },
                          ),
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
                                user = userInfo(
                                  firstName: _updatedData['firstName'],
                                  lastName: _updatedData['lastName'],
                                  userName: _updatedData['userName'],
                                  email:
                                      FirebaseAuth.instance.currentUser.email,
                                  phoneNumber: _updatedData['phoneNumber'],
                                  verified: snapshot.data['verified'],
                                  userType: _updatedData['userType'],
                                  userId: FirebaseAuth.instance.currentUser.uid,
                                  imageUrl: FirebaseAuth
                                      .instance.currentUser.photoURL,
                                  bio: _updatedData['bio'],
                                  location: _updatedData['location'],
                                );
                              }
                              _submitUpdate(user);
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
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  _submitUpdate(userInfo _user) async {
    try {
      String newImageUrl;
      if (_userImageFile != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(FirebaseAuth.instance.currentUser.uid + '.jpg');
        await ref.putFile(_userImageFile);
        newImageUrl = await ref.getDownloadURL();
        await FirebaseAuth.instance.currentUser.updateProfile(
          photoURL: newImageUrl,
        );
        _userImageFile = null;
      }
      await FirebaseAuth.instance.currentUser
          .updateProfile(displayName: _user.firstName + " " + _user.lastName);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        'userId': _user.userId,
        'userName': _user.userName,
        'imageUrl': FirebaseAuth.instance.currentUser.photoURL,
        'phoneNumber': _user.phoneNumber,
        'firstName': _user.firstName,
        'lastName': _user.lastName,
        'email': _user.email,
        'bio': _user.bio,
        'userType': _user.userType,
        'location': _user.location,
      });
      /*     Fluttertoast.showToast(
            msg: "Profile updated successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.blueGrey,
            textColor: Colors.white,
            fontSize: 16.0);
*/
      Navigator.of(context).pop(true);
    } catch (error) {
      /* Fluttertoast.showToast(
          msg: "We have detected A Problem!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);*/
      _userImageFile = null;
      Navigator.of(context).pop(true);
    }
  }
}
