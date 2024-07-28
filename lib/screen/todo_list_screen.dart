import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/constant.dart';
import 'package:todo_app/widget/custom_alert_dialog.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(Constants.appName),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          for (final todo in todos)
      CheckboxListTile(
              title: Text(
                todo.description,
                style: TextStyle(
                  decoration: todo.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(
                todo.isCompleted ? 'Completed' : 'pending',
                style: TextStyle(
                  color: todo.isCompleted ? AppColors.completedTaskColor: AppColors.appColorRed,
                ),
              ),
              value: todo.isCompleted,
              onChanged: (bool? value) {
                ref.read(todoListProvider.notifier).toggle(todo.id);
              },
              secondary: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final confirmDelete = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        useTitleColor: true,
                        title: 'Warning',
                        content: const Text('Are you sure you want to delete this task?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text('No',style:TextStyle(color: AppColors.appColorRed)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmDelete == true) {
                    ref.read(todoListProvider.notifier).remove(todo.id);
                  }
                },
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final description = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              final textController = TextEditingController();

              return CustomAlertDialog(
                title: Constants.addTodo,
                content: TextField(
                  controller: textController,
                  decoration: const InputDecoration(hintText: Constants.enterDescription),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog without adding
                    },
                    child: const Text('Cancel',style:TextStyle(color: AppColors.appColorRed)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(textController.text);
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );

          if (description != null && description.isNotEmpty) {
            ref.read(todoListProvider.notifier).add(description);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
