import 'package:fitness_app/Models/category_model.dart';
import 'package:fitness_app/Providers/admin_Provider.dart';
import 'package:flutter/material.dart';
import 'categories_widget.dart' as globals;
import 'package:provider/provider.dart';
class ExercisesHerozintalView extends StatefulWidget {
  @override
  _ExercisesHerozintalViewState createState() => _ExercisesHerozintalViewState();
}

class _ExercisesHerozintalViewState extends State<ExercisesHerozintalView> {
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
          return SingleChildScrollView(
            child: Column(
              children: globals.CategoriesWidget.categoriesWidget(cats,context).map((item) {
                 return Container(
                   padding: EdgeInsets.all(20),
                   child: item,
                 );
              }).toList(),
            ),
          );
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
