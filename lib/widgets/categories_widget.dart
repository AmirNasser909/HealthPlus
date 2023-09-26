import 'dart:ui';

import 'package:fitness_app/Models/category_model.dart';
import 'package:fitness_app/Providers/user_provider.dart';
import 'package:fitness_app/excersices_screens/exercises_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class CategoriesWidget {
  static List<Widget> categoriesWidget(List<Category> categories, BuildContext context) {
    return categories.map((categoryOfIndex) {
      return InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExercisesView(categoryTitle: categoryOfIndex.categoryName,categoryId:categoryOfIndex.categoryId ),));
        },
        child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.pink.shade50,
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(
                    0,
                    18,
                    94,
                    0.8,
                  ),
                  Color.fromRGBO(
                    0,
                    18,
                    94,
                    0.5,
                  ),
                ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
            child: ListView(
              shrinkWrap: true,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(categoryOfIndex.categoryImageLink),
                  radius: 100,
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(categoryOfIndex.categoryName,
                      style: GoogleFonts.novaRound(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20)),
                ),
                SizedBox(
                  height: 30,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.center,
                        color: Colors.black.withOpacity(0.2),
                        child: Text(
                          categoryOfIndex.categoryBio,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.novaRound(
                            color: Colors.white,
                            fontSize: 23,
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
                FutureBuilder(
                  future: Provider.of<UserProvider>(context, listen: false)
                      .checkUserType(FirebaseAuth.instance.currentUser.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data == "admin") {
                      return ElevatedButton(
                        child: Text(
                          "Edit!",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.only(left: 50, right: 50))),
                      );
                    }
                    return Container();
                  },
                )
              ],
            )),
      );
    }).toList();
  }
}
