// service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:kabir_admin_panel/core/services/auth_services.dart';

final GetIt locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Register AuthService as singleton
  locator.registerLazySingleton<AuthService>(() => AuthService());

  // You can register other services here as well
  // locator.registerLazySingleton<ApiService>(() => ApiService());
  // locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
}

// Helper function to get services
T getService<T extends Object>() => locator<T>();

// Convenience getters for commonly used services
AuthService get authService => locator<AuthService>();
