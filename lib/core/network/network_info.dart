abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    // In a real app, you'd use a connectivity plugin
    // For simplicity, we'll just return true
    return true;
  }
}