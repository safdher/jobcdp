import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:jobcdp/app/app_config.dart';
import 'package:jobcdp/helper/utils/Loader.dart';
import 'package:jobcdp/viewModel/Dashboard/dashboard_viewmodel.dart';
import 'package:jobcdp/views/base_model_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DashboardMobile extends BaseModelWidget<DashboardScreenViewModel> {
  DashboardScreenViewModel model = DashboardScreenViewModel();
  late BuildContext context;

  DashboardMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DashboardScreenViewModel model) {
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
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Hi, ${model.singleton.user!.user_name}",
                      style: const TextStyle(color: Colorss.background2,fontSize: 20),
                    ),
                  ),
                  
                  IconButton(onPressed: model.signOutGoogle, icon: const Icon(Icons.logout,color: Colors.red,))
                ]),
              ),

              Container(
                padding: const EdgeInsets.all(10),
                height: model.width * 0.4,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(model.imageData.length+1, (index){
                      if(index == 0){
                        return InkWell( 
                          onTap: model.pickSingleImageStorage,
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            width: model.width * 0.35,
                            height: model.width * 0.35,
                            decoration: BoxDecoration(
                              color: Colorss.appCardColor,
                              border: Border.all(
                                color: Colorss.appCardColor,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(20))
                            ),
                            child: const Icon(Icons.add, color: Colorss.appBlack,)
                          )
                        );
                      }
                      return Container(
                            margin: const EdgeInsets.all(5),
                            width: model.width * 0.35,
                            height: model.width * 0.35,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(model.imageData[index - 1].file!),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(20))
                            ),
                            child: Center(
                              child:  Text(model.imageData[index - 1].title!,style: const TextStyle(color: Colors.white,fontSize: 10),),
                            )
                          );
                    }),
                  )
                )
              ),

              if(model.imageData.isNotEmpty)
              Container(
                alignment: Alignment.centerRight,
                width: model.width,
                child: TextButton( onPressed: model.uploadImages, child: const Text("Upload"),),
              ),
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
                                      image: NetworkImage(e.path!),
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
              
              // ListView.builder(
              //   itemCount: model.upoadedimageData.length,
              //   itemBuilder: (context, index) {
              //     return Container(
              //       alignment: Alignment.centerRight,
              //       padding: const EdgeInsets.only(right: 10),
              //       margin: const EdgeInsets.all(5),
              //       decoration: BoxDecoration(
              //                 image: DecorationImage(
              //                   alignment: Alignment.centerLeft,
              //                   image: NetworkImage(model.upoadedimageData[index].path!),
              //                   fit: BoxFit.fitHeight,
              //                 ),
              //                 border: Border.all(
              //                   color: Colors.grey,
              //                 ),
              //               ),
              //       width: model.width,
              //       height: model.height * 0.2,
              //       child: Text(model.upoadedimageData[index].title!,style: const TextStyle(color: Colorss.background2,fontSize: 15,fontWeight: FontWeight.bold),),
              //     );
              //   })
            ]
          ),
        ),
      ),
    );
  }
}
