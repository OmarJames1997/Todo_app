import 'package:flutter/material.dart';
import 'package:todo_app_g02/components/task_widget.dart';
import 'package:todo_app_g02/cubit/cubit.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key,required this.tasks}) : super(key: key);
  final List<Map<String,dynamic>> tasks;
  @override
  Widget build(BuildContext context) {
    if(tasks.isEmpty) {
      return const Center(
        child: Text("no done tasks..",style: TextStyle(color: Colors.white),),
      );
    }
    return ListView.builder(
      itemBuilder: (context, index) => TaskWidget(
          task: tasks[index],
      onArchive: (){
          AppCubit.get(context).updateDatabase("archive", tasks[index]["id"]);
        },
      ),
      itemCount: tasks.length,
    );

  }
}
