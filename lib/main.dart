import 'dart:io';

import 'package:fitness_app/Providers/admin_Provider.dart';
import 'package:fitness_app/Providers/chats_provider.dart';
import 'package:fitness_app/Providers/gym_plans_provider.dart';
import 'package:fitness_app/Providers/post_provider.dart';
import 'package:fitness_app/Providers/user_provider.dart';
import 'package:fitness_app/SplashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<int>('steps');
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<AdminProvider>(
          create: (context) => AdminProvider(),
        ),
        ChangeNotifierProvider<PostProvider>(
          create: (context) => PostProvider(),
        ),
        ChangeNotifierProvider<ChatProvider>(
          create: (context) => ChatProvider(),
        ),
        ChangeNotifierProvider<GymPlansProvider>(
          create: (context) => GymPlansProvider(),
        ),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fitness App',
        theme: ThemeData(
          accentColor: Color.fromRGBO(0, 18, 94, 1),
        ),
        home: SplashView());
  }
}
