import 'package:to_do_app/core/model/todo.dart';
import 'package:to_do_app/data/boxes.dart';

class TodoRepository {
  static final List<ToDo> _defaultTodos = [
    ToDo(id: 1, todoText: 'Make your bed', isDone: false),
    ToDo(id: 2, todoText: 'Brush your teeth', isDone: false),
    ToDo(id: 3, todoText: 'Thank yourself for your efforts', isDone: false),
    ToDo(id: 4, todoText: 'Do breathing exercises', isDone: false),
    ToDo(id: 5, todoText: 'Do morning exercises', isDone: false),
    ToDo(id: 6, todoText: 'Have a proper breakfast', isDone: false),
    ToDo(id: 7, todoText: 'Write plans for the day', isDone: false),
    ToDo(id: 8, todoText: 'Go to the gym', isDone: false),
    ToDo(id: 9, todoText: 'Put away all gadgets an hour before sleep', isDone: false),
    ToDo(id: 10, todoText: 'Go to bed on time', isDone: false),
  ];

  List<ToDo> getAllTodos() {
    try {
      return boxToDo.values.toList();
    } catch (e) {
      throw Exception('Failed to load todos: $e');
    }
  }

  Future<void> addTodo(ToDo todo) async {
    try {
      await boxToDo.put('key_${todo.id}', todo);
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }

  Future<void> updateTodo(ToDo todo) async {
    try {
      await boxToDo.put('key_${todo.id}', todo);
    } catch (e) {
      throw Exception('Failed to update todo: $e');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await boxToDo.delete(id);
    } catch (e) {
      throw Exception('Failed to delete todo: $e');
    }
  }

  Future<void> initializeDefaultTodos() async {
    try {
      if (boxToDo.isEmpty) {
        for (final todo in _defaultTodos) {
          await boxToDo.put('key_${todo.id}', todo);
        }
      }
    } catch (e) {
      throw Exception('Failed to initialize default todos: $e');
    }
  }

  int getNextId() {
    final todos = getAllTodos();
    if (todos.isEmpty) return 1;
    return todos.map((e) => e.id ?? 0).reduce((a, b) => a > b ? a : b) + 1;
  }

  List<ToDo> searchTodos(String query) {
    final todos = getAllTodos();
    if (query.isEmpty) return todos;
    
    return todos.where((todo) {
      return todo.todoText?.toLowerCase().contains(query.toLowerCase()) ?? false;
    }).toList();
  }
}
