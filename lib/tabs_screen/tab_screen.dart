import 'package:fitness_app/Providers/post_provider.dart';
import 'package:fitness_app/calories_screen/calories_detector.dart';
import 'package:fitness_app/calories_screen/calories_detector_widget.dart';
import 'package:fitness_app/drawer/app_drawer.dart';
import 'package:fitness_app/excersices_screens/excersices_home.dart';
import 'package:fitness_app/home.dart';
import 'package:fitness_app/profile_screens/profile.dart';
import 'package:fitness_app/sliver_appbar/sliver_appbar.dart';
import 'package:fitness_app/timeline/add_post.dart';
import 'package:fitness_app/trackers_screens/tracker_home.dart';
import 'package:fitness_app/widgets/timeline_builder.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TabsView extends StatefulWidget {
  @override
  _TabsViewState createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  List<Map<String, Widget>> Views= [];

  @override
  void initState() {
    Views = [
      {
        'page': HomeView(),
      },
      {
        'page': CaloriesDetectorWidget(),
      },
      {
        'page': TimelineBuilder(future: Provider.of<PostProvider>(context,listen: false).fetchPostsData(),),
      },
    ];
    super.initState();
  }

  int index = 0;

  SelectPage(int i) {
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            FitnessAppbar(), //SliverAppBar
            SliverList(
                delegate: SliverChildListDelegate([
                  Views[index]['page'],
            ]))
          ],
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 6/ 100,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/SHA5BET.png")),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(0, 18, 94, .9),
                    Color.fromRGBO(95, 0, 27, .8),
                  ])),
          child: BottomNavigationBar(
            backgroundColor: Colors.white.withOpacity(0),
            iconSize: 20,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            currentIndex: index,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            onTap: SelectPage,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant),
                label: "Callories",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: "Profile",
              ),

            ],
          ),
        ),

        drawer: AppDrawer());
  }
}
