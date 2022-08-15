import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_todo/Animation/fadeAnimation.dart';
import 'package:flutter_todo/main.dart';
import 'package:flutter_todo/pages/note_task.dart';
import 'package:flutter_todo/db/boxes.dart';
import 'package:flutter_todo/db/noted.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import '../data/shared/Task_saved.dart';
import '../data/tasks.dart';
import '../Animation/linearprogress.dart';
import '../data/time_say.dart';
import 'button_change_them.dart';
import 'card_tasks.dart';

// late Box box;

class MyHomePage extends StatefulWidget {
  VoidCallback opendrawer;
  MyHomePage({required this.opendrawer});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> all_selected_tasks = []; // your tasks

  int Business = 0;
  int Personal = 0;
  int Programming = 0;
  int Sports = 0;
  int Family = 0;

  bool isLoading = false;
  final noted = box.values.toList().cast<Notes>();

  void refresh() {
    setState(() {
      noted.forEach((element) {});
    });
  }

  void cheakTag() {
    noted.forEach((element) {
      if (element.title == "Business") {
        setState(() {
          Business++;
        });
      } else if (element.title == "Personal") {
        setState(() {
          Personal++;
        });
      } else if (element.title == "Programming") {
        setState(() {
          Programming++;
        });
      } else if (element.title == "Sports") {
        setState(() {
          Sports++;
        });
      } else if (element.title == "Family") {
        setState(() {
          Family++;
        });
      } else {
        Business = 0;
        Personal = 0;
        Programming = 0;
        Sports = 0;
        Family = 0;
      }
    });
  }

  void initState() {
    all_selected_tasks = TaskerPreference.getString() ?? [];
    cheakTag();
    refresh();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: close Hive_Database of Note ...
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppBarTheme.of(context).backgroundColor,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: widget.opendrawer,
                  icon: const Icon(
                    Icons.drag_handle_outlined,
                    color: Colors.grey,
                    size: 35,
                  )),
              SizedBox(
                width: we * 0.7,
              ),
              SizedBox(
                width: we * 0.01,
              ),
              ChangeThembutton()
            ],
          )
        ],
      ),
      body: ValueListenableBuilder<Box<Notes>>(
          valueListenable: Boxes.getNote().listenable(),
          builder: (context, box, _) {
            final noted = box.values.toList().cast<Notes>();
            return SizedBox(
                width: we,
                height: he,
                child: Column(children: [
                  FadeAnimation(
                    delay: 0.8,
                    child: Container(
                      margin: EdgeInsets.only(top: he * 0.02),
                      width: we * 0.9,
                      height: he * 0.15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Timecall(),
                          SizedBox(
                            height: he * 0.06,
                          ),
                          Text(
                            "CATEGORIES",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.grey.withOpacity(0.8),
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: SizedBox(
                      width: we * 2,
                      height: he * 0.16,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _buildCategories(context, tasklist[0].title,
                              tasklist[0].progresscolor, Business),
                          _buildCategories(context, tasklist[1].title,
                              tasklist[1].progresscolor, Personal),
                          _buildCategories(context, tasklist[2].title,
                              tasklist[2].progresscolor, Programming),
                          _buildCategories(context, tasklist[3].title,
                              tasklist[3].progresscolor, Sports),
                          _buildCategories(context, tasklist[4].title,
                              tasklist[4].progresscolor, Family),
                        ],
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: he * 0.04,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(left: 15, bottom: 15),
                    child: Text("TODAY'S TASKS",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.grey.withOpacity(0.8),
                            fontSize: 13)),
                  ),
                  FadeAnimation(
                      delay: 1,
                      child: SizedBox(
                          width: we * 0.9,
                          height: he * 0.4,
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : noted.isEmpty
                                  ? Center(
                                      child: Lottie.asset(
                                        "assets/78347-no-search-result.json",
                                        width: we * 0.6,
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: noted.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        // ignore: non_constant_identifier_names
                                        final IsSelected = all_selected_tasks
                                            .contains(noted[index].description);
                                        return Slidable(
                                            endActionPane: ActionPane(
                                              motion: const StretchMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (context) =>
                                                      deleteitem(noted[index]),
                                                  backgroundColor:
                                                      const Color(0xFFFE4A49),
                                                  foregroundColor: Colors.white,
                                                  icon: Icons.delete,
                                                  label: "Delete",
                                                ),
                                                SlidableAction(
                                                  onPressed: (context) async {
                                                    await Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Note_Task(
                                                                      note: noted[
                                                                          index],
                                                                    )));
                                                  },
                                                  backgroundColor:
                                                      const Color(0xFF21B7CA),
                                                  foregroundColor: Colors.white,
                                                  label: "Edite",
                                                  icon: Icons.edit,
                                                ),
                                              ],
                                            ),
                                            child: builditem(
                                              noted[index],
                                              IsSelected,
                                            ));
                                      },
                                      physics: const BouncingScrollPhysics(),
                                    ))),
                ]));
          }),
      floatingActionButton: FadeAnimation(
        delay: 1.2,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(PageTransition(
                type: PageTransitionType.fade,
                child: Note_Task(
                    note: Notes(description: "", title: "Business"))));
          },
          backgroundColor:
              const FloatingActionButtonThemeData().backgroundColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildCategories(
      context, String title, Color lineProgress, int numbertask) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    return Card(
      margin: const EdgeInsets.only(left: 23),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.2),
      child: Container(
        width: we * 0.5,
        height: he * 0.1,
        margin: const EdgeInsets.only(
          top: 25,
          left: 14,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$numbertask task",
              style: TextStyle(color: Colors.grey.withOpacity(0.9)),
            ),
            SizedBox(
              height: he * 0.01,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 23,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: he * 0.03),
            Padding(
                padding: const EdgeInsets.only(right: 30),
                child: LineProgress(
                  value: numbertask.toDouble(),
                  Color: lineProgress,
                )),
          ],
        ),
      ),
    );
  }

  void deleteitem(Notes note) {
    if (note.title == "Business") {
      setState(() {
        Business--;
      });
    } else if (note.title == "Personal") {
      setState(() {
        Personal--;
      });
    } else if (note.title == "Programming") {
      setState(() {
        Programming--;
      });
    } else if (note.title == "Sports") {
      setState(() {
        Sports--;
      });
    } else if (note.title == "Family") {
      setState(() {
        Family--;
      });
    } else {
      Business = 0;
      Personal = 0;
      Programming = 0;
      Sports = 0;
      Family = 0;
    }

    note.delete();
  }

// TODO : Tasks Items ...
  Widget builditem(Notes item, IsSelected) {
    return CardTasks(
      Index: 1,
      onSelected: (tasks) async {
        setState(() {
          IsSelected
              ? all_selected_tasks.remove(item.description)
              : all_selected_tasks.add(item.description);
        });
        TaskerPreference.setStringList(all_selected_tasks);
      },
      isActive: IsSelected,
      taskuser: item,
    );
  }
}
