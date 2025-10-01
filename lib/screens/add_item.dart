import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template/models/todo.dart';
import 'package:template/providers/todo_provider.dart';

class AddItemScreen extends ConsumerStatefulWidget {
  const AddItemScreen({super.key, required this.title});

  final String title;

  @override
  ConsumerState<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends ConsumerState<AddItemScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "What are you going to do?",
                border: OutlineInputBorder(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: TextButton.icon(
                onPressed: () {
                  String title = controller.text.trim();
                  if (title.isNotEmpty) {
                    ref.read(todoProvider.notifier).add(title);
                    Navigator.pop(context);
                  }
                },
                label: Text(
                  "ADD",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,

                    color: Theme.of(context).primaryColor,
                  ),
                ),
                icon: Icon(
                  Icons.add,
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
