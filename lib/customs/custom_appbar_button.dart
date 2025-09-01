// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget appbarButton({
  required void Function()? onTap,
  required String icon,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.lightGreyColor),
        borderRadius: BorderRadius.circular(50),
      ),
      child: SvgPicture.asset(
        icon,
        height: 22,
        width: 22,
      ),
    ),
  );
}

class CustomAppbarButton extends StatelessWidget {
  final void Function()? onTap;
  final String icon;

  const CustomAppbarButton({
    super.key,
    this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          // border: Border.all(color: AppColor.lightGreyColor),
          color: AppColor.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: SvgPicture.asset(
          icon,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}

class CustomCircularIconButton extends StatelessWidget {
  final void Function() onTap;
  final Widget icon;

  const CustomCircularIconButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(50),
          // border: Border.all(
          //   color: AppColor.lightGreyColor,
          // ),
        ),
        child: icon,
      ),
    );
  }
}
