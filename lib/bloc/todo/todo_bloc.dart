import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/todo/todo_event.dart';
import 'package:to_do_app/bloc/todo/todo_state.dart';
import 'package:to_do_app/data/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;

  TodoBloc({required TodoRepository todoRepository})
      : _todoRepository = todoRepository,
        super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<SearchTodos>(_onSearchTodos);
    on<InitializeDefaultTodos>(_onInitializeDefaultTodos);
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final todos = _todoRepository.getAllTodos();
      emit(TodoLoaded(todos: todos, filteredTodos: todos));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      try {
        await _todoRepository.addTodo(event.todo);
        final todos = _todoRepository.getAllTodos();
        emit((state as TodoLoaded).copyWith(
          todos: todos,
          filteredTodos: todos,
        ));
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    }
  }

  Future<void> _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      try {
        await _todoRepository.updateTodo(event.todo);
        final todos = _todoRepository.getAllTodos();
        final currentState = state as TodoLoaded;
        
        // Maintain the current search filter
        final filteredTodos = currentState.filteredTodos.isEmpty
            ? todos
            : _todoRepository.searchTodos(''); // Reset search or maintain filter
            
        emit(currentState.copyWith(
          todos: todos,
          filteredTodos: filteredTodos,
        ));
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    }
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      try {
        await _todoRepository.deleteTodo(event.id);
        final todos = _todoRepository.getAllTodos();
        emit((state as TodoLoaded).copyWith(
          todos: todos,
          filteredTodos: todos,
        ));
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    }
  }

  Future<void> _onSearchTodos(SearchTodos event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      try {
        final filteredTodos = _todoRepository.searchTodos(event.query);
        emit((state as TodoLoaded).copyWith(
          filteredTodos: filteredTodos,
        ));
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    }
  }

  Future<void> _onInitializeDefaultTodos(
      InitializeDefaultTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      await _todoRepository.initializeDefaultTodos();
      final todos = _todoRepository.getAllTodos();
      emit(TodoLoaded(todos: todos, filteredTodos: todos));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  int getNextId() {
    return _todoRepository.getNextId();
  }
}
