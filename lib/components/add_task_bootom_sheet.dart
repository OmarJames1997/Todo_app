import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_g02/components/my_text_field.dart';
import 'package:todo_app_g02/cubit/cubit.dart';
import 'package:todo_app_g02/cubit/states.dart';

class AddTAskBottomSheet extends StatefulWidget {
  const AddTAskBottomSheet({Key? key}) : super(key: key);

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (ctx) => BlocProvider.value(
        value: BlocProvider.of<AppCubit>(context),
        child: const AddTAskBottomSheet(),
      ),
    );
  }

  @override
  State<AddTAskBottomSheet> createState() => _AddTAskBottomSheetState();
}

class _AddTAskBottomSheetState extends State<AddTAskBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
   var formKey=GlobalKey<FormState>();


  @override
  void initState() {
    titleController.clear();
    timeController.clear();
    dateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 2,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Add new Task",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: titleController,
                    validator: (String? value) {
                      if(value!.isEmpty){
                        return "title is required";
                      }
                    },
                    prefixIcon: const Icon(Icons.title),
                    label: const Text("title"),
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: timeController,
                    validator: (String? value) {
                      if(value!.isEmpty){
                        return "time is required";
                      }
                    },
                    readOnly: true,
                    prefixIcon: const Icon(Icons.timer_outlined),
                    label: const Text("time"),
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        timeController.text = time.format(context);
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: dateController,
                    readOnly: true,
                    validator: (String? value) {
                      if(value!.isEmpty){
                        return "date is required";
                      }
                    },
                    prefixIcon: const Icon(Icons.date_range),
                    label: const Text("date"),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(const Duration(days: 365 * 10)),
                        lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
                      );

                      if (date != null) {
                        dateController.text = DateFormat.yMd().format(date);
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if(formKey.currentState!.validate()){
                            await AppCubit.get(context).insertIntoDatabase(
                              title: titleController.text,
                              date: dateController.text,
                              time: timeController.text,
                            );
                            Navigator.pop(context);
                            AppCubit.get(context).setCurrentIndex(0);
                          }


                        },
                        child: const Text("Add New Task"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
