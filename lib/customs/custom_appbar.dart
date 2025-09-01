import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/customs/custom_appbar_button.dart';
import 'package:flutter/material.dart';

import '../utils/text_utility.dart';

AppBar customAppBar({
  String? title,
  Widget? trailing,
  Function? onBack,
  bool? showLeading,
  double? titleSpacing,
  String? icon,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    forceMaterialTransparency: true,
    centerTitle: false,
    titleSpacing: titleSpacing,
    leading: showLeading != null && showLeading
        ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomAppbarButton(
              onTap: () {
                onBack?.call();
              },
              icon: icon ?? SvgConstants.backArrowIcon,
            ),
          )
        : null,
    title: title != null
        ? AppText(
            text: title,
            fontsize: 18,
            fontWeight: FontWeight.w400,
            // fontfamily: GoogleFonts.sora().fontFamily,
          )
        : null,
    actions: [
      if (trailing != null) trailing,
    ],
  );
}
