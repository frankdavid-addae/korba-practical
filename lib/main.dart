import 'package:flutter/material.dart';

void main() {
  runApp(const KorbaPracticalApp());
}

class KorbaPracticalApp extends StatelessWidget {
  const KorbaPracticalApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Korba Practical',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Home Page',
          style: TextStyle(
            color: Colors.black,
            fontSize: 32.0,
          ),
        ),
      ),
    );
  }
}
