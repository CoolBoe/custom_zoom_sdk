import 'package:get_it/get_it.dart';
import 'package:wooapp/helper/shared_perference.dart';

GetIt locator = GetIt.instance;

void setupLocator() async {
  var instance = await BasePrefs.init();
}
