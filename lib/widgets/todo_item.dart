import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_app/constants/colors.dart';

class ToDoItem extends StatelessWidget {
  const ToDoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: const Icon(
          Icons.check_box,
          color: tdBlue,
        ),
        title: Text(
          'Нарисовать схему городка в Visio',
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              decoration: TextDecoration.lineThrough),
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
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
