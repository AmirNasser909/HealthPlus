import 'package:fitness_app/Models/post_model.dart';
import 'package:fitness_app/Providers/post_provider.dart';
import 'package:fitness_app/Providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:firebase_auth/firebase_auth.dart';
class TimelineBuilder extends StatefulWidget {
  final Future<dynamic> future;

  const TimelineBuilder({
    @required this.future,
  });

  @override
  _TimelineBuilderState createState() => _TimelineBuilderState();
}

class _TimelineBuilderState extends State<TimelineBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Post post;
            List<Post> posts = [];
            snapshot.data.docs.forEach((doc) {
              post = Post.fromDocument(doc);
              posts.add(post);
            });
            posts = posts.where((element) => element.uid == FirebaseAuth.instance.currentUser.uid).toList();
            return Column(
                children: posts.map((postItem) {
              return Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(),
                child: Column(
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                      stream: Provider.of<UserProvider>(context)
                          .fetchUser(postItem.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    snapshot.data['imageUrl']),
                                radius: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data['firstName'] +
                                        " " +
                                        snapshot.data['lastName'],
                                    style: GoogleFonts.novaRound(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        timeago.format(postItem
                                            .publishDate
                                            .toDate()),
                                        style: GoogleFonts.novaRound(
                                            color: Colors.black54,
                                            fontSize: 12,
                                            fontWeight:
                                            FontWeight.normal),
                                      ),
                                      SizedBox(width: 5,),
                                      if (postItem.location != null)
                                        Text(
                                          postItem.location,
                                          style:
                                          GoogleFonts.novaRound(
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight
                                                  .bold),
                                        ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                          );
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      postItem.post,
                      style: GoogleFonts.novaRound(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                    if (postItem.imageUrl != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InteractiveViewer(
                          panEnabled: false,
                          boundaryMargin: EdgeInsets.all(100),
                          minScale: 0.5,
                          maxScale: 2,
                          child: Image.network(
                            postItem.imageUrl,
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.comment_sharp,
                            size: 26,
                            color: Color.fromRGBO(0, 18, 94, 1)),
                        SizedBox(
                          width: 5,
                        ),

                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.black12,
                      thickness: 1,
                      height: 10,
                    )
                  ],
                ),
              );
            }).toList());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
