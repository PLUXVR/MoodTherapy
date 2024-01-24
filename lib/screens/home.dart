import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/widgets/todo_item.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final todoList = ToDo.todoList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      // Аппбар для бургер меню
      appBar: _buildAppBar(),
      body: Container(
        // Отступ от аппбара
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          children: [
            _searchBox(),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: const Text(
                      'Дела на день',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                  ),
                  for (ToDo todoItem in todoList)
                    ToDoItem(
                      todo: todoItem,
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Строка поиска
  Column _searchBox() {
    return Column(children: [
      Padding(
        // Горизонтальные отступы от краев экрана
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          // Отступ от края в текстовом поле
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: const TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(3),
                // Иконка лупы в строке поиска
                prefixIcon: Icon(
                  Icons.search,
                  color: tdBlack,
                  size: 20,
                ),
                prefixIconConstraints:
                    BoxConstraints(maxHeight: 20, minWidth: 25),
                // Отсутствие линии нижней грани
                border: InputBorder.none,
                hintText: 'Поиск',
                hintStyle: TextStyle(color: tdGrey)),
          ),
        ),
      )
    ]);
  }

  // Аппбар
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title:
          // Для строки добавить расстояние между элементами и прибить их тем самым по краям строки
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),

        // Контейнер для фото профиля
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            // Прежде чем использовать, необходимо прописать ссылку в pubspec
            child: Image.asset('assets/images/avatar.jpeg'),
          ),
        )
      ]),
    );
  }
}
