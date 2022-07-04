// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:todo_assign/core/models/todo.dart';

import '../../locator.dart';
import '../services/providers/todo_provider.dart';

class AddModel extends ChangeNotifier {
  double duration = 600;

  void updateDuration(value) {
    duration = value;
    notifyListeners();
  }

  Future<bool> addTodoInDb(TodoModel todo) async {
    return await locator<TodoProvider>().addTodo(todo);
  }
}
