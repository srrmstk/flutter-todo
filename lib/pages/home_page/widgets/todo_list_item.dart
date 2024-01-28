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
    return ListTile(
      horizontalTitleGap: 0,
      contentPadding: EdgeInsets.zero,
      title: Text(todoItem.title),
      leading: Checkbox(
        value: todoItem.isDone,
        onChanged: (value) {
          onDoneChange(todoItem.id);
        },
      ),
      trailing: PopupMenuButton(
        onSelected: (MenuItem item) {
          switch (item) {
            case MenuItem.edit:
              onEdit(todoItem.id);
            case MenuItem.delete:
              onDelete(todoItem.id);
            default:
              break;
          }
        },
        itemBuilder: (context) => <PopupMenuEntry<MenuItem>>[
          const PopupMenuItem(
            value: MenuItem.edit,
            child: Text('Редактировать'),
          ),
          const PopupMenuItem(
            value: MenuItem.delete,
            child: Text('Удалить'),
          ),
        ],
      ),
    );
  }
}
