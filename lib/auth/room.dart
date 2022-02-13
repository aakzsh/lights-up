import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lightsup/screens/home.dart';

class Room extends StatefulWidget {
  // Room(this.email);
  final String email;
  const Room(this.email, {Key? key}) : super(key: key);

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  Room? ro;
  String code = "", newcode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: <Widget>[
          Text("Enter room code to match with your mate"),
          TextField(
            onChanged: (text) {
              code = text;
            },
            decoration: InputDecoration(hintText: "code"),
          ),
          MaterialButton(
            child: Text("enter"),
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection("LightsUpNotes")
                  .doc(code)
                  .update({
                'members': FieldValue.arrayUnion([ro!.email])
              }).then((value) => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()))
                      });
            },
          ),
          Text("or"),
          Text("create new code"),
          TextField(
            decoration: InputDecoration(hintText: "new code"),
            onChanged: (value) {
              newcode = value;
            },
          ),
          MaterialButton(
            child: Text("enter"),
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection("LightsUpNotes")
                  .doc(newcode)
                  .set({
                'members': [ro!.email],
                'notes': []
              }).then((value) => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()))
                      });
            },
          ),
        ],
      )),
    );
  }
}
