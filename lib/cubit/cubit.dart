import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_g02/cubit/states.dart';

class AppCubit  extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());

  static AppCubit get(BuildContext context)=>BlocProvider.of(context);

  List<Map<String,dynamic>> newTasks=[];
  List<Map<String,dynamic>> doneTasks=[];
  List<Map<String,dynamic>> archiveTasks=[];
  Database? database;
  int currentIndex = 0;



  void setCurrentIndex(int index){
    currentIndex =index;
    emit(SetCurrentIndexState());
  }
  void createDatabase() async {
    await openDatabase(
      "todo.db",
      version: 1,
      onCreate: (Database database,int version)async{
        await database.execute("CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,time TEXT,date TEXT,status TEXT)");
        print("table created successfully");
      },
      onOpen: (Database openedDatabase){
        selectFromDatabase(openedDatabase);
        print("database opened");
      },
    ).then((value) {
      database = value;
    }).catchError((e) {
      print(e.toString());
    });
  }
  Future<void> insertIntoDatabase({required String title,required String time,required String date})async{
    await database?.transaction((txn){
      return txn.rawInsert("INSERT INTO tasks (title,time,date,status) VALUES('$title','$time','$date','new')");
    }).then((value) {
      selectFromDatabase(database!);
      print("task $value inserted successfully");
    }).catchError((e){
      print(e.toString());
    });
  }
  void selectFromDatabase(Database database)async{
    newTasks=[];
    doneTasks=[];
    archiveTasks=[];
    await database.rawQuery("SELECT * FROM tasks").then((value) {
      value.forEach((element) {
        if(element["status"]=="new"){
          newTasks.add(element);
        }else if(element["status"]=="done"){
          doneTasks.add(element);
        }else{
          archiveTasks.add(element);
        }
      });

      emit(GetDataSuccessState());


    }).catchError((e){
      print(e.toString());
    });
  }
  void updateDatabase(String status,int id)async{
    await database?.rawUpdate("UPDATE tasks SET status = ? WHERE id = ?",[status,'$id']).then((value) {
      print("raw $value updated successfully");
      selectFromDatabase(database!);
    }).catchError((e){
      print(e.toString());
    });
  }
  void deleteFromDatabase(int id)async{
    await database?.rawDelete("DELETE FROM tasks WHERE id=?",['$id']).then((value) {
      print("raw $value deleted successfully");
      selectFromDatabase(database!);
    }).catchError((e){
      print(e.toString());
    });
  }




}