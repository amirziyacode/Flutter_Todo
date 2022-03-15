import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_todo/pages/note_task.dart';
import 'package:page_transition/page_transition.dart';
import '../Animation/fadeAnimation.dart';
import '../data/shared/Task_saved.dart';
import '../data/tasks.dart';
import '../Animation/linearprogress.dart';
import '../data/time_say.dart';
import '../db/notes_database.dart';
import '../model/note.dart';
import 'button_change_them.dart';
import 'card_tasks.dart';

class MyHomePage extends StatefulWidget {
  VoidCallback opendrawer;
  MyHomePage({required this.opendrawer});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> all_selected_tasks = []; // your tasks

  List<Note> notes = []; // get info from Database and add to this list

  bool isLoading = false; 


  @override
  void initState() {
    // TODO: implement initState
    all_selected_tasks = TaskerPreference.getString() ?? []; 
    super.initState();
    refreshNote();
  }

  @override
  void dispose() {
    // TODO: close Database of Note ...
    NotesDatabase.instance.close();
    super.dispose();
  }

  // Todo for load notd from Database ..
  Future refreshNote() async {
    setState(() => true);
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() => false);
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
      body: SizedBox(
        width: we,
        height: he,
        child: Column(
          children: [
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
                child: ListView.builder(
                 physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Card(
                      margin: const EdgeInsets.only(left: 23),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
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
                              "${notes.length.toString()} tasks",
                              style: TextStyle(
                                  color: Colors.grey.withOpacity(0.9)),
                            ),
                            SizedBox(
                              height: he * 0.01,
                            ),
                            Text(
                              tasklist[i].title,
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
                                  value: notes.length.toDouble(),
                                  Color: tasklist[i].progresscolor,
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: tasklist.length,
                ),
              ),
            ),
            SizedBox(
              height: he * 0.04,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 15, bottom: 15),
              child: Text(
                "TODAY'S TASKS",
                style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.grey.withOpacity(0.8),
                    fontSize: 13),
              ),
            ),
            FadeAnimation(
                delay: 1,
                child: SizedBox(
                    width: we * 0.9,
                    height: he * 0.4,
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : notes.isEmpty
                            ? Container(
                                margin:
                                    const EdgeInsets.only(left: 130, top: 120),
                                child: Text("No Tasks",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor,
                                    )))
                            : ListView(
                               physics: const BouncingScrollPhysics(),
                                children: notes.map((note) {
                                final IsSelected = all_selected_tasks
                                    .contains(note.description);

                                return Slidable(
                                    endActionPane: ActionPane(
                                      // A motion is a widget used to control how the pane animates.
                                      motion: const StretchMotion(),

                                      // A pane can dismiss the Slidable.

                                      // All actions are defined in the children parameter.
                                      children: [
                                        // A SlidableAction can have an icon and/or a label.
                                        SlidableAction(
                                          onPressed: (context) async {
                                            NotesDatabase.instance
                                                .delete(note.id!);
                                            refreshNote();
                                          },
                                          backgroundColor: Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: "Delete",
                                        ),
                                        SlidableAction(
                                          onPressed: (context) async {
                                            await Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Note_Task(
                                                          note: note,
                                                        )));
                                            refreshNote();
                                          },
                                          backgroundColor: const Color(0xFF21B7CA),
                                          foregroundColor: Colors.white,
                                          label: "Edite",
                                          icon: Icons.edit,
                                        ),
                                      ],
                                    ),
                                    child: builditem(note, IsSelected));
                              }).toList()))),
          ],
        ),
      ),
      floatingActionButton: FadeAnimation(
        delay: 1.2,
        child: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context).push(PageTransition(
                type: PageTransitionType.fade, child: const Note_Task()));
            refreshNote();
          },
          backgroundColor:
              const FloatingActionButtonThemeData().backgroundColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }


  // TODO : Tasks Items ...
  Widget builditem(Note item, IsSelected) {
    return CardTasks(
      Index: item.id!,
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
