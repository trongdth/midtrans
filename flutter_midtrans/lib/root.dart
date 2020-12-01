import 'package:flutter/material.dart';
import 'package:flutter_midtrans/screens/home.dart';

class Root extends StatefulWidget {
  final String showCase;
  const Root({this.showCase, Key key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
