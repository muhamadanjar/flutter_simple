import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<List<ConnectivityResult>> get connectivityStream;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  NetworkInfoImpl({required this.connectivity});

  @override
  Future<bool> get isConnected async {
    // In a real app, you'd use a connectivity plugin
    // For simplicity, we'll just return true
    final connectivityResult = await connectivity.checkConnectivity();
    print(connectivityResult);
    return connectivityResult != ConnectivityResult.none;
    // return true;
  }

  @override
  Stream<List<ConnectivityResult>> get connectivityStream {
    return connectivity.onConnectivityChanged;
  }
}