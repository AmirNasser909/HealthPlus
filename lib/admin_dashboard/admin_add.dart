import 'package:fitness_app/Providers/admin_Provider.dart';
import 'package:fitness_app/admin_dashboard/excersices_dashboard.dart';
import 'package:fitness_app/admin_dashboard/users_dashboard.dart';
import 'package:fitness_app/admin_dashboard/view_requested_Coaches.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/widgets/user_image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class AdminDBAddView extends StatefulWidget {
  @override
  _AdminDBAddViewState createState() => _AdminDBAddViewState();
}

class _AdminDBAddViewState extends State<AdminDBAddView> {
  GlobalKey<FormState> _formKey = GlobalKey();

  var _AppWelcomingData = {
    "AppWelcomingMessage": '',
    "FirstImageLink": '',
    "SecondImageLink": '',
    "ThirdImageLink": '',
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Admin Dashboard"),
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
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(right: 20, left: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      alignment: Alignment.centerRight,
                      image: AssetImage("assets/images/TRAINEE.png"),
                      scale: 1,
                    ),
                    color: Colors.pink.shade50,
                    gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(
                            0,
                            18,
                            94,
                            0.8,
                          ),
                          Color.fromRGBO(
                            0,
                            18,
                            94,
                            0.5,
                          ),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("App Welcoming !",
                        style: GoogleFonts.novaRound(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Customize User \nMessages Interface",
                      style: GoogleFonts.novaRound(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontSize: 13),
                    ),
                    ElevatedButton(
                      child: Text(
                        "Edit!",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        showDialog("AppWelcoming");
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.only(left: 20, right: 20))),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      alignment: Alignment.centerRight,
                      image: AssetImage("assets/images/TRAINEE.png"),
                      scale: 1,
                    ),
                    color: Colors.pink.shade50,
                    gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(95, 0, 27, .8),
                          Color.fromRGBO(95, 0, 27, .5),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Exercises Dash !",
                        style: GoogleFonts.novaRound(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Customize Exercises \nCardio Dashboard",
                      style: GoogleFonts.novaRound(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontSize: 13),
                    ),
                    ElevatedButton(
                      child: Text(
                        "Customize!",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Exercisesdashboard(),));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.only(left: 20, right: 20))),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      alignment: Alignment.centerRight,
                      image: AssetImage("assets/images/TRAINEE.png"),
                      scale: 1,
                    ),
                    color: Colors.pink.shade50,
                    gradient: LinearGradient(
                        colors: [
                          Colors.teal,
                          Colors.blueGrey
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Coaches Dash !",
                        style: GoogleFonts.novaRound(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Customize Coaches \nApproval Dashboard",
                      style: GoogleFonts.novaRound(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontSize: 13),
                    ),
                    ElevatedButton(
                      child: Text(
                        "Customize!",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestedCoaches(),));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.only(left: 20, right: 20))),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.pink.shade50,
                    gradient: LinearGradient(
                        colors: [
                          Colors.green,
                          Colors.grey
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Users Dashboard !",
                        style: GoogleFonts.novaRound(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Verify Users \Deleting Dashboard",
                      style: GoogleFonts.novaRound(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontSize: 13),
                    ),
                    ElevatedButton(
                      child: Text(
                        "Head to!",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => UsersDashboard(),));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.only(left: 20, right: 20))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void showDialog(String TypeOfDialog) {
    if (TypeOfDialog == "AppWelcoming") {
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
                            FutureBuilder(
                                future: Provider.of<AdminProvider>(context,
                                    listen: false)
                                    .fetchAppWelcomingData(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Card(
                                      borderOnForeground: true,
                                      shadowColor: Color.fromRGBO(0, 18, 94, 1),
                                      margin: EdgeInsets.all(40),
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            Text(
                                              "App Welcoming Messages Data",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextFormField(
                                              initialValue:
                                              snapshot.data['AppWelcomingMessage'],
                                              maxLength: 70,
                                              maxLines: 2,
                                              decoration: InputDecoration(
                                                helperText: "First Welcoming Message",
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "Cannot Be Empty Message!";
                                                }
                                                return null;
                                              },
                                              onSaved: (newValue) {
                                                _AppWelcomingData[
                                                'AppWelcomingMessage'] = newValue;
                                              },
                                            ),
                                            TextFormField(
                                              maxLines: 2,
                                              initialValue:
                                              snapshot.data['FirstImageLink'],
                                              decoration: InputDecoration(
                                                helperText: "First Image Link",
                                              ),
                                              onSaved: (newValue) {
                                                _AppWelcomingData['FirstImageLink'] =
                                                    newValue;
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "Cannot Be Empty Link!";
                                                }
                                                return null;
                                              },
                                            ),
                                            TextFormField(
                                              maxLines: 2,
                                              initialValue:
                                              snapshot.data['SecondImageLink'],
                                              decoration: InputDecoration(
                                                helperText: "Second Image Link",
                                              ),
                                              onSaved: (newValue) {
                                                _AppWelcomingData['SecondImageLink'] =
                                                    newValue;
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "Cannot Be Empty Link!";
                                                }
                                                return null;
                                              },
                                            ),
                                            TextFormField(
                                              maxLines: 2,
                                              initialValue:
                                              snapshot.data['ThirdImageLink'],
                                              decoration: InputDecoration(
                                                helperText: "Third Image Link",
                                              ),
                                              onSaved: (newValue) {
                                                _AppWelcomingData['ThirdImageLink'] =
                                                    newValue;
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "Cannot Be Empty Link!";
                                                }
                                                return null;
                                              },
                                            ),
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                elevation:
                                                MaterialStateProperty.all(10),
                                                backgroundColor:
                                                MaterialStateProperty.all(
                                                    Color.fromRGBO(0, 18, 94, 1)),
                                                padding: MaterialStateProperty.all(
                                                    EdgeInsets.fromLTRB(
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
                                                  _submitEditOnAppWelcoming();
                                                }
                                              },
                                              child: Text(
                                                "Submit",
                                                style:
                                                GoogleFonts.novaRound(fontSize: 25),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  return CircularProgressIndicator();
                                })
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
            position:
            Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
            child: child,
          );
        },
      );
    }
  /*  if (TypeOfDialog == "Exercises") {
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

              padding: EdgeInsets.only(top: 20,bottom: 20),
              height: MediaQuery.of(context).size.height * 70 / 100,
              child: SizedBox.expand(
                  child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                          Card(

                          child:  Column(
                              children: [
                                Text(
                                  "Exercises Dashboard Customization",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20,),
                                *//*CarouselSlider(
                                  options: CarouselOptions(height: MediaQuery.of(context).size.height* 20 /100),
                                  items: excersices_widget_list.map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                            width: MediaQuery.of(context).size.width,
                                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                                            child: i,
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),*//*
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    child: Text("Add Category"),
                                    onPressed: (){},

                                  ),
                                )
                        ])
                          ),
                          ],
                        ),
                      ))),
              margin: EdgeInsets.only(bottom: 50, left: 12, right: 12,top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          );
        },
        transitionBuilder: (_, anim, __, child) {
          return SlideTransition(
            position:
            Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
            child: child,
          );
        },
      );
    }*/


  }

  _submitEditOnAppWelcoming() {
    print(_AppWelcomingData);
    Provider.of<AdminProvider>(context, listen: false)
        .updateAppWelcomingData(_AppWelcomingData['AppWelcomingMessage'], _AppWelcomingData['FirstImageLink'],_AppWelcomingData['SecondImageLink'], _AppWelcomingData['ThirdImageLink']);
  }
}
