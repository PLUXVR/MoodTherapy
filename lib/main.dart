import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/data/boxes.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/widgets/bottomNavigationBar.dart';

void main() async {
  //Инициализируем Hive ассинхронно
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  // открываем коробку
  boxToDo = await Hive.openBox<ToDo>('toDoBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BottomNavBar(),
    );
  }
}
