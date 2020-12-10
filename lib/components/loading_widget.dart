import 'package:example/commons/app_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({this.visible = true});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: visible ? 1.0 : 0.0,
          child: Container(
            height: AppDimension.shared.height,
            width: AppDimension.shared.width,
            child: Center(
              child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Center(
                    child: SpinKitCircle(
                      color: Colors.black,
                    ),
                  )),
            ),
          )),
    );
  }
}
