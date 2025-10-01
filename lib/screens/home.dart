import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/models/todo.dart';
import 'package:template/providers/todo_provider.dart';
import 'package:template/screens/manage_item.dart';
import 'package:template/widgets/todo_item.dart';

enum FilterOption { all, done, todo }

class MyHomePage extends ConsumerStatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  FilterOption activeFilter = FilterOption.values.first; // Default to all

  bool _hintShown = false;

  Future<void> _loadHintShown() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      _hintShown = preferences.getBool("hintShown") ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadHintShown(); // fire async loader
  }

  void _addItem() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ManageItemScreen(title: widget.title),
      ),
    );
  }

  void _maybeShowHint(List<ToDo> todos) async {
    if (_hintShown) return;

    if (todos.isNotEmpty) {
      _hintShown = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Tip"),
            content: const Text("You can tap on a todo item to edit it."),
            actions: [
              TextButton(
                onPressed: () async {
                  final preferences = await SharedPreferences.getInstance();
                  preferences.setBool("hintShown", true);
                  Navigator.pop(context);
                },
                child: const Text("Got it"),
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ToDo> toDoList = ref.watch(todoProvider);

    // Show the hint only once when there’s at least one todo
    _maybeShowHint(toDoList);

    List<ToDo> toDoListToDisplay = activeFilter == FilterOption.done
        ? toDoList.where((item) => item.complete).toList()
        : activeFilter == FilterOption.todo
        ? toDoList.where((item) => !item.complete).toList()
        : toDoList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          PopupMenuButton<FilterOption>(
            initialValue: activeFilter,
            onSelected: (FilterOption item) {
              setState(() {
                activeFilter = item;
              });
            },
            icon: Icon(
              Icons.more_vert_rounded,
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
            tooltip: "Select filter",
            itemBuilder: (context) => FilterOption.values.map((option) {
              return PopupMenuItem<FilterOption>(
                value: option,
                child: Text(option.name),
              );
            }).toList(),
          ),
        ],
      ),
      body: Center(
        child: Expanded(
          child: ListView.builder(
            itemCount: toDoListToDisplay.length,
            itemBuilder: (context, index) =>
                ToDoItem(todo: toDoListToDisplay.elementAt(index)),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        tooltip: 'Add item ToDo',
        shape: CircleBorder(),
        child: Icon(Icons.add, size: 50, color: Theme.of(context).primaryColor),
      ),
    );
  }
}
