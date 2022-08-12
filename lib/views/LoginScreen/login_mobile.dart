import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:jobcdp/app/app_config.dart';
import 'package:jobcdp/helper/utils/Loader.dart';
import 'package:jobcdp/viewModel/LoginScreen/login_viewmodel.dart';
import 'package:jobcdp/views/base_model_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginMobile extends BaseModelWidget<LoginScreenViewModel> {
  LoginScreenViewModel model = LoginScreenViewModel();
  late BuildContext context;

  LoginMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LoginScreenViewModel model) {
    this.context = context;
    this.model = model;
    return initializeUI();
  }

  Widget initializeUI() {
    return ModalProgressHUD(
      progressIndicator: const LoaderIndicator(),
      inAsyncCall: model.busy,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colorss.appColor,
          body: Center(
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Login with Google", style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 50,),
                  SignInButton(
                    Buttons.Google,
                    onPressed: model.signInWithGoogle,
                  )
                ]),
            )
        ),
    );
  }
}