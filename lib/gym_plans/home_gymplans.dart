import 'package:fitness_app/Providers/gym_plans_provider.dart';
import 'package:fitness_app/gym_plans/gym_plans_details.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeGymPlans extends StatefulWidget {
  final UID;
  final user_type;
  final userImageUrl;
  final userDisplayName;

  const HomeGymPlans(
      {@required this.UID,
      @required this.user_type,
      @required this.userImageUrl,
      @required this.userDisplayName});

  @override
  _HomeGymPlansState createState() => _HomeGymPlansState();
}

class _HomeGymPlansState extends State<HomeGymPlans> {
  GlobalKey<FormState> _formKey = GlobalKey();
  bool Ex = false;
  @override
  Widget build(BuildContext context) {
    if (widget.user_type == "Coach") {
      return Scaffold(
          appBar: AppBar(
            title: Text("Gym Plans"),
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
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black12,
              image: DecorationImage(
                image: AssetImage("assets/images/SHA5BET.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                BubbleNormal(
                  isSender: false,
                  text: "You Are Navigating As Coach",
                  color: Color(0xFFE8E8EE),
                  tail: false,
                ),
                FutureBuilder(
                  future: Provider.of<GymPlansProvider>(context, listen: false)
                      .fetchGymPlans(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var GymPlanData = [];
                      snapshot.data.docs.forEach((e) {
                        GymPlanData.add({
                          'GymPlanId': e.id,
                          'CoachId': e['CoachId'],
                          'CoachImageUrl': e['CoachImageUrl'],
                          'CoachName': e['CoachName'],
                          'GymPlanName': e['GymPlanName'],
                          'MonthsOfPlan': e['MonthsOfPlan'],
                          'Instructions': e['Instructions'],
                          'ExercisesToBeLearnt': e['ExercisesToBeLearnt'],
                          'GymName': e['GymName'],
                          'PlanType': e['PlanType'],
                          'TimesOfWatch': e['TimesOfWatch'],
                          'Price': e['Price'],
                        });
                      });
                      print(GymPlanData.length);
                      return Expanded(
                        child: GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent:
                                  MediaQuery.of(context).size.height * 30 / 100,
                              crossAxisCount: 2,
                              crossAxisSpacing: 30,
                              mainAxisSpacing: 20,
                            ),
                            shrinkWrap: true,
                            padding: EdgeInsets.all(10),
                            children: GymPlanData.map((e) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => GymPlanDetails(
                                      GymPlanData: e,
                                      userType: widget.user_type,
                                      userId: e['CoachId'],
                                    ),
                                  ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.blueGrey.withOpacity(0.2)),
                                  padding: EdgeInsets.all(20),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Icon(
                                            Icons.more_vert,
                                            color: Colors.white,
                                          ),
                                        ),
                                        CircleAvatar(
                                          radius: 50,
                                          backgroundImage:
                                              NetworkImage(e['CoachImageUrl']),
                                        ),
                                        Divider(
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          e['GymName'],
                                          style: GoogleFonts.novaRound(
                                              fontSize: 20),
                                        ),
                                        Text("Price " + e['Price']),
                                        Text("Period " + e['MonthsOfPlan'])
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList()),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                )
              ],
            ),
          ),
          floatingActionButton: widget.user_type == "Coach"
              ? FloatingActionButton.extended(
                  onPressed: () {
                    showDialog();
                  },
                  label: Text("Add Coach Gym Plan"))
              : Container());
    }
    if (widget.user_type == "User" || widget.user_type == "Admin")
      return Scaffold(
          appBar: AppBar(
            title: Text("Gym Plans"),
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
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black12,
              image: DecorationImage(
                image: AssetImage("assets/images/SHA5BET.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                BubbleNormal(
                  isSender: false,
                  text: "You Are Navigating As Fitness Player",
                  color: Color(0xFFE8E8EE),
                  tail: false,
                ),
                FutureBuilder(
                  future: Provider.of<GymPlansProvider>(context, listen: false)
                      .fetchGymPlans(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var GymPlanData = [];
                      snapshot.data.docs.forEach((e) {
                        GymPlanData.add({
                          'GymPlanId': e.id,
                          'CoachId': e['CoachId'],
                          'CoachImageUrl': e['CoachImageUrl'],
                          'CoachName': e['CoachName'],
                          'GymPlanName': e['GymPlanName'],
                          'MonthsOfPlan': e['MonthsOfPlan'],
                          'Instructions': e['Instructions'],
                          'ExercisesToBeLearnt': e['ExercisesToBeLearnt'],
                          'GymName': e['GymName'],
                          'PlanType': e['PlanType'],
                          'TimesOfWatch': e['TimesOfWatch'],
                          'Price': e['Price'],
                        });
                      });

                      return Expanded(
                        child: GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent:
                                  MediaQuery.of(context).size.height * 35 / 100,
                              crossAxisCount: 2,
                              crossAxisSpacing: 30,
                              mainAxisSpacing: 20,
                            ),
                            shrinkWrap: true,
                            padding: EdgeInsets.all(10),
                            children: GymPlanData.map((e) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => GymPlanDetails(
                                      GymPlanData: e,
                                      userType: widget.user_type,
                                      userId: e['CoachId'],
                                      Ex: Ex,
                                    ),
                                  ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromRGBO(0, 18, 94, 0.1),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Icon(
                                            Icons.more_vert,
                                            color: Colors.white,
                                          ),
                                        ),
                                        CircleAvatar(
                                          radius: 50,
                                          backgroundImage:
                                              NetworkImage(e['CoachImageUrl']),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          e['GymName'],
                                          style: GoogleFonts.novaRound(
                                            fontSize: 20,
                                            color: Color.fromRGBO(95, 0, 27, 1),
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey,
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Price ",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 19, 94, 1),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(e['Price']),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Period ",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 19, 94, 1),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(e['MonthsOfPlan']),
                                          ],
                                        ),
                                        FutureBuilder(
                                          future: Provider.of<GymPlansProvider>(
                                                  context,
                                                  listen: false)
                                              .fetchSubscribersData(
                                                  e['GymPlanId']),
                                          builder: (context, snapshot) {


                                            if (snapshot.hasData) {
                                              snapshot.data.docs.forEach((e){
                                                if(e['userId'] == FirebaseAuth.instance.currentUser.uid){
                                                  Ex = true;
                                                }
                                              });
                                                if(Ex){
                                                  return TextButton(
                                                      onPressed: () {},
                                                      child: Text("Pending"));
                                                }
                                            }
                                            return Container();
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList()),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                )
              ],
            ),
          ),
          floatingActionButton: widget.user_type == "Coach"
              ? FloatingActionButton.extended(
                  onPressed: () {
                    showDialog();
                  },
                  label: Text("Add Coach Gym Plan"))
              : Container());
  }

  var GymPlanData = {
    'GymPlanId': '',
    'GymPlanName': '',
    'MonthsOfPlan': '',
    'Instructions': '',
    'ExercisesToBeLearnt': '',
    'GymName': '',
    'PlanType': '',
    'TimesOfWatch': '',
    'Price': ''
  };

  void showDialog() {
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
                              labelText: "Gym Plan Name",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid Plan Name";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              GymPlanData['GymPlanName'] = newValue;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Months Of Plan",
                            ),
                            onSaved: (newValue) {
                              GymPlanData['MonthsOfPlan'] = newValue;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid Period";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Instructions",
                            ),
                            maxLines: 3,
                            onSaved: (newValue) {
                              GymPlanData['Instructions'] = newValue;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid Instructions";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Exercises To Be Learnt",
                            ),
                            maxLines: 3,
                            onSaved: (newValue) {
                              GymPlanData['ExercisesToBeLearnt'] = newValue;
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
                              labelText: "Gym Name",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid Gym Name";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              GymPlanData['GymName'] = newValue;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Plan Type",
                            ),
                            onSaved: (newValue) {
                              GymPlanData['PlanType'] = newValue;
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
                              labelText: "Times Of Watch",
                            ),
                            onSaved: (newValue) {
                              GymPlanData['TimesOfWatch'] = newValue;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid Input";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Price",
                            ),
                            onSaved: (newValue) {
                              GymPlanData['Price'] = newValue;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid Price";
                              }
                              return null;
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
                              }
                              _submitUpdate();
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

  _submitUpdate() async {
    try {
      Provider.of<GymPlansProvider>(context, listen: false).addGymPlan(
          widget.UID,
          widget.userImageUrl,
          widget.userDisplayName,
          GymPlanData['GymPlanId'],
          GymPlanData['GymPlanName'],
          GymPlanData['MonthsOfPlan'],
          GymPlanData['Instructions'],
          GymPlanData['ExercisesToBeLearnt'],
          GymPlanData['GymName'],
          GymPlanData['PlanType'],
          GymPlanData['TimesOfWatch'],
          GymPlanData['Price']);

      Fluttertoast.showToast(
          msg: "Plan Added Successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);

      Navigator.of(context).pop(true);
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

  void showDialogForUser() {
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
                              labelText: "Gym Plan Name",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid Plan Name";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              GymPlanData['GymPlanName'] = newValue;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Months Of Plan",
                            ),
                            onSaved: (newValue) {
                              GymPlanData['MonthsOfPlan'] = newValue;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid Period";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Instructions",
                            ),
                            maxLines: 3,
                            onSaved: (newValue) {
                              GymPlanData['Instructions'] = newValue;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid Instructions";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Exercises To Be Learnt",
                            ),
                            maxLines: 3,
                            onSaved: (newValue) {
                              GymPlanData['ExercisesToBeLearnt'] = newValue;
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
                              labelText: "Gym Name",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid Gym Name";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              GymPlanData['GymName'] = newValue;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Plan Type",
                            ),
                            onSaved: (newValue) {
                              GymPlanData['PlanType'] = newValue;
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
                              labelText: "Times Of Watch",
                            ),
                            onSaved: (newValue) {
                              GymPlanData['TimesOfWatch'] = newValue;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid Input";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Price",
                            ),
                            onSaved: (newValue) {
                              GymPlanData['Price'] = newValue;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid Price";
                              }
                              return null;
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
                              }
                              _submitUpdate();
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
}
