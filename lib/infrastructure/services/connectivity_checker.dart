import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/router/app_router.dart';

class ConnectivityChecker {
  Connectivity connectivity = Connectivity();
  bool connectionLost = false;

  void checkConnectionStream() {
    connectivity.onConnectivityChanged.listen((result) {
      final appNavigator = GetIt.instance.get<AppNavigator>();
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        if (connectionLost) {
          appNavigator.replaceWith('/home');
          connectionLost = false;
        }
      } else {
        connectionLost = true;
        appNavigator.replaceWith('/connection-lost');
      }
    });
  }

  Future<void> checkInitialConnection() async {
    final result = await connectivity.checkConnectivity();
    final appNavigator = GetIt.instance.get<AppNavigator>();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      if (connectionLost) {
        appNavigator.pop();
        connectionLost = false;
      }
    } else {
      connectionLost = true;
      appNavigator.navigateTo('/connection-lost');
    }
  }
}
