import 'package:flutter/material.dart';
import 'package:todo_app_g02/components/task_widget.dart';
import 'package:todo_app_g02/cubit/cubit.dart';

class ArchiveTasksScreen extends StatelessWidget {
  const ArchiveTasksScreen({Key? key, required this.tasks}) : super(key: key);
  final List<Map<String, dynamic>> tasks;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Text("no archive tasks..",style: TextStyle(color: Colors.white),),
      );
    }
    return ListView.builder(
      itemBuilder: (context, index) =>
          TaskWidget(
            task: tasks[index],
            onDone:(){
              AppCubit.get(context).updateDatabase("done", tasks[index]["id"]);
            },
          ),
      itemCount: tasks.length,
    );
  }
}
