import 'package:banaras_guide/services/internet_connectivity/internete_Conectivity.dart';
import 'package:flutter/material.dart';

class ConnectivityWidget extends StatelessWidget {
  final NetworkConnectivityService _connectivityService = NetworkConnectivityService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityStatus>(
      stream: _connectivityService.connectivityStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final status = snapshot.data!;
          return Text('Connection: ${status.name}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}