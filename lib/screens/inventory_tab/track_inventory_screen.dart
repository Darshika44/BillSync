// ignore_for_file: use_build_context_synchronously

import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/customs/custom_button.dart';
import 'package:bill_sync_app/customs/custom_field.dart';
import 'package:bill_sync_app/customs/custom_loader.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/services/base_url.dart';
import 'package:bill_sync_app/services/get_request_service.dart';
import 'package:bill_sync_app/services/post_request_service.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/common_utils.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:bill_sync_app/validations/basic_validation.dart';
import 'package:bill_sync_app/widgets/input_label.dart';
import 'package:bill_sync_app/widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class TrackInventoryScreen extends ConsumerStatefulWidget {
  final String inventoryId;
  final Function? onRefreshInventoryList;
  const TrackInventoryScreen({
    super.key,
    required this.inventoryId,
    this.onRefreshInventoryList,
  });

  @override
  ConsumerState<TrackInventoryScreen> createState() =>
      _TrackInventoryScreenState();
}

class _TrackInventoryScreenState extends ConsumerState<TrackInventoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();

  bool isLoading = false;
  List historyList = [];

  void _fetchInventoryList(String inventoryId) async {
    setState(() {
      isLoading = true;
    });
    historyList = await GetRequestServices().getInventoryHistory(
      context: context,
      url: "${ServiceUrl.getInventoryHistoryUrl}?categoryId=$inventoryId",
    );
    setState(() {
      isLoading = false;
    });
  }

  void _addInventory(String inventoryId) async {
    final response = await PostRequestServices().addInventory(
      context: context,
      ref: ref,
      url: "${ServiceUrl.addInventoryUrl}/$inventoryId",
      body: {"quantity": _quantityController.text},
    );
    if (response?.statusCode == 201 || response?.statusCode == 203) {
      Utils.snackBar("Inventory added successfully", context);
      widget.onRefreshInventoryList?.call();
      context.pop();
      _quantityController.clear();
      _fetchInventoryList(widget.inventoryId);
    } else {
      context.pop();
      Utils.errorSnackBar(
        "Failed to add inventory",
        context,
      );
    }
  }

  @override
  void initState() {
    _fetchInventoryList(widget.inventoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Track Inventory",
        icon: SvgConstants.arrowLeftIcon,
        showLeading: true,
        titleSpacing: 5,
        onBack: () {
          context.pop();
        },
        trailing: _buildAddButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Column(
              children: [
                isLoading
                    ? Center(child: SizedBox(height: 500, child: Loader()))
                    : historyList.isEmpty
                    ? NoDataFound(height: 500)
                    : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: historyList.length,
                      itemBuilder: (context, index) {
                        final item = historyList[index];
                        return _buildTrackInventoryCard(
                          itemName: item['category']['name'],
                          date: item['createdAt'].toString().toDDMMYYYY(),
                          isInventoryAdded: item['isPositive'],
                          stockValue: item['value'],
                          // unit: item['weightType'],
                        );
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return InkWell(
      onTap: () {
        showAddInventoryDialog();
      },
      child: Row(
        children: [
          Icon(Icons.add, weight: 2, color: AppColor.primary),
          SizedBox(width: 3),
          AppText(text: "Add", fontsize: 18, textColor: AppColor.primary),
          SizedBox(width: 15),
        ],
      ),
    );
  }

  Widget _buildTrackInventoryCard({
    bool isInventoryAdded = false,
    String? itemName,
    String? date,
    String? stockValue,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          isInventoryAdded
              ? SvgPicture.asset(SvgConstants.addInventoryIcon)
              : SvgPicture.asset(SvgConstants.subtractInventoryIcon),
          SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: itemName ?? "",
                // text: "Emrald",
                fontsize: 16,
                fontWeight: FontWeight.bold,
              ),
              appSpaces.spaceForHeight10,
              AppText(
                text: date ?? "",
                // text: "12/07/2025",
                fontsize: 12,
                fontWeight: FontWeight.w400,
                textColor: AppColor.textGreyColor,
              ),
            ],
          ),
          Spacer(),
          AppText(
            text: '${isInventoryAdded ? "+" : "-"}$stockValue',
            fontsize: 16,
            fontWeight: FontWeight.bold,
            textColor: isInventoryAdded ? AppColor.textGreen : AppColor.red,
          ),
          // AppText(text: "+15", fontsize: 16, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }

  void showAddInventoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: "Add Inventory",
                          fontsize: 18,
                          fontWeight: FontWeight.w600,
                          textColor: AppColor.textBlack,
                        ),
                        InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: Icon(Icons.close, size: 24),
                        ),
                      ],
                    ),
                    appSpaces.spaceForHeight15,
                    AppText(
                      text:
                          "Enter how many quantities you want to add to your inventory.",
                      fontsize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: AppColor.textBlack,
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey.shade300),
              Padding(
                padding: EdgeInsetsGeometry.all(15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputLabel(labelText: "Quantity"),
                      appSpaces.spaceForHeight5,
                      customField(
                        hintText: "Enter Quantity",
                        controller: _quantityController,
                        filled: true,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          return validateForNormalFeild(
                            value: value,
                            props: "quantity",
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.grey.shade300),
              Padding(
                padding: EdgeInsetsGeometry.all(15),
                child: Column(
                  children: [
                    CustomButton(
                      text: "Confirm",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addInventory(widget.inventoryId);
                        }
                      },
                    ),
                    appSpaces.spaceForHeight15,
                    CustomButton(
                      text: "Cancel",
                      textColor: AppColor.textGrey,
                      buttonColor: AppColor.white,
                      isBorder: true,
                      borderColor: AppColor.textGrey,
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}



