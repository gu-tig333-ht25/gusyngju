import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/models/todo.dart';
import 'package:template/providers/todo_provider.dart';
import 'package:template/screens/add_item.dart';
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

  void _addItem() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => AddItemScreen(title: widget.title),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ToDo> toDoList = ref.watch(todoProvider);

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
