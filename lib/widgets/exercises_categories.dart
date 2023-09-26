import 'dart:ui';

import 'package:fitness_app/Models/category_model.dart';
import 'package:fitness_app/Providers/admin_Provider.dart';
import 'package:fitness_app/excersices_screens/exercises_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'categories_widget.dart' as globals;
class ExercisesSliderView extends StatefulWidget {
  final double heightInteger;

  const ExercisesSliderView({@required this.heightInteger});


  @override
  _ExercisesSliderViewState createState() => _ExercisesSliderViewState();
}

class _ExercisesSliderViewState extends State<ExercisesSliderView> {
  @override
  Widget build(BuildContext context) {


    return  FutureBuilder(
      future: Provider.of<AdminProvider>(context).fetchCategoriesData(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          Category category;
          List<Category> cats = [];
          snapshot.data.docs.forEach((doc){
            category = Category.fromDocument(doc);
            cats.add(category);
          });


          return CarouselSlider(
            options: CarouselOptions(height: MediaQuery
                .of(context)
                .size
                .height * widget.heightInteger/ 100,
                enlargeCenterPage: true),
            items: globals.CategoriesWidget.categoriesWidget(cats,context).map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,

                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: i,
                  );
                },
              );
            }).toList(),
          );
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
