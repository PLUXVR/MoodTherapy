import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/data/boxes.dart';
import 'package:to_do_app/core/model/todo.dart';
import 'package:to_do_app/feature/app/app.dart';

void main() async {
  //Инициализируем Hive ассинхронно
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  // Открываем коробку и даем ей название
  boxToDo = await Hive.openBox<ToDo>('boxtodo');
  
  runApp(const Application());
}
