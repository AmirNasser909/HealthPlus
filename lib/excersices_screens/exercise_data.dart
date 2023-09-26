import 'package:fitness_app/Models/excersices_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
class ExerciseDataView extends StatefulWidget {
  final Exercise exercise;

  ExerciseDataView({@required this.exercise});


  @override
  _ExerciseDataViewState createState() => _ExerciseDataViewState();
}

class _ExerciseDataViewState extends State<ExerciseDataView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(widget.exercise.ExName),
            centerTitle: true,
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
          SliverList(
              delegate: SliverChildListDelegate([
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                    //  borderRadius: BorderRadius.only(bottomRight: Radius.circular(40),bottomLeft: Radius.circular(40) ),
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Builder(
                            builder:(context) {
                              try {
                                String videoID= YoutubePlayer.convertUrlToId(widget.exercise.ExVideoLink);
                                return YoutubePlayer(
                                  controller: YoutubePlayerController(
                                    initialVideoId: videoID, //Add videoID.
                                    flags: YoutubePlayerFlags(
                                      hideControls: false,
                                      controlsVisibleAtStart: true,
                                      autoPlay: false,
                                      mute: false,

                                    ),
                                  ),
                                  showVideoProgressIndicator: true,
                                );
                              } on Exception catch (exception) {
                                print(exception);

                              } catch (error) {
                                print(error);
                              }
                              return Center(child: LinearProgressIndicator(),);

                            },
                          ),
                          Container(
                            padding: EdgeInsets.all(30),
                            width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(40),bottomLeft: Radius.circular(40) ),
                                color: Colors.white.withOpacity(0.1),
                              ),
                            child: Column(
                              children: [
                                Text(widget.exercise.ExBio,style: GoogleFonts.novaRound(color: Colors.white,fontSize: 25),),
                              ],
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.all(30),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),

                            ),
                            child: Column(

                              children: [
                                Text( "STEPS",style: GoogleFonts.novaRound(color: Colors.teal,fontSize: 50),),
                                Text( widget.exercise.ExSteps,style: GoogleFonts.novaRound(color: Colors.white,fontSize: 20),),
                              ],
                            ),
                          ),



                        ],
                      ),
                    ),
                  ),
              ],),),
        ],
      ),

    );
  }
}
