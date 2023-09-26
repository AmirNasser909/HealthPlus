import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdownfield/dropdownfield.dart';

import 'calc_inbody_adv.dart';

class InBodyInfo extends StatefulWidget {
  @override
  _InBodyInfoState createState() => _InBodyInfoState();
}

class _InBodyInfoState extends State<InBodyInfo> {
  final _formKey = GlobalKey<FormState>();
  final Color carbonBlack = Color(0xff1a1a1a);
  List<String> trueorfalse = ['Yes', 'No'];
  Map<String, dynamic> userInBodyInfo = {
    'Weight': 0.0,
    'Length': 0.0,
    'Pressure': '',
    'Diabetic': '',
    'Medicine': '',
    'gymplan': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 20, top: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.black12,
            image: DecorationImage(
              image: AssetImage("assets/images/SHA5BET.png"),
              fit: BoxFit.cover,
            )),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "In Body Info",
                          style: GoogleFonts.novaRound(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "we have not meant to save your data , once you click on submit and get result , the data will be totally cleanded",
                          style: GoogleFonts.novaRound(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Your Weight",
                              labelStyle: TextStyle(color: Colors.white)),
                          onSaved: (newValue) {
                            userInBodyInfo['Weight'] = double.parse(newValue.toString());
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Your Length In Meter",
                          ),
                          onSaved: (newValue) {
                            userInBodyInfo['Length'] = double.parse(newValue.toString());
                          },
                        ),
                        DropDownField(
                          value: userInBodyInfo['Pressure'],
                          setter: (newValue) =>
                              userInBodyInfo['Pressure'] = newValue,
                          labelText: 'Do you have pressure?',
                          items: trueorfalse,
                        ),
                        DropDownField(
                            labelText: "Do You Have diabetic?",
                            items: trueorfalse,
                            setter: (dynamic newValue) {
                              userInBodyInfo['Diabetic'] = newValue;
                            }),
                        DropDownField(
                            labelText: "Do you take any long-term medicine?",
                            items: trueorfalse,
                            setter: (dynamic newValue) {
                              userInBodyInfo['Medicine'] = newValue;
                            }),
                        DropDownField(
                            labelText: "Do you train or having gym-plan?",
                            items: trueorfalse,
                            setter: (dynamic newValue) {
                              userInBodyInfo['gymplan'] = newValue;
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(10),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(0, 18, 94, 1)),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.fromLTRB(
                              100,
                              5,
                              100,
                              5,
                            )),
                          ),
                          onPressed: () {
                            _formKey.currentState.save();
                            print(userInBodyInfo);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalcInBodyAdv(userInBodyInfo: userInBodyInfo,) ,));
                          },
                          child: Text(
                            "Submit",
                            style: GoogleFonts.novaRound(fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
