import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:think_player/sections/functions/splash_screen.dart';

import '../sections/database/dbfav_fun.dart';

resetApp(context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('RESET APP '),
        icon: const Icon(
          Icons.warning_rounded,
          color: Color.fromARGB(255, 3, 31, 71),
          size: 30,
        ),
        content: Text(
          'This action will clear your data such as playlists, favourites, etc..!!. Do you want to continue?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              clearAllDB();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SplashScreen(),
                  ),
                  (route) => false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Color.fromARGB(255, 3, 31, 71),
                  content: Text(
                    "Reset App Completed",
                  ),
                  duration: Duration(seconds: 3),
                ),
              );
            },
            child: const Text('Yes'),
          ),
          ElevatedButton(
              onPressed: () => Navigator.pop(context), child: const Text('No'))
        ],
        contentPadding: const EdgeInsets.all(15),
        actionsPadding: const EdgeInsets.only(right: 100),
      );
    },
  );
}
