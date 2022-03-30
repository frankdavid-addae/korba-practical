import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
