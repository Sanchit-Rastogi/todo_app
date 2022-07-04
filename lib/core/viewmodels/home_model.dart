import 'package:flutter/material.dart';
import 'package:todo_assign/core/models/todo.dart';

import '../../locator.dart';
import '../services/providers/todo_provider.dart';

class HomeModel extends ChangeNotifier {
  int gridCount = 1;
  List<TodoModel> todos = [];
  var todoProvider = locator<TodoProvider>();

  void updateDurationLeft(int duration, int todoId) {
    for (var element in todos) {
      if (element.id == todoId) {
        element.duration = duration.toString();
        break;
      }
    }
    notifyListeners();
  }

  void updateTodoDurationInDB() async {
    for (var element in todos) {
      await todoProvider.updateTodo(element);
    }
  }

  void getAllTodos() async {
    todos = await todoProvider.loadTodo();
    notifyListeners();
  }

  void updateTodo(TodoModel todo) async {
    await todoProvider.updateTodo(todo);
    getAllTodos();
  }

  void alterGridCount() {
    gridCount = gridCount == 1 ? 2 : 1;
    notifyListeners();
  }

  void deleteTodo(TodoModel todo) async {
    await todoProvider.deleteTodo(todo.id!);
    getAllTodos();
  }
}
