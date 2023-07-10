import 'package:flutter/material.dart';
import 'package:todo_app_g02/components/task_widget.dart';
import 'package:todo_app_g02/cubit/cubit.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key, required this.tasks}) : super(key: key);
  final List<Map<String, dynamic>> tasks;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Text("no tasks..",style: TextStyle(color: Colors.white),),
      );
    }
    final myTasks=tasks.toList();
    return ListView.builder(
      itemBuilder: (context, index) => TaskWidget(
        task: myTasks[index],
        onArchive: () {
          AppCubit.get(context).updateDatabase("archive", myTasks[index]["id"]);
        },
        onDone: () {
          AppCubit.get(context).updateDatabase("done", myTasks[index]["id"]);
        },
      ),
      itemCount: myTasks.length,
    );
  }
}
