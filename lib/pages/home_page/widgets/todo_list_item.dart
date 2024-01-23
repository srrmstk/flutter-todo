import 'package:flutter/material.dart';
import 'package:todo/modules/todo/models/todo_item.dart';

enum MenuItem { edit, delete }

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    super.key,
    required this.todoItem,
    required this.onEdit,
    required this.onDelete,
  });

  final TodoItem todoItem;
  final Function(String) onEdit;
  final Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16),
      title: Text(todoItem.title),
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
