import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_g02/components/add_task_bootom_sheet.dart';
import 'package:todo_app_g02/cubit/cubit.dart';
import 'package:todo_app_g02/cubit/states.dart';
import 'package:todo_app_g02/screens/archive_tasks_screen.dart';
import 'package:todo_app_g02/screens/done_tasks_screen.dart';
import 'package:todo_app_g02/screens/new_tasks_screens.dart';

class LayoutScreen extends StatelessWidget {
  final List<String> titles = ["New Tasks", "Done Tasks", "Archive Tasks"];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          final cubit = AppCubit.get(context);
          final List<Widget> screens = [
            NewTasksScreen(tasks: cubit.newTasks,),
            DoneTasksScreen(tasks: cubit.doneTasks),
            ArchiveTasksScreen(tasks: cubit.archiveTasks),
          ];
          return Scaffold(
            appBar: AppBar(
              title: Text(titles[cubit.currentIndex]),
              centerTitle: true,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.black, statusBarIconBrightness: Brightness.light),
              backgroundColor: Colors.black,
            ),
            body: screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.black,
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.deepPurpleAccent,
              onTap: (int index) {
                cubit.setCurrentIndex(index);
              },
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.task_alt_outlined),
                  label: "New",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.done),
                  label: "Done",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  label: "Archive",
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.deepPurpleAccent,
              onPressed: () => AddTAskBottomSheet.show(context),
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}

