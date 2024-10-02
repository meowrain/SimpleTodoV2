import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteTodoFromTodoList,
  });

  final String taskName;
  final bool taskCompleted;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? deleteTodoFromTodoList;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTodoFromTodoList,
              icon: Icons.delete,
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
          decoration: BoxDecoration(
            color: taskCompleted
                ? colorScheme.primaryContainer.withOpacity(0.7)
                : colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: colorScheme.primary,
                checkColor: colorScheme.onPrimary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  taskName,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: taskCompleted
                        ? colorScheme.onSurface.withOpacity(0.6)
                        : colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
