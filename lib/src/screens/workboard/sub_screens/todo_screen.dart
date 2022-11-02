import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:knowledge_one/src/screens/workboard/providers/todo_controller.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Todos",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: Colors.grey[200]!, width: 2))),
        child: DragAndDropLists(
            axis: Axis.horizontal,
            listWidth: 250,
            listDraggingWidth: 250,
            listDecoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(7.0)),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black45,
                  spreadRadius: 3.0,
                  blurRadius: 6.0,
                  offset: Offset(2, 3),
                ),
              ],
            ),
            listPadding: const EdgeInsets.all(8.0),
            children: context
                .watch<TodoController>()
                .todoItems
                .map((e) => _buildColumn(e))
                .toList(),
            onItemReorder: _onItemReorder,
            onListReorder: _onListReorder),
      ),
    );
  }

  DragAndDropList _buildColumn(TodoItem<BaseItemDetails> item) {
    return DragAndDropList(
      header: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(7.0)),
                color: Colors.pink,
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                item.columnName,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
      footer: Container(
          width: 250,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(7.0)),
            color: Colors.pink,
          ),
          height: 40,
          child: IconButton(
            tooltip: "添加一个日程",
            onPressed: () {},
            icon: const Icon(Icons.add_box),
          )),
      leftSide: const VerticalDivider(
        color: Colors.pink,
        width: 1.5,
        thickness: 1.5,
      ),
      rightSide: const VerticalDivider(
        color: Colors.pink,
        width: 1.5,
        thickness: 1.5,
      ),
      children: item.todos.map((e) => _buildItem(e.content)).toList(),
    );
  }

  DragAndDropItem _buildItem(String item) {
    return DragAndDropItem(
      child: ListTile(
        title: Text(
          item,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    context
        .read<TodoController>()
        .moveColumnItem(oldItemIndex, oldListIndex, newItemIndex, newListIndex);
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    context.read<TodoController>().moveColumn(oldListIndex, newListIndex);
  }
}
