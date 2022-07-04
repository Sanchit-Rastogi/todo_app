import '../../models/todo.dart';

abstract class ITodo {
  Future<bool> addTodo(TodoModel todo);

  Future<bool> updateTodo(TodoModel todo);

  Future<bool> deleteTodo(int id);

  Future<List<TodoModel>> loadTodo();
}
