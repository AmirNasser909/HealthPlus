import 'package:fitness_app/Models/message_model.dart';
import 'package:fitness_app/Providers/chats_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/Providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  final String UID;
  final String DisplayName;
  final String ImageUrl;
  final String UserBio;

  const Chat(
      {@required this.UID,
      @required this.DisplayName,
      @required this.ImageUrl,
      @required this.UserBio});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var _textEditingController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: 20),
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
              StreamBuilder(
                  stream: Provider.of<ChatProvider>(context, listen: false)
                      .fetchMsg(
                          FirebaseAuth.instance.currentUser.uid, widget.UID),
                  builder: (context, snapshot) {
                    List<Message> messages = [];
                    if (snapshot.hasData) {
                      snapshot.data.docs.forEach((element) {
                        messages.add(Message.fromDocument(element));
                      });
                      return Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(widget.ImageUrl),
                                radius: MediaQuery.of(context).size.width *
                                    23 /
                                    100,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                widget.DisplayName,
                                style: GoogleFonts.novaRound(
                                    fontSize: 25, color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.UserBio,
                                style: GoogleFonts.novaRound(
                                    fontSize: 15, color: Colors.white),
                              ),
                              Column(
                                children: messages.map((e) {
                                  if (e.currentUserId ==
                                      FirebaseAuth.instance.currentUser.uid) {
                                    return BubbleNormal(
                                      text: e.MsgText,
                                      isSender: true,
                                      color: Color(0xFFE8E8EE),
                                      tail: true,
                                      sent: true,
                                      seen: e.seen,
                                    );
                                  } else {
                                    return BubbleNormal(
                                      text: e.MsgText,
                                      isSender: false,
                                      color: Color(0xFF1B97F3),
                                      tail: true,
                                      sent: false,
                                    );
                                  }
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else
                      return CircularProgressIndicator();
                  }),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                        child: TextField(
                      controller: _textEditingController,
                      maxLines: 2,
                      minLines: 1,
                      decoration: InputDecoration(
                          hintText: "How are you bro ?",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onChanged: (value) {
                        setState(() {});
                      },
                    )),
                    SizedBox(
                      width: 2,
                    ),
                    if (_textEditingController.text.isNotEmpty)
                      IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            Provider.of<ChatProvider>(context, listen: false)
                                .sendMsg(FirebaseAuth.instance.currentUser.uid,
                                    widget.UID, _textEditingController.text);
                            _textEditingController.clear();
                            FocusScope.of(context).unfocus();
                          })
                    else
                      IconButton(
                        icon: Icon(Icons.send),
                      )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

/*

                 */
