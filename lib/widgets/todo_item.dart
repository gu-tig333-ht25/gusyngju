import 'package:flutter/material.dart';
import 'package:template/models/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  const ToDoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
          child: Row(
            children: [
              Checkbox(value: todo.complete, onChanged: null),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    todo.title,
                    style: todo.complete
                        ? Theme.of(context).textTheme.headlineSmall?.copyWith(
                            decoration: TextDecoration.lineThrough,
                          )
                        : Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.close,
                  size: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        Divider(color: Theme.of(context).dividerColor),
      ],
    );
  }
}
