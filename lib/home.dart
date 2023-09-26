import 'dart:ui';

import 'package:fitness_app/Providers/admin_Provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_slider/image_slider.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:provider/provider.dart';
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  var tabController;
  List<String> linksOfImages = [
    "https://www.lifefitnessemea.com/resource/image/823366/portrait_ratio1x1/600/600/d7dfae1242ae38425be3d8cbc420dd89/IQ/axiom-series.jpg",
    "https://www.lifefitnessemea.com/resource/image/829220/landscape_ratio4x3/768/576/71de02193cefe2fab86cddfc30a18501/oh/lifefitness-016.jpg",
    "https://top10cairo.com/wp-content/uploads/2015/12/powerhouse-gym.jpg",
  ];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.black12,
            image: DecorationImage(
              image: AssetImage("assets/images/SHA5BET.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 20 / 100,
                  width: MediaQuery.of(context).size.width * 95 / 100,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://ak.picdn.net/shutterstock/videos/1059480710/thumb/8.jpg",
                      ),
                    ),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.black.withOpacity(0.1),
                          child: FutureBuilder(
                            future: Provider.of<AdminProvider>(context,listen:false).fetchAppWelcomingData(),
                            builder:(context, snapshot) {
                              if(snapshot.hasData&& snapshot.data['AppWelcomingMessage'] != "")
                                {
                                  return Text(
                                    snapshot.data['AppWelcomingMessage'],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.novaRound(
                                      color: Colors.white,
                                      fontSize: 23,
                                    ),
                                  );
                                }
                             return Text(
                                "The Clock is ticking. Are you becoming the person who you want to be?",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.novaRound(
                                  color: Colors.white,
                                  fontSize: 23,
                                ),
                              );
                            }
                          ),
                        ),
                      ))),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                width: MediaQuery.of(context).size.width * 95 / 100,
                height: MediaQuery.of(context).size.height * 45 / 100,
                child: Column(
                  children: [
                    buildRowOfUserData(
                        Icons.fastfood,
                        "Food",
                        "2000 / 2500 fats consumed",
                        CircularProgressIndicator(
                          backgroundColor: Color.fromRGBO(95, 0, 27, .8),
                          value: .4,
                          strokeWidth: 8,
                        )),
                    buildRowOfUserData(
                        Icons.waterfall_chart,
                        "Water",
                        "8 / 16 cubs consumed",
                        CircularProgressIndicator(
                          backgroundColor: Color.fromRGBO(95, 0, 27, .8),
                          value: .2,
                          strokeWidth: 8,
                        )),
                    buildRowOfUserData(
                        Icons.bedtime,
                        "Sleep",
                        "8 / 8 hours slept",
                        CircularProgressIndicator(
                          backgroundColor: Color.fromRGBO(95, 0, 27, .8),
                          value: .4,
                          strokeWidth: 8,
                        )),
                    buildRowOfUserData(
                        Icons.online_prediction_sharp,
                        "Activity",
                        "3 hours of using app",
                        CircularProgressIndicator(
                          backgroundColor: Color.fromRGBO(95, 0, 27, .8),
                          value: 0.9,
                          strokeWidth: 8,
                        )),
                  ],
                ),
              ),
              FutureBuilder(
                future: Provider.of<AdminProvider>(context,listen: false).fetchAppWelcomingData(),
                builder:(context, snapshot) {
                  if(snapshot.hasData) {
                  
                      linksOfImages = [
                        snapshot.data['FirstImageLink'],
                        snapshot.data['SecondImageLink'],
                        snapshot.data['ThirdImageLink'],
                      ];

                    return ImageSlider(
                      showTabIndicator: true,
                      tabIndicatorColor: Colors.white,
                      tabIndicatorSelectedColor: Color.fromRGBO(95, 0, 27, 1),
                      tabIndicatorHeight: 10,
                      tabIndicatorSize: 10,
                      tabController: tabController,
                      curve: Curves.fastOutSlowIn,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 95 / 100,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 25 / 100,
                      autoSlide: true,
                      duration: new Duration(seconds: 2),
                      allowManualSlide: true,
                      children: linksOfImages.map((String link) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              link,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              fit: BoxFit.cover,
                            ));
                      }).toList(),
                    );
                }
                  return CircularProgressIndicator();
                }
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildRowOfUserData(
    IconData icon,
    String upperText,
    String bottomText,
    Widget Indicator,
  ) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      height: (MediaQuery.of(context).size.height * 45 / 100) * 15 / 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color.fromRGBO(95, 0, 27, 1),
          )),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            Container(
              width: MediaQuery.of(context).size.width * 50 / 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(upperText),
                  Flexible(child: Text(bottomText)),
                ],
              ),
            ),
            Indicator,
            Icon(Icons.add)
          ],
        ),
      ),
    );
  }
}
