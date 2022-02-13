import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lightsup/auth/register.dart';
import 'package:lightsup/screens/home.dart';
import 'package:vibration/vibration.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

List<dynamic>? notebaamzi;

class _NotesState extends State<Notes> {
  getData() async {
    print("here");
    print("jjjj");
    print("=================== $email");
    await FirebaseFirestore.instance
        .collection('lightsUpUsers')
        .doc(email)
        .get()
        .then((value) {
      print(value.data());
      FirebaseFirestore.instance
          .collection('lightsUpNotes')
          .doc(value.data()!['room'])
          .get()
          .then((value) => {
                setState(() {
                  print(value.data());
                  notebaamzi = value.data()!['notes'];
                  print("====================");
                  print(notebaamzi![0].toString());
                })
              });
    });
    // await
  }

  String sender = "Juliet";
  String receiver = "Romeo";

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // getData();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final PageController controller = PageController();
    return Scaffold(
      body: PageView(
        controller: controller,
        children:
            createNote(height, width, sender, receiver, notebaamzi, context),
      ),
    );
  }
}

List<Widget> createNote(height, width, sender, receiver, notebaamzi, context) {
  return List<Widget>.generate(notebaamzi.length, (int index) {
    return noteShow(
        height,
        width,
        notebaamzi[notebaamzi.length - index - 1]['from'],
        notebaamzi[notebaamzi.length - index - 1]['to'],
        notebaamzi[notebaamzi.length - index - 1]['content'],
        context);
  });
}

noteShow(height, width, sender, receiver, content, context) {
  return Center(
    child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/page.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Text("to $receiver, \n$content \n\nfrom $sender <3",
                style: GoogleFonts.shadowsIntoLight(
                    textStyle: Theme.of(context).textTheme.headline4)),
          ),
        )),
  );
}
