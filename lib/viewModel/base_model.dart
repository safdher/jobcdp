// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:jobcdp/app/shared.dart';
import 'package:flutter/material.dart';
import 'package:jobcdp/helper/singleton.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;
  get width => MediaQuery.of(context).size.width;
  get height => MediaQuery.of(context).size.height;
  Shared sharedInstance = Shared();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  late BuildContext context;
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  final Connectivity connectivity = Connectivity();
  bool noInternet = false;
  String connectionStatus = 'Unknown';
  Function callBack = () {};
  Singleton singleton = Singleton();

  BaseModel() {
    initState();
  }

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  void initState() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      noInternet = true;
      notifyListeners();
    } else {
      noInternet = false;
      notifyListeners();
    }
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  snacksBarSuccess(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(sharedInstance.getSnackBar(msg, Colors.green[400]!));
  }

  snacksBarError(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(sharedInstance.getSnackBar(msg, Colors.red[400]!));
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        noInternet = false;
        notifyListeners();
        callBack();
        break;
      case ConnectivityResult.mobile:
        noInternet = false;
        notifyListeners();
        callBack();
        break;
      case ConnectivityResult.none:
        connectionStatus = result.toString();
        noInternet = true;
        notifyListeners();
        break;
      default:
        connectionStatus = result.toString();
        noInternet = true;
        notifyListeners();
        break;
    }
  }
}
