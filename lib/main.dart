import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/providers/LoadProvider.dart';
import 'package:wooapp/providers/ThemeProvider.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/providers/category.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/screens/cart.dart';
import 'package:wooapp/screens/home.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/screens/productBuilder.dart';
import 'package:wooapp/screens/splesh.dart';
import 'package:wooapp/services/service_locator.dart';
import 'package:wooapp/widgets/progress_bar.dart';
import 'package:wooapp/widgets/sortBy_Dialog.dart';
import 'package:wooapp/widgets/widget_home_categories.dart';
import 'helper/theme_file.dart' as theme;
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/helper/color.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
      ChangeNotifierProvider.value(value: ThemeProvider()),
      ChangeNotifierProvider.value(value: AppProvider(), child: ShopView(),),
      ChangeNotifierProvider.value(value: UserProvider()),
      ChangeNotifierProvider.value(value: LoaderProvider(), child: CartScreen(),),
      ChangeNotifierProvider.value(value: ProductsProvider(), child: HomeView(),),
      ChangeNotifierProvider.value(value: CartProvider(), child: CartScreen(),),
      ChangeNotifierProvider.value(value: CategoriesProvider(), child: HomeView(),)
  ],
    child: Consumer<ThemeProvider>(
      builder: (context, theme, _) => MaterialApp(
      theme: theme.lightTheme,
      title: "Woo App",
      debugShowCheckedModeBanner: false,
      home: ScreensController(),
    )
  )));
}
class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
      switch (auth.status) {
        case Status.Authorized:
          return MainPageScreen(currentTab: 0,);
        case Status.Unauthorized:
          return SpleshScreen();
        default:
          return progressBar(context, orange);
      }
  }
}
