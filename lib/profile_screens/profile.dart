import 'package:fitness_app/sliver_appbar/profile_sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/Providers/post_provider.dart';
import 'package:fitness_app/widgets/timeline_builder.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        ProfileAppbar(
          userId: FirebaseAuth.instance.currentUser.uid,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black12,
              image: DecorationImage(
                image: AssetImage("assets/images/SHA5BET.png"),
                fit: BoxFit.cover,
              ),
            ),
              child: TimelineBuilder(future: Provider.of<PostProvider>(context,listen: false).fetchPostsData(),)),

        ]))
      ],
    ));
  }
}
