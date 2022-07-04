import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_assign/core/models/todo.dart';
import 'package:todo_assign/core/viewmodels/add_model.dart';
import 'package:todo_assign/ui/routes/router.gr.dart';
import 'package:todo_assign/ui/shared/ui_helper.dart';
import 'package:todo_assign/ui/shared/utils.dart';

import '../../locator.dart';
import '../shared/colors.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  var model = locator<AddModel>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddModel>(
      create: (context) => model,
      child: Consumer<AddModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Add task',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: UIColors.primaryColorDark,
                    ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    UIHelper.verticalSpaceLarge,
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle: Theme.of(context).textTheme.bodyText1,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please add a title.';
                        }
                        return null;
                      },
                    ),
                    UIHelper.verticalSpaceMedium,
                    TextFormField(
                      controller: descriptionController,
                      minLines: 3,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        hintStyle: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    UIHelper.verticalSpaceMedium,
                    Text(
                      'Selected Duration - ${model.duration ~/ 60}:${(model.duration % 60).toInt()}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Slider(
                      label:
                          "${model.duration ~/ 60} : ${(model.duration % 60).toInt()}",
                      divisions: 600,
                      value: model.duration,
                      onChanged: (value) {
                        model.updateDuration(value);
                      },
                      min: 1,
                      max: 600,
                    ),
                    UIHelper.verticalSpaceMedium,
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var res = await model.addTodoInDb(
                            TodoModel(
                              details: descriptionController.text,
                              duration: model.duration.toInt().toString(),
                              title: titleController.text.trim(),
                              date: DateTime.now(),
                              status: TodoStatus.todo.value,
                            ),
                          );
                          if (res) {
                            Fluttertoast.showToast(msg: 'Success');
                            // ignore: use_build_context_synchronously
                            AutoRouter.of(context)
                                .push(const HomeScreenRoute());
                          } else {
                            Fluttertoast.showToast(msg: 'Failed, Try Again.');
                          }
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
