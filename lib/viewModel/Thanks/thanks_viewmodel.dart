// ignore_for_file: overridden_fields, annotate_overrides

import 'dart:io';

import 'package:camera_with_files/camera_with_files.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobcdp/app/shared.dart';
import 'package:jobcdp/helper/config.dart';
import 'package:jobcdp/model/image.dart';
import 'package:jobcdp/viewModel/base_model.dart';
import 'package:flutter/material.dart';

class ThanksScreenViewModel extends BaseModel {
  late BuildContext context;
  Shared sharedInstance = Shared();
  List<ImageData> upoadedimageData = [];
  CollectionReference? dbRef;

  Future<void> initilizeData(val) async {
    upoadedimageData = val;
    notifyListeners();
  }

}
