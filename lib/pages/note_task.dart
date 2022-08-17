import 'package:flutter/material.dart';
import 'package:flutter_todo/Animation/fadeAnimation.dart';
import 'package:flutter_todo/db/noted.dart';
import 'package:flutter_todo/pages/Drawerhiden/hidendrawer.dart';
import 'package:flutter_todo/pages/note_form.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../main.dart';

enum SelectedColor { Business, School, Personal, Sports, Family }

class Note_Task extends StatefulWidget {
  final Notes note;

  const Note_Task({Key? key, required this.note}) : super(key: key);

  @override
  _Note_TaskState createState() => _Note_TaskState();
}

class _Note_TaskState extends State<Note_Task> {
  late String description;

  bool Ison = false;
  final _controller = TextEditingController();

  bool isactive = true;

  SelectedColor selected = SelectedColor.Business;
  // SelectedColor? title;

  String text = 'New Task';

  Color colorbutton = const Color(0xFF002FFF);

  @override
  void initState() {
    super.initState();
    description = widget.note.description;
    if (widget.note.title == "Business") {
      selected = SelectedColor.Business;
    } else if (widget.note.title == "Personal") {
      selected = SelectedColor.Personal;
    } else if (widget.note.title == "Sports") {
      selected = SelectedColor.Sports;
    } else if (widget.note.title == "School") {
      selected = SelectedColor.School;
    } else if (widget.note.title == "Family") {
      selected = SelectedColor.Family;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FD),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          child: Column(
            children: [
              FadeAnimation(
                delay: 0.2,
                child: Container(
                  margin: EdgeInsets.only(top: he * 0.05, left: we * 0.73),
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey[300], shape: BoxShape.circle),
                  child: Container(
                      width: 47,
                      height: 47,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffF4F6FD),
                      ),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 20,
                          ))),
                ),
              ),
              FadeAnimation(
                  delay: 0.3,
                  child: NoteFormWidget(
                      description: description,
                      onChangedDescription: (description) {
                        setState(() => this.description = description);
                      })),
              FadeAnimation(delay: 0.4, child: _buidTage()),
              SizedBox(height: he * 0.28),
              FadeAnimation(
                  delay: 0.4,
                  child: widget.note.description == ""
                      ? _buildButtonCreate(context)
                      : _buildButtonSave(context))
            ],
          ),
        ),
      ),
    );
  }

  // TODO Update button ...
  Widget _buildButtonCreate(BuildContext contex) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Container(
        width: we * 0.4,
        height: 50,
        margin: EdgeInsets.only(left: we * 0.45),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: colorbutton,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40))),
            onPressed: () {
              if (description.isNotEmpty & selected.toString().isNotEmpty) {
                List selects = selected.toString().split(".");
                addNote();
              } else {
                setState(() {
                  text = 'Filed';
                  colorbutton = Colors.red;
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: GoogleFonts.lato(color: Colors.white),
                ),
                SizedBox(
                  width: we * 0.03,
                ),
                const Icon(
                  Icons.expand_less_outlined,
                  color: Colors.white,
                )
              ],
            )));
  }

  // TODO Save button ..
  Widget _buildButtonSave(BuildContext contex) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Container(
      width: we * 0.4,
      height: 50,
      margin: EdgeInsets.only(left: we * 0.45),
      child: ElevatedButton(
          onPressed: () => updateNote(widget.note, description),
          style: ElevatedButton.styleFrom(
              primary: const Color(0xFF002FFF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Save",
                style: GoogleFonts.lato(color: Colors.white),
              ),
              SizedBox(
                width: we * 0.03,
              ),
              const Icon(
                Icons.edit,
                color: Colors.white,
              )
            ],
          )),
    );
  }

  Widget _buidTage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selected = SelectedColor.Business;
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: 90,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: selected == SelectedColor.Business
                            ? Colors.blue
                            : Colors.white,
                        width: selected == SelectedColor.Business ? 3 : 0),
                    color: selected == SelectedColor.Business
                        ? const Color(0xFFAC05FF).withOpacity(0.6)
                        : Colors.grey.withOpacity(0.5)),
                child: const Text(
                  'Business',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selected = SelectedColor.Personal;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 14),
                alignment: Alignment.center,
                width: 90,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: selected == SelectedColor.Personal
                            ? Colors.blue
                            : Colors.white,
                        width: selected == SelectedColor.Personal ? 3 : 0),
                    color: selected == SelectedColor.Personal
                        ? const Color(0xFF0011FF).withOpacity(0.6)
                        : Colors.grey.withOpacity(0.5)),
                child: const Text(
                  'Personal',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selected = SelectedColor.Sports;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 14),
                alignment: Alignment.center,
                width: 90,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: selected == SelectedColor.Sports
                            ? Colors.blue
                            : Colors.white,
                        width: selected == SelectedColor.Sports ? 3 : 0),
                    color: selected == SelectedColor.Sports
                        ? Colors.red.withOpacity(0.6)
                        : Colors.grey.withOpacity(0.5)),
                child: const Text(
                  'Sports',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selected = SelectedColor.School;
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: 90,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: selected == SelectedColor.School
                            ? Colors.blue
                            : Colors.white,
                        width: selected == SelectedColor.School ? 3 : 0),
                    color: selected == SelectedColor.School
                        ? Colors.green.withOpacity(0.6)
                        : Colors.grey.withOpacity(0.5)),
                child: const Text(
                  'School',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selected = SelectedColor.Family;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 14),
                alignment: Alignment.center,
                width: 90,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: selected == SelectedColor.Family
                            ? Colors.blue
                            : Colors.white,
                        width: selected == SelectedColor.Family ? 3 : 0),
                    color: selected == SelectedColor.Family
                        ? Colors.orange.withOpacity(0.6)
                        : Colors.grey.withOpacity(0.5)),
                child: const Text(
                  'Family',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  // Todo add note in db
  Future addNote() async {
    List selects = selected.toString().split(".");
    final note = Notes(
      description: description,
      title: selects[1],
    );

    box.add(note);
    Navigator.of(context).push(PageTransition(
        child: HidenDrawer(
          animationtime: 0,
        ),
        type: PageTransitionType.fade));
  }

  // Todo update note in db
  Future updateNote(Notes note, String description) async {
    List selects = selected.toString().split(".");
    note.description = description;
    note.title = selects[1];
    note.save();
    Navigator.of(context).push(PageTransition(
        child: HidenDrawer(
          animationtime: 0,
        ),
        type: PageTransitionType.fade));
  }
}
