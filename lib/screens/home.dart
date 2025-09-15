import 'package:flutter/material.dart';
import 'package:template/models/todo.dart';
import 'package:template/screens/add_item.dart';
import 'package:template/widgets/todo_item.dart';

enum FilterOption { all, done, todo }

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FilterOption activeFilter = FilterOption.values.first; // Default to all

  List<ToDo> toDoList = [
    ToDo(title: "Write a book"),
    ToDo(title: "Do homework"),
    ToDo(title: "Tidy room", complete: true),
    ToDo(title: "Watch TV"),
    ToDo(title: "Nap"),
    ToDo(title: "Shop groceries"),
    ToDo(title: "Have fun"),
    ToDo(title: "Meditate"),
  ];

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
            itemCount: toDoList.length,
            itemBuilder: (context, index) =>
                ToDoItem(todo: toDoList.elementAt(index)),
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
