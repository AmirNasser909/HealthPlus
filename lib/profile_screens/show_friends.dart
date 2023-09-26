import 'package:fitness_app/Providers/user_provider.dart';
import 'package:fitness_app/messenger_dashboard/chat.dart';
import 'package:fitness_app/profile_screens/profile.dart';
import 'package:fitness_app/profile_screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
class ShowFriends extends StatefulWidget {
  final showType;

  const ShowFriends({@required this.showType}) ;

  @override
  _ShowFriendsState createState() => _ShowFriendsState();
}

class _ShowFriendsState extends State<ShowFriends> {
  @override
  Widget build(BuildContext context) {
    if(widget.showType == "Following")
    return Scaffold(
      appBar:AppBar(
        title: Text("Following"),
        flexibleSpace: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/SHA5BET.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken)),
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
        child: FutureBuilder(
          future: Provider.of<UserProvider>(context,listen:false).checkFollowing(FirebaseAuth.instance.currentUser.uid),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              List<String> ids = [];
              snapshot.data.docs.forEach((following){
                ids.add(following.id);
              });

              return Column(
                children: ids.map((e) {
                  print(e.toString());
                  return StreamBuilder(
                    stream: Provider.of<UserProvider>(context,listen: false).fetchUser(e.toString()),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return InkWell(
                          onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserProfile(userId: e.toString()) )),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot.data['imageUrl']),
                                  radius: 30,
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Text(snapshot.data['firstName'].toString() +" "+snapshot.data['lastName'].toString(),style: GoogleFonts.novaRound(fontSize: 16),),
                                    Text(snapshot.data['bio'],style: GoogleFonts.novaRound(fontSize: 13),),
                                  ],
                                  crossAxisAlignment:CrossAxisAlignment.start ,
                                ),

                              ],
                            ),
                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator());


                    },
                  );
                }).toList(),
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
    if(widget.showType == "Followers")
      return Scaffold(
        appBar:AppBar(
          title: Text("Followers"),
          flexibleSpace: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/SHA5BET.png"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken)),
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
          child: FutureBuilder(
            future: Provider.of<UserProvider>(context,listen:false).checkFollowers(FirebaseAuth.instance.currentUser.uid),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                List<String> ids = [];
                snapshot.data.docs.forEach((following){
                  ids.add(following.id);
                });

                return Column(
                  children: ids.map((e) {
                    print(e.toString());
                    return StreamBuilder(
                      stream: Provider.of<UserProvider>(context,listen: false).fetchUser(e.toString()),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          return InkWell(
                            onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserProfile(userId: e.toString()) )),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(snapshot.data['imageUrl']),
                                    radius: 30,
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    children: [
                                      Text(snapshot.data['firstName'].toString() +" "+snapshot.data['lastName'].toString(),style: GoogleFonts.novaRound(fontSize: 16),),
                                      Text(snapshot.data['bio'],style: GoogleFonts.novaRound(fontSize: 13),),
                                    ],
                                    crossAxisAlignment:CrossAxisAlignment.start ,
                                  ),

                                ],
                              ),
                            ),
                          );
                        }
                        return Center(child: CircularProgressIndicator());


                      },
                    );
                  }).toList(),
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      );
  }
}
