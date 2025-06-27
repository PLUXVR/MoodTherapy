import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/bloc/todo/todo_bloc.dart';
import 'package:to_do_app/bloc/todo/todo_event.dart';
import 'package:to_do_app/data/boxes.dart';
import 'package:to_do_app/core/model/todo.dart';
import 'package:to_do_app/data/todo_repository.dart';
import 'package:to_do_app/feature/app/app.dart';

void main() async {
  //Initialize Hive asynchronously
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  // Open the box
  boxToDo = await Hive.openBox<ToDo>('toDoBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(
        todoRepository: TodoRepository(),
      )..add(InitializeDefaultTodos()),
      child: const Application(),
    );
  }
}
