// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class LoaderIndicator extends StatelessWidget {
  const LoaderIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Colors.white.withOpacity(0.3),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //padding: const EdgeInsets.all(80),
        child:
            Lottie.asset('assets/loader.json', width: 100, height: 100));
  }
}
