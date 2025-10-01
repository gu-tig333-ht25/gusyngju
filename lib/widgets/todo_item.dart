import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/models/todo.dart';
import 'package:template/providers/todo_provider.dart';

class ToDoItem extends ConsumerWidget {
  final ToDo todo;
  const ToDoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
          child: Row(
            children: [
              Checkbox(
                value: todo.complete,
                onChanged: (value) =>
                    ref.read(todoProvider.notifier).toggleDone(todo),
              ),
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
                onPressed: () {
                  ref.read(todoProvider.notifier).remove(todo.id);
                },
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
