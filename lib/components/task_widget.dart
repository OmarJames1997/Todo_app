import 'package:flutter/material.dart';
import 'package:todo_app_g02/cubit/cubit.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key? key,
    this.onDone,
    this.onArchive,
    required this.task,
  }) : super(key: key);
  final Map<String, dynamic> task;
  final void Function()? onDone;
  final void Function()? onArchive;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        AppCubit.get(context).deleteFromDatabase(task["id"]);
      },
      background: Container(
        color: Colors.white,
        child: Container(
            height: 100,
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(
                  Icons.delete,
                  size: 30,
                  color: Colors.white,
                ),
              ],
            )),
      ),
      key: Key(task["id"].toString()),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  task["title"],
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                if (onDone != null)
                  IconButton(
                    onPressed: onDone,
                    icon: const Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                  ),
                if (onArchive != null)
                  IconButton(
                    onPressed: onArchive,
                    icon: const Icon(
                      Icons.archive,
                      color: Colors.white,
                    ),
                  )
              ],
            ),
            Row(
              children: [
                Text(
                  task["time"],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  task["date"],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
