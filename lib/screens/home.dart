import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:accordion/accordion.dart';
import 'package:lightsup/screens/notes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

Color currentColor = Color(0xff45C5BD);
Color pickerColor = Color(0xff45C5BD);

String email = "";
String roomId = "";
String from = "";
String toEmail = "";
List emailList = [];
String to = "";

class _HomeState extends State<Home> {
  bool _enableLabel = true;
  bool _portraitOnly = false;

  String noteMsg = "";
  getUser() async {
    email = await FirebaseAuth.instance.currentUser!.email!;

    await FirebaseFirestore.instance
        .collection('lightsUpUsers')
        .doc(email)
        .get()
        .then((value) {
      setState(() {
        roomId = value.data()!['room'];
      });
    }).then((value) {
      FirebaseFirestore.instance
          .collection('lightsUpNotes')
          .doc(roomId)
          .get()
          .then((value) {
        emailList = value.data()!['members'];
        print(
            "$emailList $roomId $email =====================================");
      });
    });
  }

  @override
  void initState() {
    super.initState();

    getUser();

    print(email);
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('lightsUpNotes');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.docChanges.forEach((change) {
        print(change);
      });
    });

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print("===================== $email");
    final _headerStyle = TextStyle(
        color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
    final _contentStyleHeader = TextStyle(
        color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
    final _contentStyle = TextStyle(
        color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

    void changeColor(Color color) => setState(() {
          pickerColor = color;
        });
    return Scaffold(
      // create some values
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: currentColor),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset('assets/frame.png', width: 100),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Notes()),
                        );
                      },
                      child: const CircleAvatar(
                        radius: 35.0,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.notes,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Image.asset('assets/desk.png', width: width - 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const CircleBorder(),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.lightbulb_outline,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 800,
                            width: width,
                            child: AlertDialog(
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: width - 150,
                                      alignment: Alignment.center,
                                      height: 470,
                                      child: ColorPicker(
                                        pickerColor: currentColor,
                                        onColorChanged: changeColor,
                                        portraitOnly: _portraitOnly,
                                      ),
                                    ),
                                    Container(
                                      width: width - 150,
                                      alignment: Alignment.center,
                                      height: 300,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Accordion(
                                              maxOpenSections: 1,
                                              headerPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 7,
                                                      horizontal: 15),
                                              children: [
                                                AccordionSection(
                                                  isOpen: false,
                                                  headerBackgroundColor:
                                                      Colors.black,
                                                  contentBorderColor:
                                                      Colors.black,
                                                  leftIcon: const Icon(
                                                      Icons.insights_rounded,
                                                      color: Colors.white),
                                                  header: Text('Add Note',
                                                      style: _headerStyle),
                                                  content: TextField(
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor:
                                                            Color.fromARGB(255,
                                                                218, 215, 215)),
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                    minLines: 1,
                                                    maxLines: 25,
                                                    onChanged: (e) {
                                                      setState(() {
                                                        noteMsg = e;
                                                      });
                                                    },
                                                  ),
                                                  contentHorizontalPadding: 20,
                                                  contentBorderWidth: 1,
                                                )
                                              ],
                                            ),
                                            TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.black),
                                              ),
                                              child: const Text('Done',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              onPressed: () async {
                                                await getUser();
                                                setState(() {
                                                  currentColor = pickerColor;
                                                  // // Navigator.pop(context);
                                                  print(
                                                      "to: $to from: $from room: $roomId");

                                                  // FirebaseFirestore.instance.collection('lightsUpNotes').doc()
                                                });

                                                if (emailList[0]['email'] ==
                                                    email) {
                                                  from = emailList[0]['name'];
                                                  to = emailList[1]['name'];
                                                } else {
                                                  to = emailList[0]['name'];
                                                  from = emailList[1]['name'];
                                                }

                                                Map data = {
                                                  'to': to,
                                                  'from': from,
                                                  'content': noteMsg
                                                };

                                                await FirebaseFirestore.instance
                                                    .collection('lightsUpNotes')
                                                    .doc(roomId)
                                                    .update({
                                                  'notes':
                                                      FieldValue.arrayUnion(
                                                          [data])
                                                }).then((value) {
                                                  Navigator.pop(context);
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
