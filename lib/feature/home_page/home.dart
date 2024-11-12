import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/core/resources/constants/colors.dart';
import 'package:to_do_app/core/widgets/search_widget.dart';
import 'package:to_do_app/data/boxes.dart';
import 'package:to_do_app/core/model/todo.dart';
import 'package:to_do_app/core/widgets/default_appbar.dart';
import 'package:to_do_app/core/widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

// SingleTickerProviderStateMixin для AnimationController (vsync: this)
class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final _todoController = TextEditingController();
  late AnimationController _controller;
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    // Заполняем список поиска списком todoList
    _foundToDo = boxToDo.values.toList();
    print(_foundToDo);
    super.initState();
    // Объявляем контроллер для гибкой настройки анимации
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    // Повтор анимации после окончания Duration
    _controller.repeat();
  }

  @override
  void dispose() {
    // Контроллер необходимо удалять
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      // Аппбар для бургер меню
      appBar: DefaultAppBar(),
      body: Stack(
        children: [
          Container(
            // Отступ от аппбара
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              children: [
                // Строка поиска
                SearchWidget(filterFunction: _runFilter,),
                Expanded(
                  child: _foundToDo.isEmpty
                      ? Lottie.asset('assets/lottie/relax.json',
                          controller: _controller)
                      : ListView(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 50, bottom: 20),
                              child: const Text(
                                'Дела на день',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                            // Основная функция вывода о информации задач
                            for (ToDo todoItem in _foundToDo.reversed)
                              ToDoItem(
                                todo: todoItem,
                                onToDoChanged: _handleToDoChange,
                                onDeleteItem: _deleteToDo,
                              ),
                          ],
                        ),
                )
              ],
            ),
          ),

          // Строка ввода для задачи
          Align(
            // Расположение центр снизу
            alignment: Alignment.bottomCenter,
            // Его child является строка
            child: Row(children: [
              // 1 элемент контейнер с отступами и тенью по кругу
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                  left: 20,
                ),
                // Здесь задаем визуальное оформление
                // Отступ у текстового ввода
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0)
                  ],
                  // Закругление области ввода задачи
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _todoController,
                  decoration: const InputDecoration(
                      hintText: "Введите новую задачу",
                      border: InputBorder.none),
                ),
              )),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: tdGreen, borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                  color: Colors.white,
                  iconSize: 18,
                  icon: const Icon(
                    Icons.add,
                    size: 30,
                  ),
                  onPressed: () {
                    // Логика добавление элемента в бд
                    _addToDoItem(ToDo(
                        id: _foundToDo.isEmpty ? 0 : _foundToDo.last.id! + 1,
                        todoText: _todoController.text));
                  },
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      boxToDo.put("key_${todo.id}",
          ToDo(id: todo.id, todoText: todo.todoText, isDone: !todo.isDone));
    });
    _refreshItems();
  }

  void _deleteToDo(String id) {
    setState(() {
      boxToDo.delete(id);
      print(id);
    });

    _refreshItems();
  }

  void _addToDoItem(ToDo todo) {
    setState(() {
      boxToDo.put('key_${todo.id}', ToDo(id: todo.id, todoText: todo.todoText));
    });
    _todoController.clear();
    _refreshItems();
    print('key_${todo.id} ${todo.toString()}');
  }

  void _refreshItems() {
    setState(() {
      _foundToDo = boxToDo.values.toList();
      print(_foundToDo);
      // _foundToDo = [];
      // boxToDo.clear();
    });
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = boxToDo.values.toList();
    } else {
      // Функция поиска введенного слова
      results = boxToDo.values
          .toList()
          .where((element) =>
              element.todoText!.toLowerCase().contains(enteredKeyword))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  // Строка поиска
  
}
