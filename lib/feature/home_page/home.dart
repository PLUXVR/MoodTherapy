import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/bloc/todo/todo_bloc.dart';
import 'package:to_do_app/bloc/todo/todo_event.dart';
import 'package:to_do_app/bloc/todo/todo_state.dart';
import 'package:to_do_app/core/resources/constants/colors.dart';
import 'package:to_do_app/core/model/todo.dart';
import 'package:to_do_app/core/widgets/default_appbar.dart';
import 'package:to_do_app/core/widgets/todo_item.dart';
import 'package:to_do_app/data/boxes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final _todoController = TextEditingController();
  final _searchController = TextEditingController();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _controller.repeat();
    
    // Load todos
    context.read<TodoBloc>().add(LoadTodos());
  }

  @override
  void dispose() {
    _controller.dispose();
    _todoController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _addTodo() {
    if (_todoController.text.isNotEmpty) {
      final todoBloc = context.read<TodoBloc>();
      final todo = ToDo(
        id: todoBloc.getNextId(),
        todoText: _todoController.text,
        isDone: false,
      );
      todoBloc.add(AddTodo(todo));
      _todoController.clear();
    }
  }

  void _handleToDoChange(ToDo todo) {
    final updatedTodo = ToDo(
      id: todo.id,
      todoText: todo.todoText,
      isDone: !todo.isDone,
    );
    context.read<TodoBloc>().add(UpdateTodo(updatedTodo));
  }

  void _deleteToDo(String id) {
    context.read<TodoBloc>().add(DeleteTodo(id));
  }

  void _runFilter(String enteredKeyword) {
    context.read<TodoBloc>().add(SearchTodos(enteredKeyword));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: DefaultAppBar(),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is TodoError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TodoBloc>().add(LoadTodos());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          
          if (state is TodoLoaded) {
            final todos = state.filteredTodos;
            
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                    children: [
                      _searchBox(),
                      Expanded(
                        child: todos.isEmpty
                            ? Lottie.asset(
                                'assets/lottie/relax.json',
                                controller: _controller,
                              )
                            : ListView(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 50, bottom: 20),
                                    child: const Text(
                                      'Tasks for today',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  for (ToDo todoItem in todos.reversed)
                                    ToDoItem(
                                      todo: todoItem,
                                      onToDoChanged: _handleToDoChange,
                                      onDeleteItem: _deleteToDo,
                                    ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
                _buildAddTodoInput(),
              ],
            );
          }
          
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }

  Widget _buildAddTodoInput() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 20,
                right: 20,
                left: 20,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _todoController,
                onSubmitted: (_) => _addTodo(),
                decoration: const InputDecoration(
                  hintText: "Enter new task",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 20,
              right: 20,
            ),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: tdGreen,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              color: Colors.white,
              iconSize: 18,
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: _addTodo,
            ),
          ),
        ],
      ),
    );
  }

  // void _handleToDoChange(ToDo todo) {
  //   setState(() {
  //     boxToDo.put("key_${todo.id}",
  //         ToDo(id: todo.id, todoText: todo.todoText, isDone: !todo.isDone));
  //   });
  //   _refreshItems();
  // }

  // void _deleteToDo(String id) {
  //   setState(() {
  //     boxToDo.delete(id);
  //     print(id);
  //   });

  //   _refreshItems();
  // }

  // void _addToDoItem(ToDo todo) {
  //   setState(() {
  //     boxToDo.put('key_${todo.id}', ToDo(id: todo.id, todoText: todo.todoText));
  //   });
  //   _todoController.clear();
  //   _refreshItems();
  //   print('key_${todo.id} ${todo.toString()}');
  // }

// Наполнение 10 задач
// void _addAllToDoItem(List<ToDo> todoList) async {
//   try {
//     final Map<dynamic, ToDo> todoMap = {
//       for (var todo in todoList) todo.id: todo
//     };
    
//     await boxToDo.putAll(todoMap);
    
//     setState(() {
//       _refreshItems();
//     });
    
//     print('Добавлены элементы: ${todoList.toString()}');
//   } catch (e) {
//     print('Ошибка при добавлении элементов: $e');
//   }
// }


  // void _refreshItems() {
  //   setState(() {
  //     _foundToDo = boxToDo.values.toList();
  //     print(_foundToDo);
  //     // _foundToDo = [];
  //     // boxToDo.clear();
  //   });
  // }

  // void _runFilter(String enteredKeyword) {
  //   List<ToDo> results = [];
  //   if (enteredKeyword.isEmpty) {
  //     results = boxToDo.values.toList();
  //   } else {
  //     // Функция поиска введенного слова
  //     results = boxToDo.values
  //         .toList()
  //         .where((element) =>
  //             element.todoText!.toLowerCase().contains(enteredKeyword))
  //         .toList();
  //   }
  //   setState(() {
  //     _foundToDo = results;
  //   });
  // }

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
}
