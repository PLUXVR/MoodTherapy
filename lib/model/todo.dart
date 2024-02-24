import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class ToDo {
  ToDo({required this.id, required this.todoText, this.isDone = false});

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? todoText;
  @HiveField(2)
  bool isDone;

  @override
  String toString() {
    return "$id $todoText $isDone";
  }
}
