import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kabir_admin_panel/core/models/item.dart';
import 'package:kabir_admin_panel/core/models/order.dart';
import 'package:kabir_admin_panel/ui/routing/404_screen.dart';
import 'package:kabir_admin_panel/ui/screens/foods/food_details_screen.dart';
import 'package:kabir_admin_panel/ui/screens/navigation/navigation_screen.dart';
import 'package:kabir_admin_panel/ui/screens/dashboard/dashboard_screen.dart';
import 'package:kabir_admin_panel/ui/screens/categories/categories_screen.dart';
import 'package:kabir_admin_panel/ui/screens/foods/foods_screen.dart';
import 'package:kabir_admin_panel/ui/screens/addons/addons_screen.dart';
import 'package:kabir_admin_panel/ui/screens/orders/order_details_screen.dart';
import 'package:kabir_admin_panel/ui/screens/orders/orders_screen.dart';
import 'package:kabir_admin_panel/ui/screens/push_notifications/push_notifications_screen.dart';
import 'package:kabir_admin_panel/ui/screens/messages/messages_screen.dart';
import 'package:kabir_admin_panel/ui/screens/administrators/administrators_screen.dart';
import 'package:kabir_admin_panel/ui/screens/riders/riders_screen.dart';
import 'package:kabir_admin_panel/ui/screens/customers/customers_screen.dart';
import 'package:kabir_admin_panel/ui/screens/items_report/items_report_screen.dart';
import 'package:kabir_admin_panel/ui/screens/sales_report/sales_repor_screen.dart';
import 'package:kabir_admin_panel/ui/screens/settings/settings_screen.dart';
import 'package:kabir_admin_panel/ui/screens/shipping/shipping_screen.dart';
// Import other screen files as needed

final GoRouter appRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return NavigationScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          pageBuilder: (context, state) =>
              _professionalTransition(DashboardScreen(), state),
        ),
        GoRoute(
          path: '/categories',
          pageBuilder: (context, state) =>
              _professionalTransition(CategoriesScreen(), state),
        ),
        GoRoute(
          path: '/foods',
          pageBuilder: (context, state) =>
              _professionalTransition(FoodScreen(), state),
          routes: [
            GoRoute(
              path: '/edit',
              pageBuilder: (context, state) => _professionalTransition(
                FoodDetailsScreen(item: state.extra as Item),
                state,
              ),
            ),
            GoRoute(
              path: '/add',
              pageBuilder: (context, state) => _professionalTransition(
                FoodDetailsScreen(),
                state,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/addons',
          pageBuilder: (context, state) =>
              _professionalTransition(AddonsScreen(), state),
        ),
        GoRoute(
            path: '/online-orders',
            pageBuilder: (context, state) =>
                _professionalTransition(OrdersScreen(), state),
            routes: [
              GoRoute(
                path: '/view',
                pageBuilder: (context, state) => _professionalTransition(
                  OrderDetailsScreen(orderId: state.extra as String),
                  state,
                ),
              ),
            ]),
        GoRoute(
          path: '/push-notifications',
          pageBuilder: (context, state) =>
              _professionalTransition(PushNotificationsScreen(), state),
        ),
        GoRoute(
          path: '/messages',
          pageBuilder: (context, state) =>
              _professionalTransition(MessagesScreen(), state),
        ),
        GoRoute(
          path: '/administrators',
          pageBuilder: (context, state) =>
              _professionalTransition(AdministratorsScreen(), state),
        ),
        GoRoute(
          path: '/riders',
          pageBuilder: (context, state) =>
              _professionalTransition(RidersScreen(), state),
        ),
        GoRoute(
          path: '/customers',
          pageBuilder: (context, state) =>
              _professionalTransition(CustomersScreen(), state),
        ),
        GoRoute(
          path: '/sales-report',
          pageBuilder: (context, state) =>
              _professionalTransition(SalesReportScreen(), state),
        ),
        GoRoute(
          path: '/items-report',
          pageBuilder: (context, state) =>
              _professionalTransition(ItemsReportScreen(), state),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) =>
              _professionalTransition(SettingsScreen(), state),
        ),
        GoRoute(
          path: '/shipping',
          builder: (context, state) => const ShippingScreen(),
        ),
        // Add more routes for other screens
      ],
    ),
    GoRoute(
      path: '*',
      pageBuilder: (context, state) =>
          _professionalTransition(NotFoundScreen(), state),
    ),
  ],
);
Page<dynamic> _professionalTransition(Widget child, GoRouterState state) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 0.05);
      const end = Offset.zero;
      const curve = Curves.easeInCubic;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: offsetAnimation,
          child: child,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
  );
}
