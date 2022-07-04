import '../../db/todo_db.dart';
import '../../models/todo.dart';

class TodoProvider {
  Future<bool> addTodo(TodoModel todo) async {
    try {
      await TodoDatabase.instance.create(todo);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateTodo(TodoModel todo) async {
    try {
      await TodoDatabase.instance.update(todo);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      await TodoDatabase.instance.delete(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<TodoModel>> loadTodo() async {
    try {
      return await TodoDatabase.instance.readAllTodo();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
