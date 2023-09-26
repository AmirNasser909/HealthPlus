import 'package:fitness_app/Models/message_model.dart';
import 'package:fitness_app/Models/user_model.dart';
import 'package:fitness_app/Providers/chats_provider.dart';
import 'package:fitness_app/Providers/user_provider.dart';
import 'package:fitness_app/messenger_dashboard/chat.dart';
import 'package:fitness_app/profile_screens/show_friends.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:google_fonts/google_fonts.dart';
class MessengerHome extends StatefulWidget {
  @override
  _MessengerHomeState createState() => _MessengerHomeState();
}

class _MessengerHomeState extends State<MessengerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats In Fitness"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(95, 0, 27, .7),
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
        child: Column(
          children: [
            SizedBox(height: 10,),
            BubbleNormal(
              isSender: false,
              text: "People You Connected With",
              color: Color(0xFFE8E8EE),
              tail: false,

            ),
            StreamBuilder(
              stream: Provider.of<ChatProvider>(context,listen: false).fetchAllConnections(FirebaseAuth.instance.currentUser.uid,),
              builder: (context, snapshot) {
                List<String> ids= [];
                if(snapshot.hasData){
                  snapshot.data.docs.forEach((element){
                      ids.add(element.id);
                  });

                  return SingleChildScrollView(
                    child: Column(
                      children: ids.map((e) {
                        print(e.toString());
                        return StreamBuilder(
                          stream: Provider.of<UserProvider>(context,listen: false).fetchUser(e.toString()),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              return InkWell(
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Chat(UID:snapshot.data['userId'] ,DisplayName: snapshot.data['firstName'] +" " + snapshot.data['lastName'],ImageUrl: snapshot.data['imageUrl'],UserBio: snapshot.data['bio'], ),)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                    ),
                  );
                }
                else
                  return Center(child: CircularProgressIndicator());

              }
            ),
          ],
        ),
      ),
       floatingActionButton: FloatingActionButton.extended(onPressed: (){
         Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowFriends(showType: "Following",)));

       }, label: Text("Start Chat!"),icon: Icon(Icons.message),),
    );
  }
}
