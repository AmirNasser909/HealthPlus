import 'package:fitness_app/Models/category_model.dart';
import 'package:fitness_app/Models/excersices_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/Providers/admin_Provider.dart';

class AddExerciseView extends StatefulWidget {
  final String categoryId;

  const AddExerciseView({@required this.categoryId}) ;

  @override
  _AddExerciseViewState createState() => _AddExerciseViewState();
}

class _AddExerciseViewState extends State<AddExerciseView> {
  GlobalKey<FormState> _formKey = GlobalKey();
  var _exerciseData = {
    'ExName' : '',
    'ExBio' :'',
    'ExSteps':'',
    'ExImageLink' :'',
    'ExVideoLink':'',
  };



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Exercise"),
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
      body: SingleChildScrollView(
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
                      "Add New Exercise To App",
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
                        _exerciseData[
                        'ExName'] = newValue;
                      },
                    ),
                    TextFormField(
                      maxLines: 2,
                      decoration: InputDecoration(
                          labelText: "Exercise Bio"
                      ),
                      onSaved: (newValue) {
                        _exerciseData[
                        'ExBio'] = newValue;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Cannot Be Empty Bio!";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      maxLines: 2,
                      decoration: InputDecoration(
                          labelText: "Exercise Image Link"
                      ),
                      onSaved: (newValue) {
                        _exerciseData[
                        'ExImageLink'] = newValue;
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
                          labelText: "Exercise Video Link"
                      ),
                      onSaved: (newValue) {
                        _exerciseData[
                        'ExVideoLink'] = newValue;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Cannot Be Empty Link!";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                          labelText: "Exercise Steps"
                      ),
                      onSaved: (newValue) {
                        _exerciseData[
                        'ExSteps'] = newValue;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Cannot Be Empty Steps!";
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
      ) ,
    );
  }

  void _submitAddCategory() {
    Exercise exercise = Exercise(ExName: _exerciseData['ExName'],ExBio:_exerciseData['ExBio']
      ,ExImageLink:_exerciseData['ExImageLink'] ,ExVideoLink:_exerciseData['ExVideoLink'] ,ExSteps:_exerciseData['ExSteps'] ,);
    Provider.of<AdminProvider>(context,listen: false).addExerciseToCategory(exercise, widget.categoryId);
  }
}
