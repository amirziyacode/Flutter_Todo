import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Timecall extends StatelessWidget {
  String text = "";
  int nowtime = DateTime.now().hour;
  String time_call() {
    if (nowtime <= 11) {
      text = "Good Morning  ☀️";
    }
    if (nowtime > 11) {
      text = "Good Afternoon  🌞";
    } if (nowtime >= 16){
      text = "Good Evening  🌆";
    } if (nowtime >= 18) {
      text = "Good Night  🌙";
    }

    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
      time_call(),
      style: GoogleFonts.lato(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 27,
      ),
    ));
  }
}
