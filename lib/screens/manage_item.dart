import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/models/todo.dart';
import 'package:template/providers/todo_provider.dart';

class ManageItemScreen extends ConsumerWidget {
  ManageItemScreen({super.key, required this.title, this.todo});

  final String title;
  final ToDo? todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    bool update = false;

    if (todo != null) {
      controller.text = todo!.title;
      update = true;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "What are you going to do?",
                border: OutlineInputBorder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: TextButton.icon(
                onPressed: () {
                  final text = controller.text.trim();
                  if (text.isNotEmpty) {
                    if (update) {
                      todo!.title = text;
                      ref.read(todoProvider.notifier).update(todo!);
                    } else {
                      ref.read(todoProvider.notifier).add(text);
                    }
                    Navigator.pop(context);
                  }
                },
                label: Text(
                  update ? "UPDATE" : "ADD",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                icon: Icon(
                  update ? Icons.done : Icons.add,
                  size: 22,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
