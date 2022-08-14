import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/data/advice.dart';
import 'package:google_fonts/google_fonts.dart';

class Chart extends StatefulWidget {
  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int random = Random().nextInt(advices.length);
    setState(() {
      index = random;
    });
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(right: 100, top: we * 0.15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 50, left: 20),
            child: AnimatedTextKit(repeatForever: true, animatedTexts: [
              TyperAnimatedText(advices[index].description,
                  speed: const Duration(milliseconds: 90),
                  textStyle: const TextStyle(color: Colors.white)),
            ]),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              advices[index].name,
              style: GoogleFonts.lato(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
