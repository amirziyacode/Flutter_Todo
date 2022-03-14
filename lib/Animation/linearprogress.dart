import 'package:flutter/material.dart';

class LineProgress extends StatefulWidget {
  LineProgress({Key? key, required this.Color,required this.value}) : super(key: key);
  final Color;
  double value;
  @override
  State<LineProgress> createState() => _LineProgressState();
}

class _LineProgressState extends State<LineProgress>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  @override
  void initState() {
    // TODO: implemnt controller and animation ..
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animation = Tween(begin: 0.0, end: 0.01).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: _animation.value + widget.value.toDouble() /10,
      valueColor:
           AlwaysStoppedAnimation(widget.Color),
      backgroundColor: Colors.purple[100],
    );
  }
}
