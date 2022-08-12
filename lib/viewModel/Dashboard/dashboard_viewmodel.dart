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

class DashboardScreenViewModel extends BaseModel {
  
  late BuildContext context;
  Shared sharedInstance = Shared();
  List<ImageData> imageData = [];
  List<ImageData> upoadedimageData = [];
  CollectionReference? dbRef;

  Future<void> initilizeData() async {
    dbRef =  FirebaseFirestore.instance.collection(singleton.user!.user_id);
    dbRef!.get().then((result) async {
      for (var element in result.docs) {
        Map<String, dynamic> d = element.data()! as Map<String, dynamic>;
        upoadedimageData.add(ImageData(d["title"],d["url"], null));
        notifyListeners();
      }
    });
  }

  Future<void> uploadImages()async{
    setBusy(true);
    List<String> imageUrls = await Future.wait(imageData.map((data) => uploadFile(data)));
    setBusy(false);
    gotoThanks();
  }

  Future<void> uploadData(String title,String path) async {
    Map<String,String> imageDt = {
      "title" : title,
      "url" : path
    };
    dbRef!.add(imageDt).then((value){
      print("data inserted");
    }).catchError((e){
      print("data Error");
    });
  }

  // void test(){
  //   setBusy(true);
  //   uploadData("test","sfsffg");
  //   setBusy(false);
  // }

  Future<String> uploadFile(ImageData data) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('${singleton.user!.user_id}/${data.file!.path.split("/").last}');
    UploadTask uploadTask = storageReference.putFile(data.file!);
    await uploadTask.whenComplete(() => null);
    String path = await storageReference.getDownloadURL();
    uploadData(data.title!, path);
    return path;
  }

  Future<void> pickSingleImageStorage() async {

    List<File>? data = await Navigator.of(context).push(
      MaterialPageRoute<List<File>>(
        builder: (BuildContext context) => CameraApp(
          isMultiple: true,
          isSimpleUI: true,
          compressionQuality: 50,
        ),
      ),
    );

    if (data != null) {
      for (var f in data) {
        TextEditingController title = TextEditingController();
        await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content:Container(
                    color: Colors.white,
                    child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  height: height * 0.3,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.file(f),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: title,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    child: const Text("Submit"),
                                    onPressed: () {
                                      if(title.text.trim().isNotEmpty){
                                        Navigator.of(context).pop();
                                      }else{
                                        Fluttertoast.showToast(msg: "Please Enter Valid Title");
                                      }                                                                            
                                    },
                                  ),
                                )
                              ],
                            ),
                  ));
                });
        
        imageData.add(ImageData(title.text.trim(), f.path, f));
      }
      notifyListeners();
    }
  }

  void signOutGoogle() async{
    setBusy(true);
    await singleton.user!.clearData();
    await singleton.googleSignIn.signOut();
    setBusy(false);
    gotoLogin();
  }

  gotoLogin() async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            RoutePaths.login, (Route<dynamic> route) => false);
  }

  gotoThanks() async {
        await Navigator.of(context).pushNamed(
            RoutePaths.thanks, arguments: imageData);
        imageData.clear();
        initilizeData();
        notifyListeners();
  }
}
