import 'package:fitness_app/Models/comment_model.dart';
import 'package:fitness_app/Models/post_model.dart';
import 'package:fitness_app/Models/user_model.dart';
import 'package:fitness_app/Providers/post_provider.dart';
import 'package:fitness_app/Providers/user_provider.dart';
import 'package:fitness_app/timeline/add_post.dart';
import 'package:flutter/material.dart';

import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:another_flushbar/flushbar.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPost(),));
            },
            child: Icon(Icons.add_box),
            backgroundColor: Color.fromRGBO(95, 0, 27, .9),
          ),
          appBar: NewGradientAppBar(
            title: Text("Timeline"),
            actions: [],
            toolbarOpacity: 0.7,
            gradient: LinearGradient(colors: [
              Color.fromRGBO(95, 0, 27, 1),
              Color.fromRGBO(0, 18, 94, .9),
            ]),
            bottom: TabBar(tabs: <Widget>[
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.store),
                text: 'Gym Plan',
              )
            ]),
          ),
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
            child: FutureBuilder(
              future: Provider.of<UserProvider>(context, listen: false)
                  .checkFollowing(FirebaseAuth.instance.currentUser.uid),
              builder: (context, snapshot) {
                List<String> followingIds = [];
                if (snapshot.hasData) {
                  snapshot.data.docs.forEach((doc) {
                    followingIds.add(doc.id.toString());
                  });
                }
                return FutureBuilder(
                    future: Provider.of<PostProvider>(context, listen: false)
                        .fetchPostsData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Post post;
                        List<Post> posts = [];

                        snapshot.data.docs.forEach((doc) {
                          post = Post.fromDocument(doc);
                          posts.add(post);
                        });
                        posts = posts
                            .where((element) =>
                                followingIds.contains(element.uid) ||
                                element.uid ==
                                    FirebaseAuth.instance.currentUser.uid)
                            .toList();
                        return SingleChildScrollView(
                          child: Column(
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      timeago.format(postItem
                                                          .publishDate
                                                          .toDate()),
                                                      style:
                                                          GoogleFonts.novaRound(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    if (postItem.location !=
                                                        null)
                                                      Text(
                                                        postItem.location,
                                                        style: GoogleFonts
                                                            .novaRound(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  if (postItem.imageUrl != null)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 10),
                                      child: InteractiveViewer(
                                        panEnabled: false,
                                        boundaryMargin: EdgeInsets.all(100),
                                        minScale: 0.5,
                                        maxScale: 2,
                                        child: Image.network(
                                          postItem.imageUrl,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                    ),
                                  FutureBuilder(
                                    future: Provider.of<PostProvider>(context,
                                            listen: false)
                                        .fetchPostsComments(postItem.postId),
                                    builder: (context, snapshot) {
                                      Comment comment;
                                      List<Comment> comments = [];
                                      if (snapshot.hasData) {
                                        snapshot.data.docs.forEach((doc) {
                                          comment = Comment.fromDocument(doc);
                                          comments.add(comment);
                                        });
                                      }
                                      print(comments.length);
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onLongPress: () =>
                                                Scaffold.of(context)
                                                    .showBottomSheet(
                                                        (context) => SingleChildScrollView(
                                                          child: Column(
                                                                children: [
                                                                  Container(
                                                                      height: MediaQuery.of(
                                                                                  context)
                                                                              .size
                                                                              .height *
                                                                          75 /
                                                                          100,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      padding: EdgeInsets
                                                                          .all(
                                                                              20),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .black12,
                                                                        image:
                                                                            DecorationImage(
                                                                          image: AssetImage(
                                                                              "assets/images/SHA5BET.png"),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      child: SingleChildScrollView(
                                                                        child: Column(
                                                                            children: comments.map((e) {
                                                                          return Container(
                                                                            padding:
                                                                                EdgeInsets.all(20),
                                                                            margin:
                                                                            EdgeInsets.only(bottom: 20),
                                                                            width: MediaQuery.of(context)
                                                                                .size
                                                                                .width,
                                                                            decoration: BoxDecoration(
                                                                                borderRadius:
                                                                                    BorderRadius.circular(20),
                                                                                color: Colors.black.withOpacity(0.2)),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                FutureBuilder(
                                                                                  future: Provider.of<UserProvider>(
                                                                                    context,
                                                                                  ).fetchUserAsFuture(e.commenterId),
                                                                                  builder: (context, ss) {
                                                                                    if (ss.hasData) {
                                                                                      return Row(

                                                                                        children: [
                                                                                          CircleAvatar(backgroundImage: NetworkImage(ss.data['imageUrl'])),
                                                                                          SizedBox(width: 8,),
                                                                                          Text(ss.data['firstName']+ " "+ss.data['lastName']),
                                                                                        ],
                                                                                      );
                                                                                    }
                                                                                    return CircularProgressIndicator();
                                                                                  },
                                                                                ),

                                                                                Text(e.commentText,style: TextStyle(fontSize: 17),)
                                                                              ],
                                                                            ),
                                                                          );
                                                                        }).toList()),
                                                                      ))
                                                                ],
                                                              ),
                                                        )),
                                            onTap: () {
                                              return Flushbar(
                                                title: "Comment To Post",
                                                titleColor: Colors.white,
                                                flushbarPosition:
                                                    FlushbarPosition.TOP,
                                                flushbarStyle:
                                                    FlushbarStyle.FLOATING,
                                                reverseAnimationCurve:
                                                    Curves.decelerate,
                                                forwardAnimationCurve:
                                                    Curves.elasticOut,
                                                backgroundColor: Colors.red,
                                                boxShadows: [
                                                  BoxShadow(
                                                      color: Colors.white,
                                                      offset: Offset(0.0, 2.0),
                                                      blurRadius: 7.0)
                                                ],
                                                backgroundGradient:
                                                    LinearGradient(colors: [
                                                  Color.fromRGBO(
                                                      0, 18, 94, 0.7),
                                                  Colors.black26
                                                ]),
                                                isDismissible: true,
                                                duration: Duration(seconds: 40),
                                                icon: Icon(
                                                  Icons.check,
                                                  color: Colors.greenAccent,
                                                ),
                                                mainButton: Column(
                                                  children: [
                                                    FlatButton(
                                                      onPressed: () {
                                                        Navigator.of(
                                                                this.context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                        "CANCEL!",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    FlatButton(
                                                      onPressed: () {
                                                        if (commentController
                                                            .text.isNotEmpty) {
                                                          Provider.of<PostProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .addCommentToPost(
                                                                  postItem
                                                                      .postId,
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser
                                                                      .uid,
                                                                  commentController
                                                                      .text);

                                                          Navigator.of(context)
                                                              .pop();
                                                          setState(() {

                                                          });
                                                        } else {
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      },
                                                      child: Text(
                                                        "SEND!",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            letterSpacing: 4,
                                                            color:
                                                                Color.fromRGBO(
                                                                    95,
                                                                    0,
                                                                    27,
                                                                    .7),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                showProgressIndicator: false,
                                                padding: EdgeInsets.all(40),
                                                progressIndicatorBackgroundColor:
                                                    Colors.blueGrey,
                                                titleText: Text(
                                                  "Comment To Post!",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.0,
                                                      color: Colors.white,
                                                      fontFamily:
                                                          "ShadowsIntoLightTwo"),
                                                ),
                                                messageText: TextField(
                                                  controller: commentController,
                                                ),
                                              )..show(context);
                                            },
                                            child: Icon(Icons.comment_sharp,
                                                size: 26,
                                                color: Color.fromRGBO(
                                                    0, 18, 94, 1)),
                                          ),
                                          Text(
                                            comments.length.toString(),
                                            style: TextStyle(
                                                color: Colors.black38),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          FutureBuilder(
                                            future: Provider.of<PostProvider>(
                                                    context,
                                                    listen: false)
                                                .fetchPostsLikers(
                                                    postItem.postId),
                                            builder: (context, snapshot) {
                                              bool isLikedOrNo = false;
                                              List<String> LikersIds = [];
                                              if (snapshot.hasData) {
                                                snapshot.data.docs
                                                    .forEach((doc) {
                                                  LikersIds.add(
                                                      doc.id.toString());
                                                });
                                                if (LikersIds.contains(
                                                    FirebaseAuth.instance
                                                        .currentUser.uid)) {
                                                  isLikedOrNo = true;
                                                }
                                              }
                                              return GestureDetector(
                                                  onTap: () {
                                                    if (!isLikedOrNo) {
                                                      Provider.of<PostProvider>(
                                                              context,
                                                              listen: false)
                                                          .addLikeToPost(
                                                              postItem.postId,
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser
                                                                  .uid,
                                                              postItem.likesCount +
                                                                  1);
                                                      setState(() {});
                                                    } else {
                                                      Provider.of<PostProvider>(
                                                              context,
                                                              listen: false)
                                                          .removeLikeFromPost(
                                                              postItem.postId,
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser
                                                                  .uid,
                                                              postItem.likesCount -
                                                                  1);
                                                      setState(() {});
                                                    }
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        isLikedOrNo
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border,
                                                        color: isLikedOrNo
                                                            ? Colors.red
                                                            : Colors.black38,
                                                      ),
                                                      Text(
                                                        postItem.likesCount
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black38),
                                                      ),
                                                    ],
                                                  ));
                                            },
                                          ),
                                        ],
                                      );
                                    },
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
                          }).toList()),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    });
              },
            ),
          )),
    );
  }

/*  LikeButton(
  isLiked: LikersIds.contains(FirebaseAuth.instance.currentUser.uid)? true : false,
  likeCount: postItem.likesCount,
  onTap: (isLiked) {
  if(isLiked){
  Provider.of<PostProvider>(context,listen: false).addLikeToPost(postItem.postId, FirebaseAuth.instance.currentUser.uid,postItem.likesCount+1);
  }
  Provider.of<PostProvider>(context,listen: false).removeLikeFromPost(postItem.postId, FirebaseAuth.instance.currentUser.uid,postItem.likesCount-1);
  },
  );*/
}
