import 'package:get_it/get_it.dart';

import 'core/viewmodels/home_model.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerFactory(() => HomeModel());
}
