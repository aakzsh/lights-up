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

class _HomeState extends State<Home> {
  bool _enableLabel = true;
  bool _portraitOnly = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final _headerStyle = TextStyle(
        color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
    final _contentStyleHeader = TextStyle(
        color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
    final _contentStyle = TextStyle(
        color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
    final _loremIpsum =
        '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';

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
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Notes()),
                    );
                  },
                  child: Text("data")),
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
                                      height: 465,
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
                                                  content: const TextField(
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
                                                    maxLines: 5,
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
                                              onPressed: () {},
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
