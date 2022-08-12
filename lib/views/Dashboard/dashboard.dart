import 'package:responsive_builder/responsive_builder.dart';
import 'package:jobcdp/viewModel/Dashboard/dashboard_viewmodel.dart';
import 'package:jobcdp/views/Dashboard/dashboard_mobile.dart';
import 'package:jobcdp/views/base_widget.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  DashboardScreenViewModel viewModel = DashboardScreenViewModel();

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
    return BaseWidget<DashboardScreenViewModel>(
        viewModel: DashboardScreenViewModel(),
        onModelReady: (viewModel) {
          this.viewModel = viewModel;
          this.viewModel.context = context;
          this.viewModel.initilizeData();
        },
        child: ScreenTypeLayout.builder(
          mobile: (BuildContext context) {
            return OrientationLayoutBuilder(
              portrait: (context) => DashboardMobile(),
              landscape: (context) => DashboardMobile(),
            );
          },
        ));
  }
}
