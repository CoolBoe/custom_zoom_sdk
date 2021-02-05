import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/app_setting.dart';
import 'package:wooapp/providers/LoadProvider.dart';
import 'package:wooapp/providers/ThemeProvider.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/providers/category.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/screens/cart.dart';
import 'package:wooapp/screens/home.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/screens/paypal_payment.dart';
import 'package:wooapp/screens/productBuilder.dart';
import 'package:wooapp/screens/splesh.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';
import 'package:wooapp/widgets/sortBy_Dialog.dart';
import 'package:wooapp/widgets/widget_home_categories.dart';
import 'helper/theme_file.dart' as theme;
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/helper/color.dart';

void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MultiProvider(
      providers: [
      ChangeNotifierProvider.value(value: ThemeProvider()),
      ChangeNotifierProvider.value(value: AppProvider.initialize()),
      ChangeNotifierProvider.value(value: UserProvider.initialize()),
      ChangeNotifierProvider.value(value: LoaderProvider(), child: CartScreen(),),
      ChangeNotifierProvider.value(value: ProductsProvider.initialize(), child: HomeView(),),
      ChangeNotifierProvider.value(value: CartProvider.initialize(), child: CartScreen(),),
      ChangeNotifierProvider.value(value: CategoriesProvider.initialize(), child: HomeView(),)
  ],
    child: Consumer<ThemeProvider>(
      builder: (context, theme, _) {
        final app  = Provider.of<AppProvider>(context, listen: false);

      return  MaterialApp(
          builder: (context, child){
            return ScrollConfiguration(behavior: MyBehavior(), child: child);
          },
          theme: theme.lightTheme,
          title: "Woo App",
          debugShowCheckedModeBanner: false,
          home: ScreensController(),
          routes: <String, WidgetBuilder>{
            '/paypal':(BuildContext context)=>new PaypalPayment(),
            '/MainPage':(BuildContext context)=>new MainPageScreen(currentTab: 0,),
          },
        );
      }
  )));
}
class ScreensController extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Guest:
      // return SpleshScreen();
        return MainPageScreen(currentTab: 0,);
      case Status.Authorized:
      // return SpleshScreen();
        return MainPageScreen(currentTab: 0,);
      default:
        return progressBar(context, accent_color);
    }
  }
  Future <String> getAppStatus({String appStatus, String appVersion})async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    if(appStatus=="under-maintenance"){
      return "Maintenance";

    }else if(appVersion!=version){
      return "Update";
    }else{
      return "live";
    }
  }
}
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }

}
