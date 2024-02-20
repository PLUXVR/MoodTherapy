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

  // static List<ToDo> todoList() {
  //   return [
  //     ToDo(id: 01, todoText: 'Созвониться по Мавлинку', isDone: true),
  //     ToDo(id: 02, todoText: 'Спорт в спортзале'),
  //     ToDo(id: 03, todoText: 'Чтение книги с утра'),
  //     ToDo(id: 04, todoText: 'Нарисовать макет городка №5'),
  //     ToDo(
  //         id: 05,
  //         todoText: 'Поблагодарить за блага, которые имеешь сегодня',
  //         isDone: true),
  //   ];
  // }
}
