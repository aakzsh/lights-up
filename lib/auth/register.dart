import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lightsup/screens/home.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = "";
  String password = "";
  String name = "";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(color: Color.fromRGBO(207, 223, 224, 1)),
      child: Column(
        children: <Widget>[
          Text("Get Started"),
          TextField(
              decoration: const InputDecoration(hintText: "name"),
              onChanged: (e) {
                name = e;
              }),
          TextField(
              decoration: const InputDecoration(hintText: "email"),
              onChanged: (e) {
                email = e;
              }),
          TextField(
              decoration: const InputDecoration(hintText: "password"),
              onChanged: (e) {
                password = e;
              }),
          MaterialButton(
              child: Text("login"),
              onPressed: () async {
                await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: password)
                    .then((result) {
                  FirebaseFirestore.instance
                      .collection("lightsUpUsers")
                      .doc(email)
                      .set({
                    'name': name,
                  }).then((value) => {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            )
                          });
                }).catchError((err) {
                  print(err.message);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text(err.message),
                          actions: [
                            TextButton(
                              child: Text("okay"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                });
              })
        ],
      ),
    );
  }
}
