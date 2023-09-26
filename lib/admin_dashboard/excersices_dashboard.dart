import 'dart:ui';

import 'package:fitness_app/Models/category_model.dart';
import 'package:fitness_app/Providers/admin_Provider.dart';
import 'package:fitness_app/widgets/exercises_categories.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
class Exercisesdashboard extends StatefulWidget {
  @override
  _ExercisesdashboardState createState() => _ExercisesdashboardState();
}

class _ExercisesdashboardState extends State<Exercisesdashboard> {

  var _categoryData = {
    'categoryName' : '',
    'categoryImageLink' :'',
    'categoryBio':'',
  };



  GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Exercises Dashboard"),
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
        child: ExercisesSliderView(heightInteger: 70,),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showDialog("AddCategory");
        },
        label: Text("Add Category"),icon: Icon(Icons.add_box),
      ),
    );
  }




  void showDialog(String TypeOfDialog) {
    if (TypeOfDialog == "AddCategory") {
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
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 70 / 100,
              child: SizedBox.expand(
                  child: Center(
                      child: SingleChildScrollView(
                        child: Column(

                          children: [
                          Card(
                          shadowColor: Color.fromRGBO(0, 18, 94, 1),
                          margin: EdgeInsets.all(40),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Text(
                                  "Add New Category To App",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  maxLength: 70,
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    labelText: "Category Name"
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Cannot Be Empty Name!";
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    _categoryData[
                                    'categoryName'] = newValue;
                                  },
                                ),
                                TextFormField(
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    labelText: "Category Image Link"
                                  ),
                                  onSaved: (newValue) {
                                    _categoryData[
                                    'categoryImageLink'] = newValue;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Cannot Be Empty Link!";
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    labelText: "Category Bio"
                                  ),
                                  onSaved: (newValue) {
                                    _categoryData[
                                    'categoryBio'] = newValue;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Cannot Be Empty Bio!";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 30,),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    elevation:
                                    MaterialStateProperty.all(10),
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        Color.fromRGBO(0, 18, 94, 1)),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.fromLTRB(
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
                                      _submitAddCategory();
                                      Navigator.of(context).pop();
                                      setState(() {});
                                    }
                                  },
                                  child: Text(
                                    "Add",
                                    style:
                                    GoogleFonts.novaRound(fontSize: 25),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                          ],
                        ),
                      )
                  )),
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
            position:
            Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
            child: child,
          );
        },
      );
    }
    if(TypeOfDialog=="EditCategory")
      {
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
                padding: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * 70 / 100,
                child: SizedBox.expand(
                    child: Center(
                        child: SingleChildScrollView(
                          child: Column(

                            children: [
                              Card(
                                shadowColor: Color.fromRGBO(0, 18, 94, 1),
                                margin: EdgeInsets.all(40),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Edit Category",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10,),
                                      TextFormField(
                                        maxLength: 70,
                                        maxLines: 2,
                                        decoration: InputDecoration(
                                            labelText: "Category Name"
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Cannot Be Empty Name!";
                                          }
                                          return null;
                                        },
                                        onSaved: (newValue) {
                                          _categoryData[
                                          'categoryName'] = newValue;
                                        },
                                      ),
                                      TextFormField(
                                        maxLines: 2,
                                        decoration: InputDecoration(
                                            labelText: "Category Image Link"
                                        ),
                                        onSaved: (newValue) {
                                          _categoryData[
                                          'categoryImageLink'] = newValue;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Cannot Be Empty Link!";
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        maxLines: 2,
                                        decoration: InputDecoration(
                                            labelText: "Category Bio"
                                        ),
                                        onSaved: (newValue) {
                                          _categoryData[
                                          'categoryBio'] = newValue;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Cannot Be Empty Bio!";
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 30,),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          elevation:
                                          MaterialStateProperty.all(10),
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              Color.fromRGBO(0, 18, 94, 1)),
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.fromLTRB(
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
                                            _submitAddCategory();
                                            Navigator.of(context).pop();
                                            setState(() {});
                                          }
                                        },
                                        child: Text(
                                          "Add",
                                          style:
                                          GoogleFonts.novaRound(fontSize: 25),
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
              position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
              child: child,
            );
          },
        );
      }

  }




  void _submitAddCategory() {
   Provider.of<AdminProvider>(context,listen: false).addNewCategory(Category(categoryName: _categoryData['categoryName'], categoryImageLink: _categoryData['categoryImageLink'], categoryBio: _categoryData['categoryBio']));
  }
}
