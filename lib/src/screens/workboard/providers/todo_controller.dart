import 'package:flutter/material.dart';
import 'package:knowledge_one/src/screens/workboard/models/models.dart';

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

class TodoController extends ChangeNotifier {
  List<TodoItem<BaseItemDetails>> todoItems = [];

  // 初始化列表
  init() async {
    todoItems.add(TodoItem(
        columnName: "test",
        todos: [
          BaseItemDetails(
              index: 0,
              status: ItemDetailsStatus.delay,
              content: "测试1",
              from: DateTime.now(),
              to: DateTime.now()),
          BaseItemDetails(
              index: 1,
              status: ItemDetailsStatus.delay,
              content: "测试2",
              from: DateTime.now(),
              to: DateTime.now())
        ],
        index: 1,
        deletable: true));
    todoItems.add(TodoItem(
        columnName: "已完成",
        todos: [
          BaseItemDetails(
              index: 0,
              status: ItemDetailsStatus.delay,
              content: "完成1",
              from: DateTime.now(),
              to: DateTime.now()),
          BaseItemDetails(
              index: 1,
              status: ItemDetailsStatus.delay,
              content: "完成2",
              from: DateTime.now(),
              to: DateTime.now())
        ],
        index: 0,
        deletable: false));
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
