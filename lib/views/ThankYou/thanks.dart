import 'package:jobcdp/model/image.dart';
import 'package:jobcdp/viewModel/Thanks/thanks_viewmodel.dart';
import 'package:jobcdp/views/ThankYou/thanks_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:jobcdp/views/base_widget.dart';
import 'package:flutter/material.dart';

class ThanksScreen extends StatefulWidget {
  List<ImageData> imageData;

  ThanksScreen({Key? key,required this.imageData}) : super(key: key);

  @override
  _ThanksScreenState createState() => _ThanksScreenState();
}

class _ThanksScreenState extends State<ThanksScreen>
    with TickerProviderStateMixin {
  ThanksScreenViewModel viewModel = ThanksScreenViewModel();

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
    return BaseWidget<ThanksScreenViewModel>(
        viewModel: ThanksScreenViewModel(),
        onModelReady: (viewModel) {
          this.viewModel = viewModel;
          this.viewModel.context = context;
          this.viewModel.initilizeData(widget.imageData);
        },
        child: ScreenTypeLayout.builder(
          mobile: (BuildContext context) {
            return OrientationLayoutBuilder(
              portrait: (context) => ThanksMobile(),
              landscape: (context) => ThanksMobile(),
            );
          },
        ));
  }
}
