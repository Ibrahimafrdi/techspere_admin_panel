import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kabir_admin_panel/core/models/item.dart';
import 'package:kabir_admin_panel/core/services/auth_services.dart';
import 'package:kabir_admin_panel/locator.dart';
import 'package:kabir_admin_panel/ui/routing/404_screen.dart';
import 'package:kabir_admin_panel/ui/screens/auth/signin_screen.dart';
import 'package:kabir_admin_panel/ui/screens/items_details/items_details_screen.dart';
import 'package:kabir_admin_panel/ui/screens/items/items.dart';
import 'package:kabir_admin_panel/ui/screens/navigation/navigation_screen.dart';
import 'package:kabir_admin_panel/ui/screens/dashboard/dashboard_screen.dart';
import 'package:kabir_admin_panel/ui/screens/categories/categories_screen.dart';
import 'package:kabir_admin_panel/ui/screens/orders/order_details_screen.dart';
import 'package:kabir_admin_panel/ui/screens/orders/orders_screen.dart';
import 'package:kabir_admin_panel/ui/screens/sales_report/sales_report_screen.dart';
import 'package:kabir_admin_panel/ui/screens/shipping/shipping_screen.dart';
// Import other screen files as needed

final GoRouter appRouter = GoRouter(
  initialLocation: '/dashboard',
  debugLogDiagnostics: true,

  // Redirect logic based on authentication state
  redirect: (BuildContext context, GoRouterState state) async {
    final authService = locator<AuthService>();
    final isSignedIn = authService.isSignedIn;
    final isSigningIn = state.matchedLocation == '/signin';

    // If not signed in and not on sign-in page, redirect to sign-in
    if (!isSignedIn && !isSigningIn) {
      return '/signin';
    }

    // If signed in and on sign-in page, redirect to dashboard
    if (isSignedIn && isSigningIn) {
      return '/dashboard';
    }

    // No redirect needed
    return null;
  },

  // Listen to auth state changes for automatic navigation
  refreshListenable: AuthChangeNotifier(),

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
          path: '/signin',
          pageBuilder: (context, state) =>
              _professionalTransition(AdminSignInScreen(), state),
        ),
        GoRoute(
          path: '/categories',
          pageBuilder: (context, state) =>
              _professionalTransition(CategoriesScreen(), state),
        ),
        GoRoute(
          path: '/item',
          pageBuilder: (context, state) =>
              _professionalTransition(ItemScreen(), state),
          routes: [
            GoRoute(
              path: '/edit',
              pageBuilder: (context, state) => _professionalTransition(
                ItemDetailsScreen(item: state.extra as Item),
                state,
              ),
            ),
            GoRoute(
              path: '/add',
              pageBuilder: (context, state) => _professionalTransition(
                ItemDetailsScreen(),
                state,
              ),
            ),
          ],
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
          path: '/sales-report',
          pageBuilder: (context, state) =>
              _professionalTransition(SalesReportScreen(), state),
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
  // Error handling
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Page not found: ${state.matchedLocation}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.go('/dashboard'),
            child: const Text('Go to Dashboard'),
          ),
        ],
      ),
    ),
  ),
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

// Custom ChangeNotifier to listen to auth state changes
class AuthChangeNotifier extends ChangeNotifier {
  AuthChangeNotifier() {
    // Listen to auth state changes and notify GoRouter to refresh
    locator<AuthService>().authStateChanges.listen((_) {
      notifyListeners();
    });
  }
}

// Alternative approach using Listenable for more control
class AuthStateListener extends ChangeNotifier {
  final AuthService _authService = locator<AuthService>();
  late final StreamSubscription _subscription;

  AuthStateListener() {
    _subscription = _authService.authStateChanges.listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? user) {
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
