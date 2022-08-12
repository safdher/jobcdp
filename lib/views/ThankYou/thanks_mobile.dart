import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jobcdp/viewModel/Thanks/thanks_viewmodel.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:jobcdp/app/app_config.dart';
import 'package:jobcdp/helper/utils/Loader.dart';
import 'package:jobcdp/views/base_model_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ThanksMobile extends BaseModelWidget<ThanksScreenViewModel> {
  ThanksScreenViewModel model = ThanksScreenViewModel();
  late BuildContext context;

  ThanksMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ThanksScreenViewModel model) {
    this.context = context;
    this.model = model;
    return initializeUI();
  }

  Widget initializeUI() {
    return ModalProgressHUD(
      inAsyncCall: model.busy,
      progressIndicator: const LoaderIndicator(),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
        child: Column(
            children:[
              SizedBox(
                width: model.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  IconButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, icon: const Icon(Icons.arrow_back_ios,color: Colorss.background2,size: 25,))
                ]),
              ),
              SizedBox(
                width: model.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Text("Thank you, ${model.singleton.user!.user_name} \n Your Image(s) are Uploaded.",
                  textAlign: TextAlign.center,
                    style: const TextStyle(color: Colorss.background2,fontSize: 22,fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
              const SizedBox(height: 20),
              Expanded(
              child: 
              SingleChildScrollView(
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  axisDirection: AxisDirection.down,
                  children: model.upoadedimageData.map((e) => Column(
                    children: [
                      Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 10),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                                    image: DecorationImage(
                                      alignment: Alignment.center,
                                      image: FileImage(e.file!),
                                      fit: BoxFit.fitHeight,
                                    ),
                                    
                                  ),
                          //width: model.width,
                          height: model.height * 0.3,
                        ),
                      Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(5),
                          child: Text(e.title!,style: const TextStyle(color: Colorss.background2,fontSize: 15,fontWeight: FontWeight.bold),),
                        ),
                    ],
                  )).toList()
                ),
              ),
              )
            ]
          ),
        ),
      ),
    );
  }
}
