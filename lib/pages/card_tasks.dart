import 'package:flutter/material.dart';
import 'package:flutter_todo/db/noted.dart';

class CardTasks extends StatelessWidget {
  Notes taskuser;
  bool isActive;

  int Index;
  final colorIcon = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange
  ];
  ValueChanged<Notes> onSelected;

  CardTasks(
      {Key? key,
      required this.taskuser,
      required this.isActive,
      required this.Index,
      required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.red;
    if (taskuser.title == "Business") {
      color = const Color(0xFFAC05FF);
    } else if (taskuser.title == "Personal") {
      color = const Color(0xFF0011FF);
    } else if (taskuser.title == "Sports") {
      color = Colors.red;
    } else if (taskuser.title == "School") {
      color = Colors.green;
    } else if (taskuser.title == "Family") {
      color = Colors.orange;
    }
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: we * 0.9,
        height: he * 0.09,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: InkWell(
                  onTap: () => onSelected(taskuser),
                  child: isActive
                      ? const Icon(Icons.check_circle_outlined,
                          color: Colors.grey)
                      
                      : Icon(
                          Icons.circle_outlined,
                          color: color,
                        ),
                )),
            SizedBox(
              width: we * 0.025,
            ),
            Expanded(
                child: Text(taskuser.description,
                    maxLines: 20,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                      // ignore: unrelated_type_equality_checks
                      decoration: isActive
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    )))
          ],
        ),
      ),
    );
  }
}
