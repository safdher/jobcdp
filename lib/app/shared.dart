import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class Shared {
  static final Shared sharedInstance = Shared._internal();
  late double width;
  late double height;
  late String fcmToken;
  late String appVersion;

  factory Shared() {
    return sharedInstance;
  }

  Shared._internal();

  Future<void> initialize() async {
    // await getStored();
    // await cataType();
  }

  // method defined to check internet connectivity
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  SnackBar getSnackBar(String msg, Color snackcolor) {
    return SnackBar(
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: snackcolor,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating);
  }
}
