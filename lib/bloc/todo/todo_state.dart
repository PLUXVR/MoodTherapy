import 'package:equatable/equatable.dart';
import 'package:to_do_app/core/model/todo.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<ToDo> todos;
  final List<ToDo> filteredTodos;

  const TodoLoaded({
    required this.todos,
    required this.filteredTodos,
  });

  @override
  List<Object> get props => [todos, filteredTodos];

  TodoLoaded copyWith({
    List<ToDo>? todos,
    List<ToDo>? filteredTodos,
  }) {
    return TodoLoaded(
      todos: todos ?? this.todos,
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}

class TodoError extends TodoState {
  final String message;

  const TodoError(this.message);

  @override
  List<Object> get props => [message];
}
