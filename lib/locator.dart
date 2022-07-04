import 'package:get_it/get_it.dart';
import 'package:todo_assign/core/services/providers/todo_provider.dart';
import 'package:todo_assign/core/viewmodels/add_model.dart';

import 'core/viewmodels/home_model.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => TodoProvider());

  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => AddModel());
}
