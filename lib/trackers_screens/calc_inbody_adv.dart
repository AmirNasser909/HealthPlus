import 'package:fitness_app/DataSets/advices_dataset.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalcInBodyAdv extends StatefulWidget {
  final userInBodyInfo;

  const CalcInBodyAdv({@required this.userInBodyInfo});

  @override
  _CalcInBodyAdvState createState() => _CalcInBodyAdvState();
}

class _CalcInBodyAdvState extends State<CalcInBodyAdv> {
  String BMISituation = "Calculating";
  int BMIValue = 0;

  List<String> normalWeightAdvice = [];
  List<String> lossAdvice = [];
  List<String> obesityAdvice = [];

  void _calcTheIdenticalWeight() {
    double BMI;
    BMI = widget.userInBodyInfo['Weight'] /
        (widget.userInBodyInfo['Length'] * widget.userInBodyInfo['Length']);


    if (BMI < 15) {
      BMISituation = "Very Severe Weight Loss";
      BMIValue = -1;
    }
    else if (BMI >= 15 && BMI < 16) {
      BMISituation = "Severe Weight Loss";
      BMIValue = -1;
    }
    else if (BMI >= 16 && BMI < 18.5) {
      BMISituation = "Weight Loss";
      BMIValue = -1;
    }
    else if (BMI >= 18.5 && BMI < 25) {
      BMISituation = "Normal Weight";
      BMIValue = 0;
    }
    else if (BMI >= 25 && BMI < 30) {
      BMISituation = "Increase in Weight";
      BMIValue = 1;
    }
    else if (BMI >= 30 && BMI < 35) {
      BMISituation = "Obesity first degree";
      BMIValue = 1;
    }
    else if (BMI >= 35 && BMI < 40) {
      BMISituation = "Obesity second degree";
      BMIValue = 1;
    }
    else {
      BMISituation = "Very excessive obesity";
      BMIValue = 1;
    }
  }

   _buildAdvice (){
     Advices.DiabeticAdvices.shuffle();
     Advices.PressureAdvice.shuffle();
    if(BMIValue == 0){
      Advices.NormalWeightAdvice.shuffle();
      normalWeightAdvice = Advices.NormalWeightAdvice;
    }
    if(BMIValue == -1){
      Advices.LossAdvice.shuffle();
      lossAdvice = Advices.LossAdvice;
    }
    if(BMIValue == 1){
      Advices.ObesityAdvice.shuffle();
      obesityAdvice = Advices.ObesityAdvice;
    }


  }


  @override
  void initState() {
    _calcTheIdenticalWeight();
    _buildAdvice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 20, top: 50),
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
            color: Colors.black12,
            image: DecorationImage(
              image: AssetImage("assets/images/SHA5BET.png"),
              fit: BoxFit.cover,
            )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(radius: 50,
                          backgroundImage: NetworkImage(
                              'https://health.clevelandclinic.org/wp-content/uploads/sites/3/2019/09/gainLoseWeight-1137100432-770x553.jpg'),),
                        Column(
                          children: [
                            Text("Your BMI Refers To",
                              style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Text(BMISituation, style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ],
                    ),


                  ],
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.pink.shade50,
                    gradient: LinearGradient(
                        colors: [
                          Colors.teal,
                          Colors.blueGrey
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("SO YOU HAVE TO!",
                        style: GoogleFonts.novaRound(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),
                    if(BMIValue == 0)
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: normalWeightAdvice.take(6).map((e) => Text(e+'\n',style: TextStyle(fontSize: 16),)).toList()
                    ),
                    if(BMIValue == -1)
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: lossAdvice.take(6).map((e) => Text(e+'\n',style: TextStyle(fontSize: 16),)).toList()
                      ),
                    if(BMIValue == 1)
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: obesityAdvice.take(6).map((e) => Text(e+'\n',style: TextStyle(fontSize: 16),)).toList()
                      ),

                  ],
                ),
              ),
              if(widget.userInBodyInfo['Pressure'] == "Yes")
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.pink.shade50,
                    gradient: LinearGradient(
                        colors: [
                          Colors.red.withOpacity(0.6),
                          Colors.pink.withOpacity(0.6)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pressure Advices!",
                        style: GoogleFonts.novaRound(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),

                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: Advices.PressureAdvice.take(6).map((e) => Text(e+'\n',style: TextStyle(fontSize: 16),)).toList()
                      ),


                  ],
                ),
              ),
              if(widget.userInBodyInfo['Diabetic'] == "Yes")
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.pink.shade50,
                      gradient: LinearGradient(
                          colors: [
                            Colors.deepOrange.withOpacity(0.6),
                            Colors.orange.withOpacity(0.6)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Diabetic Advices!",
                          style: GoogleFonts.novaRound(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20)),
                      SizedBox(
                        height: 20,
                      ),

                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: Advices.DiabeticAdvices.take(6).map((e) => Text(e+'\n',style: TextStyle(fontSize: 16),)).toList()
                      ),


                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


