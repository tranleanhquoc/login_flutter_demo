import 'package:get_it/get_it.dart';
import 'navigator_service.dart';

GetIt locator = GetIt.instance;

void setupLocators() {
  // register Navigation service locator
  locator.registerLazySingleton(() => NavigatorService());
}
