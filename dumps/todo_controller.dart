import 'package:flutter/material.dart';
import 'package:knowledge_one/native.dart';

import '../models/todo_item_details.dart';

class TodoItem<BaseItemDetails> {
  bool deletable;
  String columnName;
  List<BaseItemDetails> todos;
  int index;
  TodoItem(
      {required this.columnName,
      required this.todos,
      required this.index,
      required this.deletable});
}

List<TodoItem<BaseItemDetails>> generateFromTodoDetails(
    List<TodoDetails> detailList) {
  List<TodoItem<BaseItemDetails>> result = [];
  List<int> taskIds = detailList.map((e) => e.taskId).toSet().toList();
  int count = 0;
  for (final i in taskIds) {
    List<TodoDetails> related =
        detailList.where((element) => element.taskId == i).toList();
    TodoItem<BaseItemDetails> todo = TodoItem(
        columnName: related.first.taskName!,
        todos: [],
        index: count,
        deletable: true);
    int todoCount = 0;
    for (final r in related) {
      todo.todos.add(BaseItemDetails(
          index: todoCount,
          status: r.todoStatusName!,
          content: r.todoContent ?? "未定义",
          from: DateTime.parse(r.todoFrom!),
          to: DateTime.parse(r.todoTo!)));
      todoCount++;
    }
    result.add(todo);
    count++;
  }

  return result;
}

class TodoController extends ChangeNotifier {
  List<TodoItem<BaseItemDetails>> todoItems = [];

  // 初始化列表
  init() async {
    List<TodoDetails> details = await api.getTodos();
    todoItems = generateFromTodoDetails(details);
    todoItems.insert(
        0, TodoItem(columnName: "已完成", todos: [], index: 0, deletable: false));
    for (int i = 0; i < todoItems.length; i++) {
      todoItems[i].index = i;
    }
    notifyListeners();
  }

  List<String> get todoColumnNames =>
      todoItems.map((e) => e.columnName).toList();

  addColumn(String columnName) {
    if (!todoColumnNames.contains(columnName)) {
      todoItems.add(TodoItem(
          columnName: "test",
          todos: [],
          index: todoColumnNames.length,
          deletable: true));
      notifyListeners();
    }
  }

  renameColumn(String newColumnName, int index) {
    todoItems[index].columnName = newColumnName;
    notifyListeners();
  }

  deleteColumn(int index) {
    if (todoItems[index].deletable) {
      todoItems.removeAt(index);
      notifyListeners();
    }
  }

  addItem(BaseItemDetails item, int index) {
    todoItems[index].todos.add(item);
    notifyListeners();
  }

  changeItem(BaseItemDetails item, int index, int itemIndex) {
    todoItems[index].todos[itemIndex] = item;
    notifyListeners();
  }

  doneItem(int itemIndex, int index) {
    todoItems[index].todos[itemIndex].markedAsDone();
    final t = todoItems[index].todos.removeAt(itemIndex);
    todoItems[0].todos.add(t);
    notifyListeners();
  }

  moveColumn(int index, int index2) {
    final l = todoItems.removeAt(index);
    todoItems.insert(index2, l);
    for (int i = 0; i < todoItems.length; i++) {
      todoItems[i].index = i;
    }
    notifyListeners();
  }

  moveColumnItem(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    var movedItem = todoItems[oldListIndex].todos.removeAt(oldItemIndex);
    todoItems[newListIndex].todos.insert(newItemIndex, movedItem);
    notifyListeners();
  }
}
