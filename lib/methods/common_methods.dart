import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class CommonMethods {
  checkConnectivity(BuildContext context) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    bool mobileConnect = connectivityResult.contains(ConnectivityResult.mobile);
    bool wifiConnect = connectivityResult.contains(ConnectivityResult.wifi);
    // connectionResult != ConnectivityResult.wifi &&
    //     connectionResult != ConnectivityResult.mobile
    if (mobileConnect == false && wifiConnect == false) {
      displaySnackbar(
          context, 'Your internet is not working. Please check and retry.');
    }
    if (!context.mounted) return;
  }

  displaySnackbar(BuildContext context, String msg) {
    var snackbar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
