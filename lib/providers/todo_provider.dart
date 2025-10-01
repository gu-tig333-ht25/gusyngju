import 'package:flutter_riverpod/legacy.dart';
import 'package:template/api/todo_api.dart';
import 'package:template/models/todo.dart';

class ToDoNotifier extends StateNotifier<List<ToDo>> {
  final TodoApi _api;

  ToDoNotifier(this._api) : super([]) {
    _loadFromAPI();
  }

  /// Private async method to fetch todos after initialization
  Future<void> _loadFromAPI() async {
    final todos = await _api.readToDos();
    state = todos;
  }

  void add(String title) async {
    // Call API, responds with new list
    state = await _api.createToDo(title);
  }

  void remove(String id) async {
    // Call API, then remove as before
    state = await _api.deleteToDo(id);
  }

  void toggleDone(ToDo todo) async {
    // Call update
    state = await _api.updateToDo(
      ToDo(id: todo.id, title: todo.title, complete: !todo.complete),
    );
  }
}

final todoProvider = StateNotifierProvider<ToDoNotifier, List<ToDo>>((ref) {
  throw UnimplementedError(); // overridden in main()
});
