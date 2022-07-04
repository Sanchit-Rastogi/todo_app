import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:todo_assign/core/models/todo.dart';
import 'package:todo_assign/core/viewmodels/home_model.dart';
import 'package:todo_assign/locator.dart';
import 'package:todo_assign/ui/routes/router.gr.dart';
import 'package:todo_assign/ui/shared/colors.dart';
import 'package:todo_assign/ui/shared/ui_helper.dart';
import 'package:todo_assign/ui/shared/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var model = locator<HomeModel>();

  @override
  void initState() {
    model.getAllTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
      create: (context) => model,
      child: Consumer<HomeModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topBar(),
                  pendingTasks(),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AutoRouter.of(context).push(const AddScreenRoute());
              },
              child: const Icon(
                Icons.add,
                color: UIColors.backgroundColorLight,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget pendingTasks() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Created Tasks ( ${model.todos.length} )',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: UIColors.primaryColorDark,
                ),
          ),
          UIHelper.verticalSpaceMedium,
          GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: model.gridCount,
              mainAxisExtent: 160,
            ),
            itemBuilder: (context, index) {
              return todoCard(model.todos[index]);
            },
            itemCount: model.todos.length,
          ),
        ],
      ),
    );
  }

  Widget todoCard(TodoModel todo) {
    var duration = Duration(
      minutes: int.parse(todo.duration) ~/ 60,
      seconds: int.parse(todo.duration) % 60,
    );
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: UIColors.assetColorDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onDoubleTap: () {
                        model.deleteTodo(todo);
                      },
                      child: Text(
                        todo.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: UIColors.primaryColorDark,
                            ),
                      ),
                    ),
                  ),
                  UIHelper.horizontalSpaceSmall,
                  Text(
                    todo.status,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: todo.status == TodoStatus.todo.value
                              ? Colors.orange
                              : todo.status == TodoStatus.inprogress.value
                                  ? Colors.yellow
                                  : Colors.green,
                        ),
                  ),
                ],
              ),
              UIHelper.verticalSpaceSmall,
              Text(
                todo.details,
                style: Theme.of(context).textTheme.bodyText1,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          UIHelper.verticalSpaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  todo.status = TodoStatus.inprogress.value;
                  model.updateTodo(todo);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: UIColors.primaryColorDark,
                  ),
                  child: todo.status == TodoStatus.inprogress.value
                      ? const Icon(
                          Icons.pause_rounded,
                          color: UIColors.backgroundColorLight,
                        )
                      : const Icon(
                          Icons.play_arrow_rounded,
                          color: UIColors.backgroundColorLight,
                        ),
                ),
              ),
              //Text(todo.status),
              SlideCountdownSeparated(
                duration: duration,
                decoration: BoxDecoration(
                  color: UIColors.primaryColorDark,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget topBar() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: UIColors.primaryColorDark,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'T',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: UIColors.backgroundColorLight,
                      ),
                ),
              ),
              UIHelper.horizontalSpaceMedium,
              Text(
                'Todo App',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                model.alterGridCount();
              },
              child: model.gridCount == 1
                  ? const Icon(
                      Icons.grid_view_rounded,
                    )
                  : const Icon(
                      Icons.list_rounded,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
