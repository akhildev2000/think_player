// ignore_for_file: implementation_imports
import 'dart:async';
// ignore: unused_import
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:think_player/sections/home_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 31, 71),
      body: Stack(
        children: [
          Center(
            child: Lottie.asset(
              animate: true,
              'asset/animation/spalsh.json',
              height: 265,
              repeat: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 260),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 300),
                child: Text(
                  'Think Player',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: const Color.fromARGB(255, 234, 226, 226),
                      fontSize: 30),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
