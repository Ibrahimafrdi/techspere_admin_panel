import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:kabir_admin_panel/core/data_providers/addons_provider.dart';
import 'package:kabir_admin_panel/core/data_providers/categories_provider.dart';
import 'package:kabir_admin_panel/core/data_providers/items_provider.dart';
import 'package:kabir_admin_panel/core/data_providers/orders_provider.dart';
import 'package:kabir_admin_panel/core/data_providers/riders_provider.dart';
import 'package:kabir_admin_panel/firebase_options.dart';
import 'package:kabir_admin_panel/ui/routing/app_router.dart';
import 'package:kabir_admin_panel/core/constants/colors.dart';
import 'package:kabir_admin_panel/ui/screens/navigation/navigation_controller.dart';
import 'package:provider/provider.dart';
import 'package:kabir_admin_panel/core/data_providers/shippings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationController()),
        ChangeNotifierProvider(create: (context) => ItemsProvider()),
        ChangeNotifierProvider(create: (context) => CategoriesProvider()),
        ChangeNotifierProvider(create: (context) => AddonsProvider()),
        ChangeNotifierProvider(create: (context) => OrdersProvider()),
        ChangeNotifierProvider(create: (context) => RidersProvider()),
        ChangeNotifierProvider(create: (_) => ShippingsProvider()),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFF7F7FC),
          fontFamily: 'Poppins',
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
          ),
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: WidgetStatePropertyAll<Color>(primaryColor),
            thickness: WidgetStatePropertyAll<double>(3),
            radius: Radius.circular(20),
            interactive: true,
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Kabir\'s Admin Panel',
      ),
    );
  }
}
