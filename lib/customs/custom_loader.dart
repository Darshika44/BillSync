import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
        color: AppColor.primary,
        size: 35,
      ),
    );
  }
}


// class Loader extends StatelessWidget {
//   const Loader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: CircularProgressIndicator.adaptive(
//         valueColor: AlwaysStoppedAnimation<Color>(AppColor.primary),
//       ),
//     );
//   }
// }
