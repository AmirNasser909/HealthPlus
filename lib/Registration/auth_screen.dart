import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

class RegistrationView extends StatefulWidget {
  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

enum AuthMode { SignUp, Login }

class _RegistrationViewState extends State<RegistrationView> {


  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }


  var _auth = FirebaseAuth.instance;
  var _authMode = AuthMode.Login;

  final GoogleSignIn _google_sign = GoogleSignIn();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formkey = GlobalKey();
  var _passwordController = new TextEditingController();
  bool _passwordVisibility = true;
  Map<String, String> _authData = {
    'FirstName': '',
    'LastName': '',
    'UserName': '',
    'Email': '',
    'Password': '',
    'Phone': '',
  };

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    if (_authMode == AuthMode.SignUp)
      return Scaffold(
          key: _scaffoldKey,
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(30, 70, 30, 0),
              decoration: BoxDecoration(
                color: Colors.black12,
                image: DecorationImage(
                  image: AssetImage("assets/images/SHA5BET.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "BUILD A NEW WORLD OF FIT",
                        style: GoogleFonts.novaRound(
                            color: Color.fromRGBO(0, 18, 94, 1), fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty ||
                                value.contains("%") ||
                                value.contains("\$") ||
                                value.contains("#") ||
                                value.contains("%") ||
                                value.contains("^")) {
                              return "Invalid Name";
                            }
                            return null;
                          },
                          onSaved: (FirstName) {
                            _authData['FirstName'] = FirstName;
                          },
                          decoration: InputDecoration(
                              labelText: "First Name",
                              labelStyle: GoogleFonts.novaRound())),
                      TextFormField(
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty ||
                                value.contains("%") ||
                                value.contains("\$") ||
                                value.contains("#") ||
                                value.contains("%") ||
                                value.contains("^")) {
                              return "Invalid Name";
                            }
                            return null;
                          },
                          onSaved: (LastName) {
                            _authData['LastName'] = LastName;
                          },
                          decoration: InputDecoration(
                              labelText: "Last Name",
                              labelStyle: GoogleFonts.novaRound())),
                     /* TextFormField(
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty ||
                                value.contains("%") ||
                                value.contains("\$") ||
                                value.contains("#") ||
                                value.contains("%") ||
                                value.contains("^")) {
                              return "Invalid UserName";
                            }
                            return null;
                          },
                          onSaved: (UserName) {
                            _authData['UserName'] = UserName;
                          },
                          decoration: InputDecoration(
                              labelText: "Username",
                              labelStyle: GoogleFonts.novaRound())),*/
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty || !value.contains("@")) {
                              return "Invalid Email";
                            }
                            return null;
                          },
                          onSaved: (Email) {
                            _authData['Email'] = Email;
                          },
                          decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: GoogleFonts.novaRound())),
                      TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value.isEmpty || value.length <= 6) {
                              return "Invalid Password";
                            }
                            return null;
                          },
                          controller: _passwordController,
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: GoogleFonts.novaRound())),
                      TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value.compareTo(_passwordController.text) !=
                                    0 ||
                                value.isEmpty) {
                              return "Password doesn't match";
                            }
                            return null;
                          },
                          onSaved: (Password) {
                            _authData['Password'] = Password;
                          },
                          decoration: InputDecoration(
                              labelText: "Confirm Password",
                              labelStyle: GoogleFonts.novaRound())),
                      TextFormField(
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value.isEmpty || value.length < 11) {
                              return "Invalid Phone";
                            }
                            return null;
                          },
                          onSaved: (Phone) {
                            _authData['Phone'] = Phone;
                          },
                          decoration: InputDecoration(
                              labelText: "Phone Number",
                              labelStyle: GoogleFonts.novaRound())),
                      SizedBox(
                        height: 40,
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
                          _submitForm();
                        },
                        child: Text(
                          "Submit",
                          style: GoogleFonts.novaRound(fontSize: 25),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            _switchMode();
                          },
                          child: Text("LOGIN INSTEAD")),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Login With",
                        style: TextStyle(color: Color.fromRGBO(0, 18, 94, 1)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                _signInWithGoogle();
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    "assets/co_logos/google_logo.png",
                                    height: 40,
                                    width: 100,
                                  )),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {},
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                      "assets/co_logos/facebook_logo.png",
                                      height: 40,
                                      width: 100)),
                            ),
                            InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(20),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                      "assets/co_logos/twitter_logo.png",
                                      height: 60,
                                      width: 100)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )));
    if (_authMode == AuthMode.Login)
      return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(30, 70, 30, 0),
            decoration: BoxDecoration(
              color: Colors.black12,
              image: DecorationImage(
                image: AssetImage("assets/images/SHA5BET.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset("assets/images/LOGO_COLORED.png"),
                    Text(
                      "LOGIN INTO YOUR ACCOUNT",
                      style: GoogleFonts.novaRound(
                          color: Color.fromRGBO(0, 18, 94, 1), fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        onSaved: (Email) {
                          _authData['Email'] = Email;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "No Email found";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.person),
                            labelText: "Email",
                            labelStyle: GoogleFonts.novaRound())),
                    TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Invalid Password";
                          }
                          return null;
                        },
                        onSaved: (password) {
                          _authData['Password'] = password;
                        },
                        obscureText: _passwordVisibility ? true : false,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisibility = !_passwordVisibility;
                                });
                              },
                              icon: _passwordVisibility
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                            ),
                            labelText: "Password",
                            labelStyle: GoogleFonts.novaRound())),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(10),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(0, 18, 94, 1)),
                        padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(
                          100,
                          5,
                          100,
                          5,
                        )),
                      ),
                      onPressed: () {
                        _submitForm();
                      },
                      child: Text(
                        "LOGIN",
                        style: GoogleFonts.novaRound(fontSize: 25),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          _switchMode();
                        },
                        child: Text("SIGNUP INSTEAD")),
                  ],
                ),
              ),
            )),
      );
  }

  Future<bool> _checkAccountExsistance(String email) async {
    bool Exsisted;
    List<String> res =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    if (res.isEmpty) {
      setState(() {
        Exsisted = false;
      });
    } else {
      setState(() {
        Exsisted = true;
      });
    }
    return Exsisted;
  }

  void _showErrorDialog(message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(

        title: Text('Problem Detected'),
        content: Text(message),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Okay'))
        ],
      ),
    );
  }

  void _switchMode() {
    if (_authMode == AuthMode.SignUp) {
      setState(() {
        _authMode = AuthMode.Login;
      });
    } else {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
    }
  }

  _submitAuthForm(String FirstName, String LastName, String email, String password, String Phone, bool isLogin,
      BuildContext ctx) async {
    String message = "Error while processing user credential";

    try {
      if (isLogin) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((userSigned) async {
          await FirebaseAuth.instance.currentUser.updateProfile(
              displayName: FirstName + " " + LastName,
              photoURL:
                  'https://motorins.net/SD08/msf/154db423d3-e3ea-4c20-943d-300d0ea32a4f.jpg');

          var _user = FirebaseAuth.instance.currentUser;
          FirebaseFirestore.instance.collection('users').doc(_user.uid).set({
            'userId': _user.uid,
            'userName': _user.uid,
            'imageUrl': _user.photoURL,
            'verified': 'false',
            'phoneNumber': Phone,
            'firstName': FirstName,
            'lastName': LastName,
            'email': email,
            'bio' : "Hi There , Im Getting fit",
            'userType' : "User",
            'location': "",
          }).then((_) {
            Fluttertoast.showToast(
                msg: "Congratulations $FirstName you are now fit",
                fontSize: 14,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.blue.withOpacity(0.5));
          });
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = "Password is too weak";
      } else if (e.code == 'email-already-in-use') {
        message = "This email is already exists";
      } else if (e.code == 'user-not-found') {
        message = "User is not found";
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password';
      }
      _showErrorDialog(message);
    } catch (error) {
      message = error.toString();
      _showErrorDialog(message);
      print(error);
    }
  }

  bool _checkAuthMode() {
    if (_authMode == AuthMode.Login) {
      return true;
    } else {
      return false;
    }
  }

  void _signInWithGoogle() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _google_sign.signIn();

      var GoogleAccountMail = googleSignInAccount.email;

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      var credintial = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      await _checkAccountExsistance(GoogleAccountMail).then((VAL) {
        if (VAL) {
          _auth.signInWithCredential(credintial);
        } else {
          _auth.signInWithCredential(credintial).then((auth) async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(auth.user.uid)
                .set({
              'userId': auth.user.uid,
              'userName': auth.user.uid,
              'imageUrl': auth.user.photoURL,
              'verified': 'false',
              'phoneNumber': auth.user.phoneNumber,
              'firstName': auth.user.displayName.split(" ")[0],
              'lastName': auth.user.displayName.split(" ")[1],
              'email': auth.user.email,
              'bio' : "Hi There , Im Getting fit",
              'userType' : "User",
              'location': "",
            }).then((_) {


              /*Fluttertoast.showToast(
                  msg:
                      "Congratulations ${auth.user.displayName} you are now fit",
                  fontSize: 14,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.blue.withOpacity(0.5));*/
            });
          });
        }
      });
    } catch (Error) {
      print("ERROR OCCURRED");
    }
  }

  _submitForm() {
    if (!_formkey.currentState.validate()) {
      return;
    } else {
      FocusScope.of(context).unfocus();
      _formkey.currentState.save();

      _submitAuthForm(
          _authData['FirstName'],
          _authData['LastName'],
          _authData['Email'],
          _authData['Password'],
          _authData['Phone'],
          _checkAuthMode(),
          context);
    }
  }
}
