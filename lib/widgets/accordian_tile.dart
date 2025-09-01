import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AccordianTile extends StatelessWidget {
  final String title;
  final String? icon;
  final Function()? onTap;
  const AccordianTile({super.key, required this.title, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColor.white,
          // border: Border.all(color: AppColor.secondary),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.primary.withOpacity(0.1),
                  ),
                  child: SvgPicture.asset(
                    icon ?? SvgConstants.editPen,
                    height: 21,
                    colorFilter: ColorFilter.mode(
                      AppColor.primary, 
                      BlendMode.srcIn
                    ),
                  ),
                  // child: Icon(Icons.support_agent, size: 21, color: AppColor.primary),
                ),
                appSpaces.spaceForWidth10,
                AppText(
                  text: title,
                  fontsize: 15,
                  fontWeight: FontWeight.w500,
                  textColor: AppColor.secondary,
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: AppColor.primary,
              size: 27,
              weight: 2,
            ),
          ],
        ),
      ),
    );
  }
}



class ExpandableAccordianTile extends StatefulWidget {
  final String title;
  final Widget childContent;
  final bool? isInitiallyExpanded;
  const ExpandableAccordianTile({
    super.key, 
    required this.title, 
    required this.childContent, 
    this.isInitiallyExpanded, 
  });

  @override
  State<ExpandableAccordianTile> createState() => _ExpandableAccordianTileState();
}

class _ExpandableAccordianTileState extends State<ExpandableAccordianTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: AppColor.white,
      //   // border: Border.all(color: AppColor.secondary),
      //   borderRadius: BorderRadius.circular(10),
      // ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          initiallyExpanded: widget.isInitiallyExpanded ?? false,
          collapsedIconColor: AppColor.primary,
          collapsedBackgroundColor: AppColor.white,
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          iconColor: AppColor.lightYellow,
          // iconColor: Colors.yellowAccent,
          backgroundColor: AppColor.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textColor: AppColor.lightYellow,
          // textColor: Colors.yellowAccent,
          title: Text(
            widget.title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          // title: AppText(
          //   text: widget.title,
          //   fontsize: 15,
          //   fontWeight: FontWeight.w500, 
          //   textColor: AppColor.secondary,
          // ),
          children: [
            Padding(
              padding: const EdgeInsets.all(12), 
              child: widget.childContent
            ),
          ],
        ),
      ),
    );
  }
}
