import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

Color currentColor = Color(0xff45C5BD);

class _HomeState extends State<Home> {
  bool _enableLabel = true;
  bool _portraitOnly = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    void changeColor(Color color) => setState(() {
          currentColor = color;
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
                    CircleAvatar(
                      radius: 35.0,
                      backgroundImage: AssetImage('assets/avatar.png'),
                      backgroundColor: Colors.black12,
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
                      shape: CircleBorder(),
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
                          return AlertDialog(
                            titlePadding: const EdgeInsets.all(0),
                            contentPadding: const EdgeInsets.all(0),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: currentColor,
                                onColorChanged: changeColor,
                                portraitOnly: _portraitOnly,
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
