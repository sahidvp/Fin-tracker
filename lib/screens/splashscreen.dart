
import 'package:finance_tracker/screens/introscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    delayFunction(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 18, 54, 52),
          body: Center(
            child: Text(
              "FinTrack",
              style: TextStyle(
                color: Colors.white,
                fontSize: 60,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> delayFunction(context) async {
  await Future.delayed(const Duration(seconds: 3));

  // Check the user's login status from shared preferences
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Navigate to the appropriate screen based on the login status
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
    return isLoggedIn ? const HomePage() :const IntroScreen();
  }));
}



