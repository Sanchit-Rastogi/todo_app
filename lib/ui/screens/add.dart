import 'package:flutter/material.dart';
import 'package:todo_assign/ui/shared/ui_helper.dart';

import '../shared/colors.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  double duration = 600;

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              UIHelper.verticalSpaceLarge,
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              UIHelper.verticalSpaceMedium,
              TextFormField(
                minLines: 3,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              UIHelper.verticalSpaceMedium,
              Text(
                'Select Duration (MM:SS)',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Slider(
                label: "${duration ~/ 60} : ${(duration % 60).toInt()}",
                divisions: 600,
                value: duration,
                onChanged: (value) {
                  setState(() {
                    duration = value;
                  });
                },
                min: 1,
                max: 600,
              ),
              UIHelper.verticalSpaceMedium,
              ElevatedButton(
                onPressed: () {},
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
