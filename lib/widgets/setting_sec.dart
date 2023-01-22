import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

class SettingSec extends StatefulWidget {
  final String setText;
  final IconData setIcon;
  final Function() iconFun;

  const SettingSec({
    super.key,
    required this.setIcon,
    required this.setText,
    required this.iconFun,
  });

  @override
  State<SettingSec> createState() => _SettingSecState();
}

class _SettingSecState extends State<SettingSec> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: ListTile(
        iconColor: Theme.of(context).listTileTheme.iconColor,
        textColor: Theme.of(context).listTileTheme.textColor,
        tileColor: Theme.of(context).listTileTheme.tileColor,
        contentPadding: const EdgeInsets.only(
          right: 75,
          left: 15,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        title: Text(widget.setText,
            style: GoogleFonts.merriweatherSans(fontWeight: FontWeight.w600)),
        leading: Icon(
          widget.setIcon,
          size: 30,
        ),
        onTap: widget.iconFun,
      ),
    );
  }
}
