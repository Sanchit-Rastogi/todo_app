import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:todo_assign/ui/shared/colors.dart';
import 'package:todo_assign/ui/shared/ui_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topBar(),
          pendingTasks(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: UIColors.backgroundColorLight,
        ),
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
            'Pending Tasks ( 4 )',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: UIColors.primaryColorDark,
                ),
          ),
          UIHelper.verticalSpaceMedium,
          GridView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            children: [
              todoCard(),
              todoCard(),
              todoCard(),
              todoCard(),
            ],
          ),
        ],
      ),
    );
  }

  Widget todoCard() {
    return Container(
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: UIColors.assetColorDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Todo title',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: UIColors.primaryColorDark,
                ),
          ),
          UIHelper.verticalSpaceSmall,
          Text(
            'Some description about the todo and some short text.',
            style: Theme.of(context).textTheme.bodyText1,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          UIHelper.verticalSpaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: UIColors.primaryColorDark,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: UIColors.backgroundColorLight,
                  ),
                ),
              ),
              SlideCountdownSeparated(
                duration: const Duration(
                  minutes: 10,
                  seconds: 10,
                ),
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
              onTap: () {},
              child: const Icon(
                Icons.grid_view_rounded,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
