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
                  createdTasks(),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
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

  Widget createdTasks() {
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
              playPauseBtn(todo),
              durationTimer(todo),
            ],
          ),
        ],
      ),
    );
  }

  Widget durationTimer(TodoModel todo) {
    var duration = Duration(
      minutes: int.parse(todo.duration) ~/ 60,
      seconds: int.parse(todo.duration) % 60,
    );
    return todo.status == TodoStatus.inprogress.value
        ? SlideCountdownSeparated(
            duration: duration,
            separatorPadding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: UIColors.primaryColorDark,
              borderRadius: BorderRadius.circular(7),
            ),
            onDone: () {
              todo.status = TodoStatus.done.value;
              model.updateTodo(todo);
            },
            onChanged: (value) {
              model.updateDurationLeft(value.inSeconds, todo.id!);
            },
          )
        : todo.status == TodoStatus.todo.value
            ? Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: UIColors.primaryColorDark,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      (int.parse(todo.duration) ~/ 60).toString(),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: UIColors.backgroundColorLight,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  UIHelper.horizontalSpaceSmall,
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: UIColors.primaryColorDark,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text(
                      (int.parse(todo.duration) % 60).toString(),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: UIColors.backgroundColorLight,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              )
            : Container();
  }

  Widget playPauseBtn(TodoModel todo) {
    return todo.status == TodoStatus.inprogress.value
        ? InkWell(
            onTap: () {
              todo.status = TodoStatus.todo.value;
              model.updateTodoDurationInDB();
              model.updateTodo(todo);
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: UIColors.primaryColorDark,
              ),
              child: const Icon(
                Icons.pause_rounded,
                color: UIColors.backgroundColorLight,
              ),
            ),
          )
        : todo.status == TodoStatus.todo.value
            ? InkWell(
                onTap: () {
                  todo.status = TodoStatus.inprogress.value;
                  model.updateTodoDurationInDB();
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
              )
            : const SizedBox(
                width: 30,
                height: 30,
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
