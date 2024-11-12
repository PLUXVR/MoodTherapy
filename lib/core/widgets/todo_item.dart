import 'package:flutter/material.dart';
import 'package:to_do_app/core/resources/constants/colors.dart';
import 'package:to_do_app/core/model/todo.dart';

class ToDoItem extends StatelessWidget {
  // todo обязательна для отображения элементов
  const ToDoItem({
    super.key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  });

  final ToDo todo;
  final Function onToDoChanged;
  final Function onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Отступ между to do item
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        // При нажатии выполняется функция onToDoChanged c аргументом todo
        onTap: () {
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(
          // Проверяем значение, если isDone == true - значок задачи будет помечен выполненным
          todo.isDone
              ? Icons.check_box
              : Icons.check_box_outline_blank_outlined,
          color: tdGreen,
        ),
        title: Text(
          // Текст будем брать из модели
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              // Подставляем значение из модели, если todo.isDone == true -  перечеркивается текст задачи
              decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
        // Квадрат красного цвета с правого края
        trailing: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              color: tdRed, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDeleteItem("key_${todo.id}");
            },
          ),
        ),
      ),
    );
  }
}
