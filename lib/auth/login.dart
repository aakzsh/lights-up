import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lightsup/screens/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";
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
            children: <Widget>[
              Text("Welcome Back"),
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
                        .signInWithEmailAndPassword(
                            email: email, password: password)
                        .then((result) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
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
        ),
      ),
    );
  }
}
