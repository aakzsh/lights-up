import 'package:flutter/material.dart';
import 'package:lightsup/auth/login.dart';
import 'package:lightsup/auth/register.dart';

class AuthHome extends StatefulWidget {
  const AuthHome({Key? key}) : super(key: key);

  @override
  _AuthHomeState createState() => _AuthHomeState();
}

class _AuthHomeState extends State<AuthHome> {
  Color clr = const Color.fromRGBO(141, 94, 164, 0.66);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(color: Color.fromRGBO(207, 223, 224, 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                child: Container(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          "assets/somfa.png",
                          width: width / 1.5,
                        )),
                    height: height / 2,
                    width: width,
                    decoration: BoxDecoration(
                        color: clr, borderRadius: BorderRadius.circular(20))),
                onTap: () {
                  setState(() {
                    if (clr == const Color.fromRGBO(141, 94, 164, 0.66)) {
                      clr = const Color.fromRGBO(255, 123, 123, 1);
                    } else {
                      clr = const Color.fromRGBO(141, 94, 164, 0.66);
                    }
                  });
                },
              )),
          Center(
            child: Container(
              child: Column(
                children: const <Widget>[
                  Text(
                    "Lights Up",
                    style: TextStyle(fontSize: 40),
                  ),
                  Center(
                      child: Text(
                    "feel the affection from your long distance loved ones",
                    // "subtitle baamzi karni hai idhar almost itne hee length ki",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text("login"),
                  minWidth: width / 2 - 20,
                  color: Colors.white,
                  height: 70,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()));
                  },
                  child: const Text("register"),
                  minWidth: width / 2 - 20,
                  // color: const Color.fromRGBO(217, 217, 217, 1),
                  color: Colors.white,
                  height: 70,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2,
          )
        ],
      ),
    ));
  }
}
