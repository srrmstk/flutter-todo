import 'package:flutter/material.dart';
import 'package:todo/modules/todo/models/todo_item.dart';

enum MenuItem { edit, delete }

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    required this.todoItem,
    required this.onEdit,
    required this.onDelete,
    required this.onDoneChange,
    super.key,
  });

  final TodoItem todoItem;
  final void Function(String) onEdit;
  final void Function(String) onDelete;
  final void Function(String) onDoneChange;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todoItem.id),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.all(16),
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
