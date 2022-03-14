import 'package:flutter/material.dart';

class Progerss_Avater extends StatefulWidget {
  @override
  State<Progerss_Avater> createState() => _Progerss_AvaterState();
}

class _Progerss_AvaterState extends State<Progerss_Avater>
    with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _controller;

  @override
  void initState() {
    // TODO: implement initState  auto play animation
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(begin: 0.0, end: 0.4).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });

    _controller!.forward();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller!.reverse();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 210),
      width: 110,
      height: 110,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: _animation!.value,
            strokeWidth: 4,
            valueColor: const AlwaysStoppedAnimation(Color(0xFFFF00FF)),
            backgroundColor: Colors.grey.withOpacity(0.2),
          ),
          const Center(
              child: CircleAvatar(
                  radius: 45.0,
                  backgroundImage: AssetImage("assets/Avatar.jpg"))),
        ],
      ),
    );
  }
}

