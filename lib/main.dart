import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/providers/category.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/screens/cart.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/screens/splesh.dart';
import 'package:wooapp/services/service_locator.dart';
import 'package:wooapp/widgets/progress_bar.dart';
import 'helper/theme_file.dart' as theme;
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/helper/color.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider.initialize()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: CategoriesProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductsProvider.initialize()),
        ChangeNotifierProvider.value(
          value: CartProvider(),
          child: CartScreen(),
        )
      ],
      child: MaterialApp(
        title: "Woo App",
        debugShowCheckedModeBanner: false,
        home: ScreensController(),
      )));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Authorized:
        return MainPageScreen(
          currentTab: 0,
        );
      case Status.Unauthorized:
        return SpleshScreen();
      default:
        return progressBar(context, orange);
    }
  }
}
