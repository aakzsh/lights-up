import 'package:flutter/material.dart';
import 'package:lightup/screens/home.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    String appName = "Lights Up";
    return MaterialApp(
      title: appName,
      home: const Home(),
    );
  }
}
