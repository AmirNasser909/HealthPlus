import 'package:fitness_app/Providers/user_provider.dart';
import 'package:fitness_app/admin_dashboard/admin_add.dart';
import 'package:fitness_app/admin_dashboard/request_being_coach.dart';
import 'package:fitness_app/calories_screen/calories_detector.dart';

import 'package:fitness_app/excersices_screens/excersices_home.dart';
import 'package:fitness_app/gym_plans/home_gymplans.dart';
import 'package:fitness_app/messenger_dashboard/messenger_home.dart';
import 'package:fitness_app/profile_screens/people.dart';
import 'package:fitness_app/profile_screens/profile.dart';
import 'package:fitness_app/timeline/Timeline.dart';
import 'package:fitness_app/trackers_screens/tracker_home.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 10,
        child: Container(
            height: MediaQuery.of(context).size.height * 100 / 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black12,
              image: DecorationImage(
                image: AssetImage("assets/images/SHA5BET.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: FutureBuilder(
              future: Provider.of<UserProvider>(context, listen: false)
                  .fetchUserAsFuture(FirebaseAuth.instance.currentUser.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    children: [
                      if(snapshot.data['userType'] == "Admin")
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => AdminDBAddView()));
                        },
                        title: Text(
                          "Admin Dashboard",
                        ),
                        subtitle: Text("Administration of fitness app"),
                        trailing: Icon(Icons.admin_panel_settings),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => Timeline()));
                        },
                        title: Text(
                          "Timeline",
                        ),
                        subtitle: Text("Explore new fitty waves"),
                        trailing: Icon(Icons.timelapse),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => ProfileView()));
                        },
                        title: Text(
                          "Profile",
                        ),
                        subtitle: Text("Manage Your In-Body Info"),
                        trailing: Icon(Icons.account_circle),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => MessengerHome()));
                        },
                        title: Text(
                          "Messenger",
                        ),
                        subtitle: Text("Chat With Fitness Users"),
                        trailing: Icon(Icons.message),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => PeopleView()));
                        },
                        title: Text(
                          "Explore People",
                        ),
                        subtitle: Text("Manage Your In-Body Info"),
                        trailing: Icon(Icons.people),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => CaloriesDetector()));
                        },
                        subtitle: Text("Check Your Food"),
                        title: Text("Calories Counter"),
                        trailing: Icon(OMIcons.fastfood),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => Tracker()));
                        },
                        title: Text("Tracker"),
                        subtitle: Text("Help You Manage Your Fit Life"),
                        trailing: Icon(OMIcons.hearing),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ExersicesHome(
                                    verticalView: true,
                                  )));
                        },
                        title: Text("Exercises"),
                        subtitle: Text("Navigate Body Muscles Exercises"),
                        trailing: Icon(OMIcons.settings),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => HomeGymPlans(
                                    UID: snapshot.data['userId'],
                                    userDisplayName:
                                        snapshot.data['firstName'] +
                                            " " +
                                            snapshot.data['lastName'],
                                    userImageUrl: snapshot.data['imageUrl'],
                                    user_type: snapshot.data['userType'],
                                  )));
                        },
                        title: Text("Gym Plans"),
                        subtitle: Text("Navigate Coaches Plans"),
                        trailing: Icon(OMIcons.gavel),
                      ),
                      if(snapshot.data['userType'] == "User")
                      ListTile(
                        onTap: ()  {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => RequestBeingCoach(userData: snapshot.data,)));
                        },
                        title: Text("Request Being Coach"),
                        subtitle: Text("We need More!"),
                        trailing: Icon(Icons.assessment_outlined),
                      ),
                      ListTile(
                        onTap: () async {
                          await GoogleSignIn().signOut().then((_) async {
                            await FirebaseAuth.instance.signOut();
                          });
                          Navigator.of(context).pop();
                        },
                        title: Text("Sign Out"),
                        subtitle: Text("We Hope Seeing You Back!"),
                        trailing: Icon(Icons.logout),
                      ),

                    ],
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            )));
  }
}
