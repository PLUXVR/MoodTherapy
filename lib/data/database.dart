import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  // ссылка на бокс
  final _myBox = Hive.openBox('myBox');
}
