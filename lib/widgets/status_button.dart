// ignore_for_file: deprecated_member_use

import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:flutter/material.dart';

class StatusButton extends StatefulWidget {
  final String status;
  const StatusButton({super.key, required this.status});

  @override
  State<StatusButton> createState() => _StatusButtonState();
}

class _StatusButtonState extends State<StatusButton> {
  @override
  Widget build(BuildContext context) {
    Color? borderColor;
    Color? textColor;
    Color? backgroundColor;

    switch (widget.status.toLowerCase()) {
      case 'approved':
      case 'active':
        borderColor = AppColor.torquish;
        textColor = AppColor.torquish;
        backgroundColor = AppColor.torquish.withOpacity(0.1);
        break;
      case 'pending':
        borderColor = AppColor.neonGreen;
        textColor = AppColor.neonGreen;
        backgroundColor = AppColor.neonGreen.withOpacity(0.1);
        break;
      case 'rejected':
      case 'inactive':
        borderColor = AppColor.orange;
        textColor = AppColor.orange;
        backgroundColor = AppColor.orange.withOpacity(0.1);
        break;
    }

    return GestureDetector(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: AppText(
          text: widget.status,
          // text: "Active",
          fontsize: 10,
          fontWeight: FontWeight.w500,
          textColor: textColor,
        ),
      ),
    );
  }
}


class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color textColor;
    Color backgroundColor;

    switch (status.toLowerCase()) {
      case 'approved':
        borderColor = Colors.teal;
        textColor = Colors.teal;
        backgroundColor = Colors.teal.withOpacity(0.05);
        break;
      case 'pending':
        borderColor = Colors.lime;
        textColor = Colors.lime[800]!;
        backgroundColor = Colors.lime.withOpacity(0.05);
        break;
      case 'rejected':
        borderColor = Colors.redAccent;
        textColor = Colors.redAccent;
        backgroundColor = Colors.redAccent.withOpacity(0.05);
        break;
      default:
        borderColor = Colors.grey;
        textColor = Colors.grey;
        backgroundColor = Colors.grey.withOpacity(0.05);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
