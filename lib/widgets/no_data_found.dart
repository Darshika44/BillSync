import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/image_constants.dart';
import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  final double? height;
  const NoDataFound({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 400,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageConstant.noDataFound,
              height: 90,
              fit: BoxFit.cover,
            ),
            // const SizedBox(height: 20),
            Text(
              'No Data Found !',
              style: TextStyle(
                fontSize: 16,
                color: AppColor.textGrey,
                // color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}