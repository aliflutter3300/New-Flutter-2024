import 'package:cute/Login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'Login': (context) => MYLogin(),
      },
    ),
  );
}
