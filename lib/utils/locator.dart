import 'package:get_it/get_it.dart';
import 'auth_provider.dart';
import 'auth_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AuthProvider>(AuthProvider());
  locator.registerSingleton<AuthService>(AuthService());
}