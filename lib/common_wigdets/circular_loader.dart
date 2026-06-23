import 'package:flutter/material.dart';
import 'package:gps_tracking_system_app/helpers/loading_indicators.dart';

class CircularLoader extends StatelessWidget {
  final double? height;
  final double? width;
  const CircularLoader({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height ?? 45,
        width: width ?? 45,
        child: loadingIndicatorCircle(
          context: context,
          color: Colors.transparent,
        ),
      ),
    );
  }
}
