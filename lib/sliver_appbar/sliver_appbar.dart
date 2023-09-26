import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:another_flushbar/flushbar.dart';
class FitnessAppbar extends StatefulWidget {
  @override
  _FitnessAppbarState createState() => _FitnessAppbarState();
}

class _FitnessAppbarState extends State<FitnessAppbar> {

  @override
  Widget build(BuildContext context) {

    return SliverAppBar(
      collapsedHeight: MediaQuery.of(context).size.height * 20 / 100,
      flexibleSpace: Container(
        height: MediaQuery.of(context).size.height * 30 / 100,
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
        child: StreamBuilder<User>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(snapshot.hasData && snapshot.data.photoURL != null)
               CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data.photoURL),
                          radius: 50,
                    )else CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                if(snapshot.hasData && snapshot.data.displayName != null)
                Text(
                  snapshot.data.displayName,
                  style: GoogleFonts.novaRound(
                      fontSize: 20, color: Colors.white),
                ) else Padding(
                  padding: const EdgeInsets.fromLTRB(30,0,30,0),
                  child: LinearProgressIndicator(),
                ),
                 if(FirebaseAuth.instance.currentUser.emailVerified)
                 Flexible(
                   child: ElevatedButton(
                     style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black26),),
                     onPressed: (){
                       FirebaseAuth.instance.currentUser.sendEmailVerification();

                     return Flushbar(
                       title: "Mail Verification",
                       titleColor: Colors.white,
                       message: "Kindly! Check your email address , we have sent a verification message to you!",
                       flushbarPosition: FlushbarPosition.TOP,
                       flushbarStyle: FlushbarStyle.FLOATING,
                       reverseAnimationCurve: Curves.decelerate,
                       forwardAnimationCurve: Curves.elasticOut,
                       backgroundColor: Colors.red,
                       boxShadows: [BoxShadow(color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0)],
                       backgroundGradient: LinearGradient(colors: [Colors.blueGrey, Colors.black26]),
                       isDismissible: false,
                       duration: Duration(seconds: 4),
                       icon: Icon(
                         Icons.check,
                         color: Colors.greenAccent,
                       ),
                       mainButton: FlatButton(
                         onPressed: () {
                           Navigator.of(this.context).pop();
                         },
                         child: Text(
                           "Got It!",
                           style: TextStyle(color: Colors.amber),
                         ),
                       ),
                       showProgressIndicator: true,
                       progressIndicatorBackgroundColor: Colors.blueGrey,
                       titleText: Text(
                         "Verification Message Sent!",
                         style: TextStyle(
                             fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.yellow[600], fontFamily: "ShadowsIntoLightTwo"),
                       ),
                       messageText: Text(
                         "Kindly! Check your email address , we have sent a verification message to you!",
                         style: TextStyle(fontSize: 18.0, color: Colors.green, fontFamily: "ShadowsIntoLightTwo"),
                       ),
                     )..show(context);
                   },child: Text("Please, Your Email Needs Verification, Click Here !",style: GoogleFonts.novaRound(color: CupertinoColors.white),),),
                 )
              ],
            );
          }
        ),
      ),
      actions: [
        IconButton(icon: Icon(Icons.logout,), onPressed: ()async{
          await GoogleSignIn().signOut().then((_) async{
            await FirebaseAuth.instance.signOut();
          });

        }),
      ],
    );
  }
}
