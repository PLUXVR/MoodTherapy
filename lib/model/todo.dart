class ToDo {
  int? id;
  String? todoText;
  bool isDone;

  ToDo({required this.id, required this.todoText, this.isDone = false});

  static List<ToDo> todoList() {
    return [
      ToDo(id: 01, todoText: 'Созвониться по Мавлинку', isDone: true),
      ToDo(id: 02, todoText: 'Спорт в спортзале'),
      ToDo(id: 03, todoText: 'Чтение книги с утра'),
      ToDo(id: 04, todoText: 'Нарисовать макет городка №5'),
      ToDo(
          id: 05,
          todoText: 'Поблагодарить за блага, которые имеешь сегодня',
          isDone: true),
    ];
  }
}
