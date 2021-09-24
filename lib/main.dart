import 'package:flutter/material.dart';
import 'package:heartful/welcome.dart';

void main() {
  runApp(HeartfulApp());
}

class HeartfulApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heartful',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Color(0xFFcc0701),
      ),
      home: Welcome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
