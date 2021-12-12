import 'package:get_it/get_it.dart';
import 'navigation_util.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<NavigationUtil>(NavigationUtil());
}
