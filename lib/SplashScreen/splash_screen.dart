import 'package:fitness_app/Registration/auth_screen.dart';
import 'package:fitness_app/tabs_screen/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.black12,
      seconds: 4,
      useLoader: true,
      imageBackground: AssetImage("assets/images/SHA5BET.png"),
      image: Image.asset("assets/images/LOGO_COLORED.png"),
      photoSize: (MediaQuery.of(context).size.height+MediaQuery.of(context).size.width)*20/100,
      loadingText: Text("A New Way To Build Your Body",style: TextStyle(color: Color.fromRGBO(0, 18, 94, 1)),),
      loaderColor: Color.fromRGBO(0, 18, 94, 1),
      navigateAfterSeconds: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return TabsView();
          }
          return RegistrationView();
        },
      ),
    );
  }
}
