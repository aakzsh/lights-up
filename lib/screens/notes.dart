import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final PageController controller = PageController();
    return Scaffold(
      body: PageView(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        controller: controller,
        children: <Widget>[
          Center(
            child: Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/page.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                    child: Text(
                        "man its been weird bjnikjkol man its been weird bjnikjkol man its been weird bjnikjkol man its been weird bjnikjkol",
                        style: GoogleFonts.shadowsIntoLight(
                            textStyle: Theme.of(context).textTheme.headline4)),
                  ),
                )),
          ),
          Center(
            child: Text('Second Page'),
          ),
          Center(
            child: Text('Third Page'),
          )
        ],
      ),
    );
  }
}
