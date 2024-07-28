import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/model/todo_model.dart';




class TodoList extends StateNotifier<List<Todo>> {
  TodoList() : super([]);

  void add(String description) {
    state = [
      ...state,
      Todo(
        id: DateTime.now().toString(),
        description: description,
   
      ),
    ];
  }

  void remove(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            description: todo.description,
            isCompleted: !todo.isCompleted,
          )
        else
          todo,
    ];
  }
}

final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  return TodoList();
});
