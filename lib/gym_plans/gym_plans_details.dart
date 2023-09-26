import 'package:fitness_app/Providers/gym_plans_provider.dart';
import 'package:fitness_app/Providers/user_provider.dart';
import 'package:fitness_app/profile_screens/profile.dart';
import 'package:fitness_app/profile_screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GymPlanDetails extends StatefulWidget {
  final GymPlanData;
  final userType;
  final userId;
  final Ex;

  const GymPlanDetails(
      {@required this.GymPlanData, @required this.userType, @required this.userId ,@required this.Ex});

  @override
  _GymPlanDetailsState createState() => _GymPlanDetailsState();
}

class _GymPlanDetailsState extends State<GymPlanDetails> {
  GlobalKey<FormState> _formKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              Text(
                                widget.GymPlanData['CoachName'],
                                style: GoogleFonts.novaRound(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.foundation_rounded,
                                color: Colors.white,
                              ),
                              Text(
                                widget.GymPlanData['GymPlanName'],
                                style: GoogleFonts.novaRound(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.timelapse_outlined,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  Text(
                                    widget.GymPlanData['MonthsOfPlan'],
                                    style: GoogleFonts.novaRound(
                                        fontSize: 11, color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.monetization_on_outlined,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  Text(
                                    widget.GymPlanData['Price'],
                                    style: GoogleFonts.novaRound(
                                        fontSize: 11, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 6 / 100,
                        backgroundImage:
                            NetworkImage(widget.GymPlanData['CoachImageUrl']),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Instructions",
                        style: GoogleFonts.novaRound(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.GymPlanData['Instructions'],
                        style: GoogleFonts.novaRound(
                            fontSize: 20, color: Colors.white),
                      )),
                  Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Exercises To Be Learnt",
                        style: GoogleFonts.novaRound(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.GymPlanData['ExercisesToBeLearnt'],
                        style: GoogleFonts.novaRound(
                            fontSize: 20, color: Colors.white),
                      )),
                  Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.merge_type,
                            color: Colors.white,
                            size: 20,
                          ),
                          Text(
                            widget.GymPlanData['PlanType'],
                            style: GoogleFonts.novaRound(
                                fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: Colors.white,
                            size: 20,
                          ),
                          Text(
                            widget.GymPlanData['TimesOfWatch'],
                            style: GoogleFonts.novaRound(
                                fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (widget.userType == "User" || widget.userType == "admin")
                    if (!widget.Ex)
                      ElevatedButton(
                        onPressed: () {
                          showDialogForUser();
                        },
                        child: Text("Fit In"),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.only(left: 30, right: 30))),
                      )
                    else
                      TextButton(onPressed: () {}, child: Text("Pending",style: TextStyle(fontSize: 20),)),

                  if(widget.userType == "Coach" && widget.userId == FirebaseAuth.instance.currentUser.uid)
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       FutureBuilder(
                         future: Provider.of<GymPlansProvider>(context,listen: false).fetchSubscribersData(widget.GymPlanData['GymPlanId']) ,
                         builder:(context, snapshot) {
                           var GymPlanSubscriberData = [];
                           bool isClicked= false;
                           if(snapshot.hasData){
                             snapshot.data.docs.forEach((e) {
                               GymPlanSubscriberData.add({
                                 'userId': e['userId'],
                                 'userDisplayName':e['userDisplayName'],
                                 'GymPlanId':e['GymPlanId'],
                                 'Situation':e['Situation'],
                                 'Notes':e['Notes'],
                                 'PhoneNo':e['PhoneNo'],
                                 'Address': e['Address'],
                                 'Length': e['Length'],
                                 'Weight': e['Weight'],
                               });
                             });

                             GymPlanSubscriberData = GymPlanSubscriberData.where((element) => element['Situation']== "Pending").toList();

                             return ElevatedButton(
                               onPressed: () {
                                 Scaffold.of(context)
                                     .showBottomSheet(
                                         (context) => SingleChildScrollView(
                                       child: Column(
                                         children: [

                                           Container(
                                               height: MediaQuery.of(
                                                   context)
                                                   .size
                                                   .height *
                                                   75 /
                                                   100,
                                               width: MediaQuery.of(
                                                   context)
                                                   .size
                                                   .width,
                                               padding: EdgeInsets
                                                   .all(
                                                   20),
                                               decoration:
                                               BoxDecoration(
                                                 color: Colors
                                                     .black12,
                                                 image:
                                                 DecorationImage(
                                                   image: AssetImage(
                                                       "assets/images/SHA5BET.png"),
                                                   fit: BoxFit
                                                       .cover,
                                                 ),
                                               ),
                                               child: SingleChildScrollView(
                                                 child: Column(
                                                     children: GymPlanSubscriberData.map((e) {
                                                       return Column(
                                                         children: [
                                                           Text("Pending Requests",style: TextStyle(color: Colors.black,backgroundColor: Colors.white.withOpacity(0)),),
                                                           Divider(
                                                             thickness: 1,
                                                             color: Colors.white,
                                                           ),
                                                           Container(
                                                             padding: EdgeInsets.all(20),
                                                             margin: EdgeInsets.all(5),
                                                             width: MediaQuery.of(context).size.width,
                                                             decoration: BoxDecoration(
                                                               borderRadius: BorderRadius.circular(5),
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
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                               children: [
                                                                 FutureBuilder(
                                                                   future: Provider.of<UserProvider>(
                                                                     context,
                                                                   ).fetchUserAsFuture(e['userId']),
                                                                   builder: (context, ss) {
                                                                     if (ss.hasData) {
                                                                       return InkWell(
                                                                         borderRadius: BorderRadius.circular(20),
                                                                         onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfile(userId: e['userId']),)),
                                                                         child: Row(
                                                                           mainAxisAlignment: MainAxisAlignment.center,
                                                                           children: [
                                                                             CircleAvatar(backgroundImage: NetworkImage(ss.data['imageUrl'])),
                                                                             SizedBox(width: 8,),
                                                                             Text(ss.data['firstName']+ " "+ss.data['lastName'],style: TextStyle(color: Colors.white),),
                                                                           ],
                                                                         ),
                                                                       );
                                                                     }
                                                                     return CircularProgressIndicator();
                                                                   },
                                                                 ),
                                                                 SizedBox(height: 10,),
                                                                 Row(

                                                                   children: [
                                                                     Icon(
                                                                       Icons.phone,
                                                                       color: Colors.white,
                                                                       size: 20,
                                                                     ),
                                                                     Text(
                                                                       e['PhoneNo'],
                                                                       style: GoogleFonts.novaRound(
                                                                           fontSize: 15, color: Colors.white),
                                                                     ),
                                                                   ],
                                                                 ),
                                                                 SizedBox(height: 10,),
                                                                 Row(

                                                                   children: [
                                                                     Icon(
                                                                       Icons.location_on,
                                                                       color: Colors.white,
                                                                       size: 20,
                                                                     ),
                                                                     Text(
                                                                       e['Address'],
                                                                       style: GoogleFonts.novaRound(
                                                                           fontSize: 15, color: Colors.white),
                                                                     ),
                                                                   ],
                                                                 ),
                                                                 SizedBox(height: 10,),
                                                                 Row(

                                                                   children: [
                                                                     Row(
                                                                       children: [
                                                                         Icon(
                                                                           Icons.line_weight,
                                                                           color: Colors.white,
                                                                           size: 20,
                                                                         ),
                                                                         Text(
                                                                           " Weight : " + e['Weight'],
                                                                           style: GoogleFonts.novaRound(
                                                                               fontSize: 15, color: Colors.white),
                                                                         ),
                                                                       ],
                                                                     ),

                                                                   ],
                                                                 ),
                                                                 SizedBox(height: 10,),
                                                                 Row(

                                                                   children: [
                                                                     Icon(
                                                                       Icons.height,
                                                                       color: Colors.white,
                                                                       size: 20,
                                                                     ),
                                                                     Text(
                                                                       "Height : " +e['Length'],
                                                                       style: GoogleFonts.novaRound(
                                                                           fontSize: 15, color: Colors.white),
                                                                     ),
                                                                   ],
                                                                 ),
                                                                 SizedBox(height: 10,),
                                                                 Row(
                                                                   children: [

                                                                     Text(
                                                                       "Notes : " +e['Notes'],
                                                                       style: GoogleFonts.novaRound(
                                                                           fontSize: 15, color: Colors.white),
                                                                     ),
                                                                   ],
                                                                 ),

                                                                Row(
                                                                  children: [
                                                                    IconButton(icon: Icon(Icons.clear,color: Colors.white,), onPressed: (){
                                                                      Provider.of<GymPlansProvider>(context,listen: false).changeSituationToApproved(e['GymPlanId'], e['userId']);
                                                                      GymPlanSubscriberData.removeWhere((element) => element['GymPlanId'] == e['GymPlanId']);
                                                                      Fluttertoast.showToast(
                                                                          msg: "Approved Succusfully",
                                                                          toastLength: Toast.LENGTH_SHORT,
                                                                          gravity: ToastGravity.CENTER,
                                                                          timeInSecForIosWeb: 3,
                                                                          backgroundColor: Colors.blueGrey,
                                                                          textColor: Colors.white,
                                                                          fontSize: 16.0);
                                                                      Navigator.of(context).pop();
                                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfile(userId: e['userId']),));
                                                                    },),

                                                                    IconButton(icon: Icon(Icons.clear,color: Colors.white,), onPressed: (){
                                                                      Provider.of<GymPlansProvider>(context,listen: false).changeSituationToRefused(e['GymPlanId'], e['userId']);
                                                                      GymPlanSubscriberData.removeWhere((element) => element['GymPlanId'] == e['GymPlanId']);
                                                                      Fluttertoast.showToast(
                                                                          msg: "Refused Successfully",
                                                                          toastLength: Toast.LENGTH_SHORT,
                                                                          gravity: ToastGravity.CENTER,
                                                                          timeInSecForIosWeb: 3,
                                                                          backgroundColor: Colors.blueGrey,
                                                                          textColor: Colors.white,
                                                                          fontSize: 16.0);
                                                                      Navigator.of(context).pop();
                                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfile(userId: e['userId']),));
                                                                    })                                                                  ],
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                )

                                                               ],

                                                             ),
                                                           ),

                                                         ],
                                                       );
                                                     }).toList()),
                                               ))
                                         ],
                                       ),
                                     ));
                               },
                               child: Text("Approve Pending"),
                               style: ButtonStyle(
                                   padding: MaterialStateProperty.all(
                                       EdgeInsets.only(left: 30, right: 30))),
                             );
                           }
                           return Center(child: CircularProgressIndicator());
                         },
                       ),

                       FutureBuilder(
                         future: Provider.of<GymPlansProvider>(context,listen: false).fetchSubscribersData(widget.GymPlanData['GymPlanId']) ,
                         builder:(context, snapshot) {
                           var GymPlanSubscriberData = [];
                           if(snapshot.hasData){
                             snapshot.data.docs.forEach((e) {
                               GymPlanSubscriberData.add({
                                 'userId': e['userId'],
                                 'userDisplayName':e['userDisplayName'],
                                 'GymPlanId':e['GymPlanId'],
                                 'Situation':e['Situation'],
                                 'Notes':e['Notes'],
                                 'PhoneNo':e['PhoneNo'],
                                 'Address': e['Address'],
                                 'Length': e['Length'],
                                 'Weight': e['Weight'],
                               });
                             });

                             GymPlanSubscriberData = GymPlanSubscriberData.where((element) => element['Situation']== "Approved").toList();

                             return ElevatedButton(
                               onPressed: () {
                                 Scaffold.of(context)
                                     .showBottomSheet(
                                         (context) => SingleChildScrollView(
                                       child: Column(
                                         children: [

                                           Container(
                                               height: MediaQuery.of(
                                                   context)
                                                   .size
                                                   .height *
                                                   75 /
                                                   100,
                                               width: MediaQuery.of(
                                                   context)
                                                   .size
                                                   .width,
                                               padding: EdgeInsets
                                                   .all(
                                                   20),
                                               decoration:
                                               BoxDecoration(
                                                 color: Colors
                                                     .black12,
                                                 image:
                                                 DecorationImage(
                                                   image: AssetImage(
                                                       "assets/images/SHA5BET.png"),
                                                   fit: BoxFit
                                                       .cover,
                                                 ),
                                               ),
                                               child: SingleChildScrollView(
                                                 child: Column(
                                                     children: GymPlanSubscriberData.map((e) {
                                                       return Column(
                                                         children: [
                                                           Text("Approval Subscribers",style: TextStyle(color: Colors.black,backgroundColor: Colors.white.withOpacity(0)),),
                                                           Divider(
                                                             thickness: 1,
                                                             color: Colors.white,
                                                           ),
                                                           Container(
                                                             padding: EdgeInsets.all(20),
                                                             margin: EdgeInsets.all(5),
                                                             width: MediaQuery.of(context).size.width,
                                                             decoration: BoxDecoration(
                                                               borderRadius: BorderRadius.circular(5),
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
                                                               crossAxisAlignment: CrossAxisAlignment.start,
                                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                               children: [
                                                                 FutureBuilder(
                                                                   future: Provider.of<UserProvider>(
                                                                     context,
                                                                   ).fetchUserAsFuture(e['userId']),
                                                                   builder: (context, ss) {
                                                                     if (ss.hasData) {
                                                                       return InkWell(
                                                                         borderRadius: BorderRadius.circular(20),
                                                                         onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfile(userId: e['userId']),)),
                                                                         child: Row(
                                                                           mainAxisAlignment: MainAxisAlignment.center,
                                                                           children: [
                                                                             CircleAvatar(backgroundImage: NetworkImage(ss.data['imageUrl'])),
                                                                             SizedBox(width: 8,),
                                                                             Text(ss.data['firstName']+ " "+ss.data['lastName'],style: TextStyle(color: Colors.white),),
                                                                           ],
                                                                         ),
                                                                       );
                                                                     }
                                                                     return CircularProgressIndicator();
                                                                   },
                                                                 ),
                                                                 SizedBox(height: 10,),
                                                                 Row(

                                                                   children: [
                                                                     Icon(
                                                                       Icons.phone,
                                                                       color: Colors.white,
                                                                       size: 20,
                                                                     ),
                                                                     Text(
                                                                       e['PhoneNo'],
                                                                       style: GoogleFonts.novaRound(
                                                                           fontSize: 15, color: Colors.white),
                                                                     ),
                                                                   ],
                                                                 ),
                                                                 SizedBox(height: 10,),
                                                                 Row(

                                                                   children: [
                                                                     Icon(
                                                                       Icons.location_on,
                                                                       color: Colors.white,
                                                                       size: 20,
                                                                     ),
                                                                     Text(
                                                                       e['Address'],
                                                                       style: GoogleFonts.novaRound(
                                                                           fontSize: 15, color: Colors.white),
                                                                     ),
                                                                   ],
                                                                 ),
                                                                 SizedBox(height: 10,),
                                                                 Row(

                                                                   children: [
                                                                     Row(
                                                                       children: [
                                                                         Icon(
                                                                           Icons.line_weight,
                                                                           color: Colors.white,
                                                                           size: 20,
                                                                         ),
                                                                         Text(
                                                                           " Weight : " + e['Weight'],
                                                                           style: GoogleFonts.novaRound(
                                                                               fontSize: 15, color: Colors.white),
                                                                         ),
                                                                       ],
                                                                     ),

                                                                   ],
                                                                 ),
                                                                 SizedBox(height: 10,),
                                                                 Row(

                                                                   children: [
                                                                     Icon(
                                                                       Icons.height,
                                                                       color: Colors.white,
                                                                       size: 20,
                                                                     ),
                                                                     Text(
                                                                       "Height : " +e['Length'],
                                                                       style: GoogleFonts.novaRound(
                                                                           fontSize: 15, color: Colors.white),
                                                                     ),
                                                                   ],
                                                                 ),
                                                                 SizedBox(height: 10,),
                                                                 Row(
                                                                   children: [

                                                                     Text(
                                                                       "Notes : " +e['Notes'],
                                                                       style: GoogleFonts.novaRound(
                                                                           fontSize: 15, color: Colors.white),
                                                                     ),
                                                                   ],
                                                                 ),

                                                                 Row(
                                                                   children: [


                                                                     IconButton(icon: Icon(Icons.clear,color: Colors.white,), onPressed: (){
                                                                       Provider.of<GymPlansProvider>(context,listen: false).changeSituationToRefused(e['GymPlanId'], e['userId']);
                                                                       GymPlanSubscriberData.removeWhere((element) => element['GymPlanId'] == e['GymPlanId']);
                                                                       Fluttertoast.showToast(
                                                                           msg: "Refused Succusfully",
                                                                           toastLength: Toast.LENGTH_SHORT,
                                                                           gravity: ToastGravity.CENTER,
                                                                           timeInSecForIosWeb: 3,
                                                                           backgroundColor: Colors.blueGrey,
                                                                           textColor: Colors.white,
                                                                           fontSize: 16.0);
                                                                       Navigator.of(context).pop();
                                                                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfile(userId: e['userId']),));
                                                                     })
                                                                   ],
                                                                   mainAxisAlignment: MainAxisAlignment.end,
                                                                 )

                                                               ],

                                                             ),
                                                           ),

                                                         ],
                                                       );
                                                     }).toList()),
                                               ))
                                         ],
                                       ),
                                     ));
                               },
                               child: Text("Subscribers"),
                               style: ButtonStyle(
                                   padding: MaterialStateProperty.all(
                                       EdgeInsets.only(left: 30, right: 30))),
                             );
                           }
                           return Center(child: CircularProgressIndicator());
                         },
                       ),
                     ],
                   )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  var SubscriberData = {
    'userId': '',
    'userDisplayName': '',
    'GymPlanId': '',
    'Situation': '',
    'Notes': '',
    'PhoneNo': '',
    'Address': '',
    'Length': '',
    'Weight': ''
  };

  _submitUpdate() async {
    try {
      Provider.of<GymPlansProvider>(context, listen: false)
          .FitInGymPlan(SubscriberData);

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
                              labelText: "Name",
                            ),
                            readOnly: true,
                            initialValue:
                                FirebaseAuth.instance.currentUser.displayName,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                            ),
                            onSaved: (newValue) {
                              SubscriberData['PhoneNo'] = newValue;
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
                              labelText: "Address",
                            ),
                            maxLines: 2,
                            onSaved: (newValue) {
                              SubscriberData['Address'] = newValue;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid Address";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Length",
                            ),
                            onSaved: (newValue) {
                              SubscriberData['Length'] = newValue;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid Length";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Weight",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Invalid Weight";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              SubscriberData['Weight'] = newValue;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Notes",
                            ),
                            maxLines: 3,
                            onSaved: (newValue) {
                              SubscriberData['Notes'] = newValue;
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
                              SubscriberData['userId'] =
                                  FirebaseAuth.instance.currentUser.uid;
                              SubscriberData['GymPlanId'] =
                                  widget.GymPlanData['GymPlanId'];
                              SubscriberData['Situation'] = "Pending";
                              SubscriberData['userDisplayName'] =
                                  FirebaseAuth.instance.currentUser.displayName;
                              _submitUpdate();
                            },
                            child: Text(
                              "Request",
                              style: GoogleFonts.novaRound(fontSize: 15),
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
