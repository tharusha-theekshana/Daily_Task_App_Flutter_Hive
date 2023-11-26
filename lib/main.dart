import 'package:flutter/material.dart';
import 'package:task_app/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  await Hive.initFlutter("hive_boxes");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Task App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(220, 20, 60, 1.0),
          secondary: const Color.fromRGBO(210, 20, 60, 1.0),
        ),
      ),
    home: MyHomePage(),
    );
  }
}



