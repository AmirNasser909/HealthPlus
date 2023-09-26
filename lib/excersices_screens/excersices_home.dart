import 'package:fitness_app/Providers/user_provider.dart';
import 'package:fitness_app/admin_dashboard/admin_add.dart';
import 'package:fitness_app/widgets/ExercisesHerozintalView.dart';
import 'package:fitness_app/widgets/exercises_categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_slider/image_slider.dart';
import 'package:provider/provider.dart';
class ExersicesHome extends StatefulWidget {

  bool verticalView;

  ExersicesHome({@required this.verticalView});


  @override
  _ExersicesHomeState createState() => _ExersicesHomeState();
}

class _ExersicesHomeState extends State<ExersicesHome>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercises Dashboard",style: GoogleFonts.novaRound(fontSize: 20),),
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
        actions: [
          IconButton(icon: widget.verticalView? Icon(Icons.view_agenda,): Icon(Icons.view_array_outlined), onPressed: (){
            setState(() {
              widget.verticalView = !widget.verticalView;
            });
          }),
         /* if(FirebaseAuth.instance.currentUser.photoURL != null)*/
          // CircleAvatar(backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser.photoURL,),radius: 18,),
          SizedBox(width:5,),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 20,top: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.black12,
            image: DecorationImage(
              image: AssetImage("assets/images/SHA5BET.png"),
              fit: BoxFit.cover,
            )),
        child: ListView(
          shrinkWrap: false,
          children: [
            FutureBuilder(
              future: Provider.of<UserProvider>(context,listen: false).checkUserType(FirebaseAuth.instance.currentUser.uid),
              builder: (context, snapshot) {
                if(snapshot.hasData)
                {
                  if(snapshot.data =="Admin"){
                    return Center(child: Text("You Are Navigating As Admin!\n"));
                  }
                  else{
                    return Center(child: Text("Welcome To Exercises! \n"),);
                  }
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(),
                );
              },
            ),
             widget.verticalView?
            ExercisesSliderView(heightInteger: 40,):
            ExercisesHerozintalView(),
          ],
        ),
      ),
      floatingActionButton: FutureBuilder(
        future: Provider.of<UserProvider>(context,listen: false).checkUserType(FirebaseAuth.instance.currentUser.uid),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data == "Admin")
            {
              return FloatingActionButton.extended(onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> AdminDBAddView()));
                }, label: Text("Admin Dashboard"), icon: Icon(Icons.add),backgroundColor:  Color.fromRGBO(95, 0, 27, .8),);
            }
          return Container();
        },
      )
    );
  }

}
