import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jobcdp/app/shared.dart';
import 'package:jobcdp/helper/config.dart';
import 'package:jobcdp/model/userModel.dart';
import 'package:jobcdp/helper/singleton.dart';
import 'package:jobcdp/viewModel/base_model.dart';
import 'package:flutter/material.dart';

class LoginScreenViewModel extends BaseModel {
  late BuildContext context;
  Shared sharedInstance = Shared();
  

  Future<void> initilizeData() async {
    // Need to Check User Exist
    if(singleton.user == null){
      singleton.user = UserModel("","","","");
      await singleton.user!.getSavedUserDetails();
    }

    if(singleton.user!.user_name != ""){
        gotoDashboard();
    }
  }

  Future<void> signInWithGoogle() async {
    setBusy(true);
    GoogleSignInAccount? googleSignInAccount = await singleton.googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    UserCredential authResult = await singleton.auth.signInWithCredential(credential);
    User? user = authResult.user;
    assert(!user!.isAnonymous);
    User currentUser = singleton.auth.currentUser!;
    assert(user!.uid == currentUser.uid);
    Singleton().user = UserModel(authResult.user!.email!,
            authResult.user!.uid,
            authResult.user!.displayName!,
            authResult.user!.photoURL!);
    Singleton().user!.saveUserDetails();      
    setBusy(false);
    gotoDashboard();
  }

  gotoDashboard() async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            RoutePaths.dashboard, (Route<dynamic> route) => false);
  }
}
