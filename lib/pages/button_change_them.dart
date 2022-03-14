import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/data/thems.dart';
import 'package:provider/provider.dart';


class ChangeThembutton extends StatefulWidget {
  ChangeThembutton({Key? key}) : super(key: key);

  @override
  State<ChangeThembutton> createState() => _ChangeThembuttonState();
}

class _ChangeThembuttonState extends State<ChangeThembutton> {
  bool Ison = false;
  bool Isicons = false;

  @override
  Widget build(BuildContext context) {
    // Todo this button for change them of app .. 
    final themprovider = Provider.of<ThemProvider>(context);
    return IconButton(
        onPressed: () {
          final provider = Provider.of<ThemProvider>(context, listen: false);
          Isicons = !Isicons;
          Ison = themprovider.isDarkMode;

          provider.toggleThem(Ison);
        },
        icon: Isicons
            ? const Icon(
                Icons.mode_night_outlined,
                color: Colors.grey,
              )
            : const Icon(
                Icons.light_mode_outlined,
                color: Colors.grey,
              ));
  }
}
