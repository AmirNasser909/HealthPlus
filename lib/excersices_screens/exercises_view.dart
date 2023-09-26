import 'package:fitness_app/Models/excersices_model.dart';
import 'package:fitness_app/Providers/admin_Provider.dart';
import 'package:fitness_app/Providers/user_provider.dart';
import 'package:fitness_app/admin_dashboard/admin_add.dart';
import 'package:fitness_app/excersices_screens/exercise_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../admin_dashboard/add_excersice.dart';

class ExercisesView extends StatefulWidget {
  final String categoryId;
  final String categoryTitle;

  const ExercisesView(
      {@required this.categoryId, @required this.categoryTitle});

  @override
  _ExercisesViewState createState() => _ExercisesViewState();
}

class _ExercisesViewState extends State<ExercisesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryTitle),
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
            future: Provider.of<AdminProvider>(context)
                .fetchExercises(widget.categoryId),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                Exercise exercise;
                List<Exercise> exsc = [];
                snapshot.data.docs.forEach((doc) {
                  exercise = Exercise.fromDocument(doc);
                  exsc.add(exercise);
                });
                return SingleChildScrollView(
                  child: Column(
                    children: exsc.map((ex){
                      return Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 25 /100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            colorFilter: ColorFilter.srgbToLinearGamma(),
                            image: NetworkImage(ex.ExImageLink),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ex.ExName,style : GoogleFonts.novaRound(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)),
                            Text(ex.ExBio,style : GoogleFonts.novaRound(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white)),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExerciseDataView(exercise: ex,),));
                                },
                                child: Text("TRY!",style: TextStyle(color: Colors.black),
                              ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.4)),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              }
              return Center(child: CircularProgressIndicator(),);
            },
          ),
        ),
        floatingActionButton: FutureBuilder(
          future: Provider.of<UserProvider>(context,listen: false).checkUserType(FirebaseAuth.instance.currentUser.uid),
          builder: (context, snapshot) {
            if(snapshot.hasData && snapshot.data == "Admin")
            {
              return FloatingActionButton.extended(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=> AddExerciseView(categoryId: widget.categoryId,)));
              }, label: Text("Add Exercise"), icon: Icon(Icons.add),backgroundColor:  Color.fromRGBO(95, 0, 27, .8),);
            }
            return Container();
          },
        )
    );
  }
}
