import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/widgets/outlined_icon.dart';
import 'package:to_do_app/widgets/todo_item.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];
  final _myBox = Hive.openBox('myBox');
  final ToDoDatabase toDoDataBase = ToDoDatabase();

  @override
  void initState() {
    // Заполняем список поиска списком todoList
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      // Аппбар для бургер меню
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            // Отступ от аппбара
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              children: [
                // Строка поиска
                _searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
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
                    _addToDoItem(_todoController.text);
                  },
                ),
              ),
            ]),
          )
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          OutlinedIcon(Icons.person, color: tdTeal),
          OutlinedIcon(Icons.add_circle_outline, color: tdTeal),
          OutlinedIcon(Icons.settings, color: tdTeal),
        ],
        backgroundColor: tdBGColor,
        color: Color.fromARGB(255, 248, 216, 75),
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDo(int id) {
    setState(() {
      todoList.removeWhere((element) => element.id == id);
    });
  }

  void _addToDoItem(String todo) {
    setState(() {
      int lastIdTodo = todoList.last.id!;
      var todoNewItem = ToDo(id: lastIdTodo + 1, todoText: todo);
      todoList.add(todoNewItem);
      // print(todoNewItem.id!);
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      // Функция поиска введенного слова
      results = todoList
          .where((element) =>
              element.todoText!.toLowerCase().contains(enteredKeyword))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
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
          child: TextField(
            onChanged: (value) => _runFilter(value),
            decoration: const InputDecoration(
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
