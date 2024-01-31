import 'package:flutter/material.dart';
import 'package:todo/modules/todo/models/todo_item.dart';

enum MenuItem { edit, delete }

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    super.key,
    required this.todoItem,
    required this.onEdit,
    required this.onDelete,
    required this.onDoneChange,
  });

  final TodoItem todoItem;
  final Function(String) onEdit;
  final Function(String) onDelete;
  final Function(String) onDoneChange;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todoItem.id),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(todoItem.id),
      child: ListTile(
        onTap: () => onEdit(todoItem.id),
        horizontalTitleGap: 0,
        contentPadding: EdgeInsets.zero,
        title: Text(todoItem.title),
        leading: Checkbox(
          value: todoItem.isDone,
          onChanged: (value) {
            onDoneChange(todoItem.id);
          },
        ),
      ),
    );
  }
}
