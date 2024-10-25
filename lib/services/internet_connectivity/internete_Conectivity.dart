import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivityService {
  // Singleton instance
  static final NetworkConnectivityService _instance = NetworkConnectivityService._internal();
  factory NetworkConnectivityService() => _instance;
  NetworkConnectivityService._internal();

  // Connectivity instance
  final Connectivity _connectivity = Connectivity();

  // Controller for connectivity status stream
  final _connectivityController = StreamController<ConnectivityStatus>.broadcast();

  // Getter for the stream
  Stream<ConnectivityStatus> get connectivityStream => _connectivityController.stream;

  // Initialize the service
  void initialize() {
    // Listen to connectivity changes
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      _updateConnectionStatus(results);
    });
    
    // Check initial connectivity
    checkConnectivity();
  }

  // Check current connectivity status
  Future<ConnectivityStatus> checkConnectivity() async {
    final connectivityResults = await _connectivity.checkConnectivity();
    final status = _getStatusFromResult(connectivityResults);
    _connectivityController.add(status);
    return status;
  }

  // Update connection status based on connectivity results
  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final status = _getStatusFromResult(results);
    _connectivityController.add(status);
  }

  // Convert List<ConnectivityResult> to ConnectivityStatus
  ConnectivityStatus _getStatusFromResult(List<ConnectivityResult> results) {
    if (results.isEmpty) {
      return ConnectivityStatus.offline;
    }

    // Prioritize connection types
    if (results.contains(ConnectivityResult.vpn)) {
      return ConnectivityStatus.vpn;
    }
    if (results.contains(ConnectivityResult.wifi)) {
      return ConnectivityStatus.wifi;
    }
    if (results.contains(ConnectivityResult.mobile)) {
      return ConnectivityStatus.mobile;
    }
    if (results.contains(ConnectivityResult.ethernet)) {
      return ConnectivityStatus.ethernet;
    }
    if (results.contains(ConnectivityResult.bluetooth)) {
      return ConnectivityStatus.bluetooth;
    }

    return ConnectivityStatus.offline;
  }

  // Dispose the service
  void dispose() {
    _connectivityController.close();
  }
}

// Enum for different connectivity statuses
enum ConnectivityStatus {
  wifi,
  mobile,
  ethernet,
  vpn,
  bluetooth,
  offline,
}

// Extension to get readable status
extension ConnectivityStatusExtension on ConnectivityStatus {
  String get name {
    switch (this) {
      case ConnectivityStatus.wifi:
        return 'WiFi';
      case ConnectivityStatus.mobile:
        return 'Mobile Data';
      case ConnectivityStatus.ethernet:
        return 'Ethernet';
      case ConnectivityStatus.vpn:
        return 'VPN';
      case ConnectivityStatus.bluetooth:
        return 'Bluetooth';
      case ConnectivityStatus.offline:
        return 'Offline';
    }
  }

  bool get isConnected => this != ConnectivityStatus.offline;
}

