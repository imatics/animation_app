import 'dart:ui';

import 'package:animation_app/animated_close_icon_button.dart';
import 'package:animation_app/dashboard.dart';
import 'package:flutter/material.dart';

import 'delayed_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff44349e)),
        useMaterial3: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      home: const Dashboard(),
    );
  }
}

