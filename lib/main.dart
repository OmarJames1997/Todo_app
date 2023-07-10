import 'package:flutter/material.dart';
import 'package:todo_app_g02/screens/layout_screen.dart';
import 'package:todo_app_g02/shared/palette.dart';

void main() {
  runApp(const MyApp());
}

///local and remote database

/// 1 - local database
///     * sqflite
///     * shared preferences

/// 2- remote database
///    * apis
///    * firebase

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
       scaffoldBackgroundColor: AppColors.primaryBlack,
        primarySwatch: Colors.blue,
      ),
      home: LayoutScreen(),
    );
  }
}

