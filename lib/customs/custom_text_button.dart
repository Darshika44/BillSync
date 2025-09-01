// import 'package:flutter/material.dart';
// import 'package:hy_genius/customs/custom_button.dart';

// import '../utils/colors.dart';

// Widget reusableTextButton({
//   required String title,
//   required VoidCallback onPress,
//   TextStyle? style,
// }) {
//   return TextButton(
//     onPressed: onPress,
//     style: ButtonStyle(
//       elevation: WidgetStateProperty.all(0),
//       overlayColor: WidgetStateProperty.all(Colors.transparent),
//       surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
//       shadowColor: WidgetStateProperty.all(Colors.transparent),
//     ),
//     child: Text(
//       title,
//       style: style,
//     ),
//   );
// }

// Widget customTextButton({
//   required String title,
//   required VoidCallback onPress,
//   required bool isSelected,
//   TextStyle? style,
// }) {
//   return CustomButton(
//     text: title,
//     fontWeight: FontWeight.w500,
//     onPressed: onPress,
//     buttonColor: Colors.transparent,
//     textColor: isSelected ? AppColor.primary : AppColor.black,
//     borderColor: isSelected ? AppColor.primary : AppColor.borderBlueColor,
//     isBorder: true,
//     height: 30,
//     borderRadius: 4,
//   );
// }
