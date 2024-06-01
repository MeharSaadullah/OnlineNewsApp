import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_news_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/splash_pic.jpg',
            //'assets/category_icon.png',
            //'splash_pic.jpg',
            fit: BoxFit.cover,
            height: height * 0.5,
          ),
          SizedBox(height: height * 0.04),
          Text(
            'TOP HEADLINES',
            style: GoogleFonts.anton(
              letterSpacing: 0.6,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: height * 0.04),
          SpinKitChasingDots(
            color: Colors.blue,
            size: 40,
          ),
        ],
      ),
    );
  }
}
