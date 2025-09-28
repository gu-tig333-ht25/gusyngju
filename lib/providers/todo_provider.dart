import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:template/models/todo.dart';

class ToDoNotifier extends StateNotifier<List<ToDo>> {
  ToDoNotifier()
    : super([
        ToDo(title: "Write a book"),
        ToDo(title: "Do homework"),
        ToDo(title: "Tidy room", complete: true),
        ToDo(title: "Watch TV"),
        ToDo(title: "Nap"),
        ToDo(title: "Shop groceries"),
        ToDo(title: "Have fun"),
        ToDo(title: "Meditate"),
      ]);

  void add(ToDo todo) {
    state = [...state, todo];
  }

  void remove(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void toggleDone(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return ToDo(id: todo.id, title: todo.title, complete: !todo.complete);
      }
      return todo;
    }).toList();
  }
}

final todoProvider = StateNotifierProvider<ToDoNotifier, List<ToDo>>((ref) {
  return ToDoNotifier();
});
