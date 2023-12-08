import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityChecker {
  Connectivity connectivity = Connectivity();

  Stream<bool> checkConnectionStream() {
    return connectivity.onConnectivityChanged.map((event) {
      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<bool> checkInitialConnection() async {
    final result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      return true;
    } else {
      return false;
    }
  }
}
