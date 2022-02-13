import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lightsup/auth/register.dart';
import 'package:lightsup/screens/home.dart';

class Room extends StatefulWidget {
  // Room(this.email);
  final String email;
  const Room(this.email, {Key? key}) : super(key: key);

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  String code = "", newcode = "";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          color: Color.fromRGBO(207, 223, 224, 1),
          child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        "enter your super secret code",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(237, 255, 253, 253),
                              borderRadius: BorderRadius.circular(10)),
                          height: 60,
                          width: width,
                          child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: TextField(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: "code"),
                                    onChanged: (e) {
                                      code = e;
                                    }),
                              ))),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("lightsUpNotes")
                              .doc(code)
                              .update({
                            'members': FieldValue.arrayUnion([
                              {"email": em, "name": nm}
                            ])
                          }).then((value) => {
                                    FirebaseFirestore.instance
                                        .collection('lightsUpUsers')
                                        .doc(em)
                                        .update({'room': code}).then((value) =>
                                            {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Home()))
                                            })
                                  });
                        },
                        height: 50,
                        minWidth: 200,
                        color: Color.fromARGB(255, 235, 121, 93),
                        child: Text("let's go!"),
                      ),
                    ],
                  ),
                  Text("or"),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        "generate new code",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(237, 255, 253, 253),
                              borderRadius: BorderRadius.circular(10)),
                          height: 60,
                          width: width,
                          child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: TextField(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: "new code"),
                                    onChanged: (e) {
                                      newcode = e;
                                    }),
                              ))),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          print("doc is $newcode");
                          await FirebaseFirestore.instance
                              .collection("lightsUpNotes")
                              .doc(newcode)
                              .set({
                            'members': [
                              {"email": em, "name": nm}
                            ],
                            'notes': []
                          }).then((value) => {
                                    FirebaseFirestore.instance
                                        .collection('lightsUpUsers')
                                        .doc(em)
                                        .update({'room': newcode}).then(
                                            (value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()));
                                    })
                                  });
                        },
                        height: 50,
                        minWidth: 200,
                        color: Color.fromARGB(255, 235, 121, 93),
                        child: Text("let's go!"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ))),
    );
  }
}
