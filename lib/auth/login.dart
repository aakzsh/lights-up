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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
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
                      }),
                ],
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
