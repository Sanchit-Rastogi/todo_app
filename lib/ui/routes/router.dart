import 'package:auto_route/auto_route.dart';
import 'package:todo_assign/ui/screens/add.dart';
import 'package:todo_assign/ui/screens/home.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: HomeScreen, initial: true),
    AutoRoute(page: AddScreen),
  ],
)
class $AppRouter {}
