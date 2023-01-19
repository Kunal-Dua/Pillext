// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pillext/HomeScreen.dart';
import 'package:pillext/LoginScreen.dart';
import 'package:pillext/responsive/mobileScreenLayout.dart';
import 'package:pillext/responsive/responsive_layout_screen.dart';
import 'package:pillext/responsive/webScreenLayout.dart';
import 'package:pillext/signUpScrenn.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      // home: const ResponsiveLayout(
      //     webScreenLayout: WebScreenLayout(),
      //     mobileScreenLayout: MobileScreenLayout()),
      // home: LoginScreen(),
      routes: {
        "/":(context) => LoginScreen(),
        "/signUp":(context) => SignUpScreen(),
        "/login":(context) => LoginScreen(),
        "/home":(context) => HomeScreen(),
      },
    );
  }
}
