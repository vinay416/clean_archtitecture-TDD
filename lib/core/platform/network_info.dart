import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetwokInfoImpl implements NetworkInfo{
  const NetwokInfoImpl(
    this.networkChecker,
  );
  final InternetConnectionChecker networkChecker;
  
  @override
  Future<bool> isConnected() {
    networkChecker.hasConnection;
    return Future.value(true);
  }
}
