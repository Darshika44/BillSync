import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:flutter/material.dart';

class StatusFilterSelector extends StatefulWidget {
  const StatusFilterSelector({super.key});

  @override
  State<StatusFilterSelector> createState() => _StatusFilterSelectorState();
}

class _StatusFilterSelectorState extends State<StatusFilterSelector> {
  String selected = 'All';
  final List<String> options = ['All', 'Approved', 'Pending', 'Rejected'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: options.map((option) {
          final isSelected = selected == option;
          return GestureDetector(
            onTap: () {
              setState(() {
                selected = option;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              // margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? AppColor.blue : AppColor.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: AppText(
                text: option,
                fontsize: 13,
                textColor: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
