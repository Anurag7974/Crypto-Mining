
import 'package:btcmining/View/splash.dart';
import 'package:btcmining/provider/auth_provider.dart';
import 'package:btcmining/provider/dart_theme_provider.dart';
import 'package:btcmining/provider/history_provider.dart';
import 'package:btcmining/provider/news_provider.dart';
import 'package:btcmining/provider/orders_provider.dart';
import 'package:btcmining/provider/products_provider.dart';
import 'package:btcmining/provider/ref_provider.dart';
import 'package:btcmining/provider/tasks_provider.dart';
import 'package:btcmining/signupLogin/controllers/user_repository.dart';
import 'package:btcmining/signupLogin/screen/inner_screen/on_sale_screen.dart';
import 'package:btcmining/signupLogin/screen/inner_screen/product_item_screen.dart';
import 'package:btcmining/Splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'Login_Pages/auth/forget_password.dart';
import 'Login_Pages/auth/login.dart';
import 'Login_Pages/auth/ref_page.dart';
import 'Login_Pages/auth/register.dart';
import 'Profile/profile_data.dart';
import 'View/About/about.dart';
import 'View/News/news_Screen.dart';
import 'View/Tasks/task_Screen.dart';
import 'View/Wallet/view_more.dart';
import 'View/Wallet/walletScreen.dart';
import 'View/all_products.dart';
import 'View/customer_support/customer_Support.dart';
import 'View/orders/orders_screen.dart';
import 'firebase_options.dart';

/// ----- For Docs & Updates Check -------------
/// -------------  README.md -------------------

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp()  );
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
    await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState(){
    getCurrentAppTheme();
    super.initState();

  }

  /// *********** Firebase initialization code  *******************
  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();
  /// *********** End code!  *******************

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: _firebaseInitialization,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),),
            ),
          );
        } else if (snapshot.hasError) {
          const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text('An error occurred'),),
            ),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) { return themeChangeProvider; }),
            ChangeNotifierProvider(create: (_) => ProductsProvider()),
            ChangeNotifierProvider(create: (_) => OrdersProvider()),
            ChangeNotifierProvider(create: (_) => NewsProvider()),
            ChangeNotifierProvider(create: (_) => HistoryProvider()),
            ChangeNotifierProvider(create: (_) => TasksProvider()),
            ChangeNotifierProvider(create: (_) => RefProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              LoginScreen.routeName: (ctx) => const LoginScreen(),
              RegisterScreen.routeName: (ctx) => const RegisterScreen(),
              ForgetPasswordScreen.routeName: (ctx) => const ForgetPasswordScreen(),
              ProductItemScreen.routeName: (ctx) => const ProductItemScreen(),
              AllProducts.routeName: (ctx) => const AllProducts(),
              OrdersScreen.routeName: (ctx) => const OrdersScreen(),
              OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
              NewsScreen.routeName: (ctx) => const NewsScreen(),
              WalletScreen.routeName: (ctx) => const WalletScreen(),
              AboutScreen.routeName: (ctx) => const AboutScreen(),
              ViewMore.routeName: (ctx) => const ViewMore(),
              TasksScreen.routeName: (ctx) => const TasksScreen(),
              CustomerSupport.routeName: (ctx) => const CustomerSupport(),
            },
            home: const SplashScreen(),
          ),
        );
      }
    );
  }
}
