import 'package:responsive_builder/responsive_builder.dart';
import 'package:jobcdp/viewModel/LoginScreen/login_viewmodel.dart';
import 'package:jobcdp/views/LoginScreen/login_mobile.dart';
import 'package:jobcdp/views/base_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenViewModel viewModel = LoginScreenViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginScreenViewModel>(
        viewModel: LoginScreenViewModel(),
        onModelReady: (viewModel) {
          this.viewModel = viewModel;
          this.viewModel.context = context;
          this.viewModel.initilizeData();
        },
        child: ScreenTypeLayout.builder(
          mobile: (BuildContext context) {
            return OrientationLayoutBuilder(
              portrait: (context) => LoginMobile(),
              landscape: (context) => LoginMobile(),
            );
          },
        ));
  }
}
