import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lightsup/auth/room.dart';
import 'package:lightsup/screens/home.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

String em = "";

class _RegisterState extends State<Register> {
  ImagePicker picker = ImagePicker();

  String email = "";
  String password = "";
  String name = "";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            height: height,
            width: width,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(207, 223, 224, 1)),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Get Started",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w500),
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
                                        hintText: "name"),
                                    onChanged: (e) {
                                      name = e;
                                    }),
                              ))),
                      SizedBox(
                        height: 30,
                      ),
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
                                        hintText: "email"),
                                    onChanged: (e) {
                                      email = e;
                                    }),
                              ))),
                      SizedBox(
                        height: 20,
                      ),
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
                                    obscureText: true,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: "password"),
                                    onChanged: (e) {
                                      password = e;
                                    }),
                              ))),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                          height: 50,
                          minWidth: 200,
                          color: Color.fromARGB(255, 235, 121, 93),
                          child: Text("register"),
                          onPressed: () async {
                            setState(() {
                              em = email;
                            });
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
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Room(email)),
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
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )));
  }
}
