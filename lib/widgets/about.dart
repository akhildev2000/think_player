import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

void about(context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 3, 31, 71),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text(' About App',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500, color: Colors.white)),
        icon: const Icon(
          Icons.privacy_tip_outlined,
          color: Color.fromARGB(255, 3, 31, 71),
          size: 30,
        ),
        content: Column(
          children: [
            Text(
                '''Think Player is a simple and user-friendly video player that has multiple functionalities
-It enables to switch themes
-It has playlist and favourites
-It has sort option for your videos
-Reset App support
We try to improve our app day by day
''',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, color: Colors.white)),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'Made with  ',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, color: Colors.white)),
                    const WidgetSpan(
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrlString('https://brototype.in/');
                        },
                      text: ' from Brocamp',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                onPressed: () {
                  showLicensePage(
                      context: context,
                      applicationName: 'Think Player',
                      applicationVersion: '0.0.1');
                },
                icon: const Icon(
                  Icons.account_box_rounded,
                  color: Color.fromARGB(255, 3, 31, 71),
                ),
                label: Text(
                  'View License',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 3, 31, 71),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Version 0.0.1',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color.fromARGB(255, 3, 31, 71),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            )
          ],
        ),
      );
    },
  );
}
