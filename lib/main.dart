
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/category.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/screens/splesh.dart';
import 'package:wooapp/services/service_locator.dart';
import 'helper/theme_file.dart' as theme;
import 'package:wooapp/providers/user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
      ChangeNotifierProvider.value(value: AppProvider()),
      ChangeNotifierProvider.value(value: UserProvider.initialize()),
      ChangeNotifierProvider.value(value: CategoriesProvider.initialize()),
      ChangeNotifierProvider.value(value: ProductsProvider.initialize())
  ],
    child: MaterialApp(
      title: "Woo App",
      debugShowCheckedModeBanner: false,
      theme: theme.lightTheme,
      home: ScreensController(),
    )
  ));
}
class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<UserProvider>(context);
    print(auth.status);
    switch (auth.status) {
      case Status.Authorized:
        return MainPageScreen(currentTab: 0,);
      case Status.Unauthorized:
        return SpleshScreen();
      default:
        return SpleshScreen();
    }
  }
}
