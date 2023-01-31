import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:think_player/main.dart';
import 'package:think_player/widgets/about.dart';
import 'package:think_player/widgets/privacy.dart';
import 'package:think_player/widgets/reset_app.dart';
import 'package:think_player/widgets/setting_sec.dart';
//import 'package:path_provider/path_provider.dart';

import '../../widgets/change_theme.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool value = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Text(
            "Settings ",
            style: GoogleFonts.merriweather(fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
      ),
      body: SizedBox(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SettingSec(
                setIcon: Icons.person,
                setText: "About",
                iconFun: () {
                  about(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SettingSec(
                setIcon: Icons.restore_page_rounded,
                setText: 'Reset App',
                iconFun: () {
                  resetApp(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SettingSec(
                setIcon: Icons.privacy_tip,
                setText: "Privacy Policy",
                iconFun: () {
                  privacy(context);
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 55, top: 10, left: 10),
              child: ListTile(
                iconColor: Theme.of(context).listTileTheme.iconColor,
                textColor: Theme.of(context).listTileTheme.textColor,
                tileColor: Theme.of(context).listTileTheme.tileColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                title: Text('Switch Theme',
                    style: GoogleFonts.merriweatherSans(
                        fontWeight: FontWeight.w600)),
                leading: const Icon(
                  Icons.color_lens_rounded,
                  size: 30,
                ),
                trailing: const ChangeThemeButton(),
              ),
            ),
            // buildSwitch(value)
          ],
        ),
      ),
    );
  }

  // Widget buildSwitch(value) => Switch.adaptive(
  //       value: value,
  //       onChanged: (value) => setState(() => this.value = value),
  //     );
}
