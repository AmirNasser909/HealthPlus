import 'package:fitness_app/Providers/gym_plans_provider.dart';
import 'package:fitness_app/Providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
class RequestedCoaches extends StatefulWidget {
  @override
  _RequestedCoachesState createState() => _RequestedCoachesState();
}

class _RequestedCoachesState extends State<RequestedCoaches> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Requested Coaches"),
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
        child: FutureBuilder(
          future: Provider.of<GymPlansProvider>(context,listen: false).fetchRequestedCoachesData(),
          builder: (context, snapshot) {
            var RequestedCoachesData =[];
            if(snapshot.hasData){
              snapshot.data.docs.forEach((e){
                RequestedCoachesData.add({
                  'CoachId': e['CoachId'],
                  'CoachName':e['CoachName'],
                  'CoachImageUrl' :e['CoachImageUrl'],
                  'CoachBio': e['CoachBio'],
                  'CoachGymName': e['CoachGymName'],
                  'CoachGymAddress':e['CoachGymAddress'],
                  'CoachExperienceYears': e['CoachExperienceYears'],
                  'CoachSSN': e['CoachSSN'],
                  'CoachSSNImageUrl' : e['CoachSSNImageUrl'],
                  'CoachPhoneNo': e['CoachPhoneNo'],
                  'CoachWeight': e['CoachWeight'],
                  'CoachWork': e['CoachWork'],
                });
              });
              return SingleChildScrollView(
                child: Column(
                  children: RequestedCoachesData.map((Request) {
                    return Container(
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
                          CircleAvatar(
                            radius: MediaQuery.of(context).size.height * 6 / 100,
                            backgroundImage:
                            NetworkImage(Request['CoachImageUrl']),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                       Request['CoachName'],
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
                                        Request['CoachBio'],
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
                                            'Gym '+ Request['CoachGymName'],
                                            style: GoogleFonts.novaRound(
                                                fontSize: 20, color: Colors.white),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.monetization_on_outlined,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      Text(
                                        "Address " +Request['CoachGymAddress'],
                                        style: GoogleFonts.novaRound(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
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
                                "Coach Work",
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
                                Request['CoachWork'],
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
                                "Coach Phone",
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
                                Request['CoachPhoneNo'],
                                style: GoogleFonts.novaRound(
                                    fontSize: 20, color: Colors.white),
                              )),
                          Divider(
                            thickness: 1,
                            color: Colors.white,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.merge_type,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  Text(
                                    "Experience :"+Request['CoachExperienceYears'],
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
                          Row(
                            children: [
                              Icon(
                                Icons.merge_type,
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                "SSN :"+Request['CoachSSN'],
                                style: GoogleFonts.novaRound(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],

                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            height: 400,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect( borderRadius: BorderRadius.circular(20),child: Image.network(Request['CoachSSNImageUrl'],)),
                          ),
                          SizedBox(height: 10,),
                          ElevatedButton.icon(onPressed: (){
                            Provider.of<UserProvider>(context,listen: false).updateUserType(Request['CoachId'], "Coach");
                            Provider.of<GymPlansProvider>(context,listen: false).deleteApprovedUsers(Request['CoachId']);
                            Navigator.of(context).pop();

                          }, icon: Icon(Icons.touch_app_rounded), label: Text("Accept Coach"))
                        ],
                      ),
                    );
                  } ).toList(),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),

      ),
    );
  }
}
