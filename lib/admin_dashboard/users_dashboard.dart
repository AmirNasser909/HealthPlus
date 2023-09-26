import 'package:fitness_app/Models/user_model.dart';
import 'package:fitness_app/Providers/post_provider.dart';
import 'package:fitness_app/Providers/user_provider.dart';
import 'package:fitness_app/profile_screens/profile.dart';
import 'package:fitness_app/profile_screens/user_profile.dart';
import 'package:fitness_app/widgets/timeline_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UsersDashboard extends StatefulWidget {
  @override
  _UsersDashboardState createState() => _UsersDashboardState();
}

class _UsersDashboardState extends State<UsersDashboard> {
  SearchBar searchBar;

  _UsersDashboardState() {
    searchBar = new SearchBar(
        hintText: "Search for people",
        showClearButton: true,
        inBar: false,
        setState: setState,
        onSubmitted: (value) async {
          people = [];
          var snapshot =
          await Provider.of<UserProvider>(context,listen: false).searchUser(value);
          userInfo user;
          snapshot.docs.forEach(
                (doc) {
              user = userInfo.fromDocument(doc);
              if(user.firstName.contains(value) || user.lastName.contains(value)) {
                people.add(user);
              }
            },
          );
          setState(() {
          });
        },
        buildDefaultAppBar: buildAppBar);

  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      flexibleSpace: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/SHA5BET.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 18, 94, 1),
                Color.fromRGBO(95, 0, 27, 1),
              ]),
        ),
      ),
      actions: [
        searchBar.getSearchAction(context),
        IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ProfileView(),
              ));
            })
      ],
    );
  }

  List<userInfo> people = [];

  @override
  Widget build(BuildContext context) {
    print(people.length);
    return Scaffold(
        appBar: searchBar.build(context),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.black12,
            image: DecorationImage(
              image: AssetImage("assets/images/SHA5BET.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
                children: people.map((user) {
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfile(
                        userId: user.userId,
                      ),));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(backgroundImage: NetworkImage(user.imageUrl),radius: 60,),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.firstName + " "+user.lastName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                Text(user.bio,style: TextStyle(fontSize: 13),),
                                Text(user.userType,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                Row(
                                  children: [
                                    if(user.verified != "true")
                                    ElevatedButton.icon(onPressed: (){
                                      Provider.of<UserProvider>(context,listen: false).verifyUser(user.userId);
                                      Fluttertoast.showToast(
                                          msg: "User Verified Successfully!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: Colors.blueGrey,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      Navigator.of(context).pop();
                                    },icon: Icon(Icons.verified) ,label: Text("Verify"))
                                    else
                                      ElevatedButton.icon(onPressed: (){
                                        Provider.of<UserProvider>(context,listen: false).unverifyUser(user.userId);
                                        Fluttertoast.showToast(
                                            msg: "User Normalized!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            timeInSecForIosWeb: 3,
                                            backgroundColor: Colors.blueGrey,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        Navigator.of(context).pop();
                                      },icon: Icon(Icons.drive_file_rename_outline) ,label: Text("UnVerify"))
                                  ],
                                ),
                              ],

                            ),
                            Divider(
                              color: Colors.brown,
                              thickness: 1,
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList()),
          ),
        ));
  }
}
