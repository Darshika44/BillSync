// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/customs/custom_button.dart';
import 'package:bill_sync_app/customs/custom_field.dart';
import 'package:bill_sync_app/screens/profile_tab/terms_and_condition_screen.dart';
import 'package:bill_sync_app/services/base_url.dart';
import 'package:bill_sync_app/services/get_request_service.dart';
import 'package:bill_sync_app/services/post_request_service.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/common_utils.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:flutter/material.dart';
import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateInvoiceScreen extends ConsumerStatefulWidget {
  final Function? onRefreshInvoiceList;
  const CreateInvoiceScreen({super.key, this.onRefreshInvoiceList});

  @override
  ConsumerState<CreateInvoiceScreen> createState() =>
      _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends ConsumerState<CreateInvoiceScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _itemNumberController = TextEditingController();
  final TextEditingController _invoiceDateController = TextEditingController();
  final TextEditingController _partyNameController = TextEditingController();
  final TextEditingController _partyDetailController = TextEditingController();
  final TextEditingController _ghatWeightController = TextEditingController();
  final TextEditingController _kundanWeightController = TextEditingController();
  final TextEditingController _tradingController = TextEditingController();
  final TextEditingController _goldProfitController = TextEditingController();
  final TextEditingController _grossWeightController = TextEditingController();
  final TextEditingController _netWeightController = TextEditingController();
  final TextEditingController _goldContentController = TextEditingController();
  final TextEditingController _wexWeightController = TextEditingController();
  final TextEditingController _cashProfitController = TextEditingController();

  bool isLoading = false;
  bool isShowTermsConditions = false;
  List inventoryList = [];
  File? selectedItemImage;
  final Map<String, TextEditingController> _priceControllers = {};
  final Map<String, TextEditingController> _weightControllers = {};

  void _fetchInventoryList() async {
    setState(() {
      isLoading = true;
    });
    inventoryList = await GetRequestServices().getInventoryList(
      context: context,
      url: ServiceUrl.getAllInventoryUrl,
      // url: "${ServiceUrl.getAllInventoryUrl}?showOtherItems=true",
    );
    if (inventoryList.isNotEmpty) {
      setState(() {
        for (var gem in inventoryList) {
          _priceControllers[gem['id']] = TextEditingController();
          _weightControllers[gem['id']] = TextEditingController();
        }
        isLoading = false;
      });
    }
  }

  void _createInvoice() async {
    List<Map<String, dynamic>> productDetails = [];

    for (var gem in inventoryList) {
      final price = _priceControllers[gem['id']]?.text;
      final weight = _weightControllers[gem['id']]?.text;

      if (price != null &&
          price.isNotEmpty &&
          weight != null &&
          weight.isNotEmpty) {
        productDetails.add({
          "categoryId": gem['id'],
          "todayRate": int.parse(price),
          "weight": weight,
        });
      }
    }

    if (selectedItemImage == null) {
      Utils.snackBar(
        "Please select an image",
        snackbarType: SnackBarType.alert,
        backgroundColor: Colors.grey.shade800,
        iconColor: Colors.white,
        textColor: Colors.white,
        context,
      );
      return;
    }

    String productDetailsJson = jsonEncode(productDetails);
    final response = await PostRequestServices().createInvoice(
      context: context,
      ref: ref,
      body: {
        "itemNo": _itemNumberController.text,
        "invoiceDate": _invoiceDateController.text,
        "partyName": _partyNameController.text,
        "partyDetail": _partyDetailController.text,
        "ghatWeight": _ghatWeightController.text,
        "kundanWeight": _kundanWeightController.text,
        "trading": _tradingController.text,
        "discount": _cashProfitController.text,
        "discountWeight": _goldProfitController.text,
        "grossWeight": _grossWeightController.text,
        "netWeight": _netWeightController.text,
        "gc": _goldContentController.text,
        "wexWeight": _wexWeightController.text,
        "showTermsAndCondition": isShowTermsConditions,
        "productDetail": productDetailsJson,
      },
      imageMap:
          selectedItemImage != null ? {"productPhoto": selectedItemImage} : {},
    );
    if (response?.statusCode == 200) {
      widget.onRefreshInvoiceList?.call();
      Utils.snackBar("Invoice created successfully", context);
      context.pop();
    } else {
      Utils.errorSnackBar(
        response?.error ?? "Failed to create invoice",
        context,
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        selectedItemImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    _fetchInventoryList();

    final now = DateTime.now();
    final formattedDate = DateFormat('dd-MM-yyyy').format(now);
    _invoiceDateController.text = formattedDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Create Invoice",
        icon: SvgConstants.arrowLeftIcon,
        showLeading: true,
        titleSpacing: 5,
        onBack: () {
          context.pop();
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // appSpaces.spaceForHeight10,
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: SizedBox(
                        height: selectedItemImage != null ? 160 : 140,
                        child:
                            selectedItemImage != null
                                ? Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                        selectedItemImage!,
                                        height: 160,
                                        width: 160,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: -10,
                                      right: -10,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedItemImage = null;
                                          });
                                        },
                                        child: Icon(
                                          Icons.cancel,
                                          size: 35,
                                          color: Colors.red.shade800,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                : Container(
                                  height: 70,
                                  width: 70,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.withValues(alpha: 0.2),
                                  ),
                                  child: Icon(Icons.camera_alt_outlined),
                                ),
                      ),
                    ),
                  ),
                  appSpaces.spaceForHeight20,
                  _buildHeadingRow(text: "Basic Details"),
                  appSpaces.spaceForHeight20,
                  _buildInputRow(
                    firstInput: customField(
                      headingText: "Item Number",
                      hintText: "Enter Item No.",
                      controller: _itemNumberController,
                      filled: true,
                      keyboardType: TextInputType.text,
                    ),
                    secondInput: customField(
                      headingText: "Invoice Date",
                      hintText: "Enter Date",
                      controller: _invoiceDateController,
                      filled: true,
                      readonly: true,
                      keyboardType: TextInputType.text,
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        size: 24,
                        color: AppColor.primary,
                      ),
                      onTap: () {
                        Utils.selectDate(
                          context,
                          _invoiceDateController,
                          dateFormat: 'dd-MM-yyyy',
                        );
                      },
                    ),
                  ),
                  appSpaces.spaceForHeight10,
                  _buildInputRow(
                    firstInput: customField(
                      headingText: "Party Name",
                      hintText: "Enter Name",
                      controller: _partyNameController,
                      filled: true,
                      keyboardType: TextInputType.text,
                    ),
                    secondInput: customField(
                      headingText: "Party Detail",
                      hintText: "Enter Detail",
                      controller: _partyDetailController,
                      filled: true,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  appSpaces.spaceForHeight20,
                  _buildHeadingRow(text: "Invoice Details"),
                  appSpaces.spaceForHeight20,
                  _buildInputRow(
                    firstInput: customField(
                      headingText: "Ghat Weight",
                      hintText: "Enter Weight",
                      controller: _ghatWeightController,
                      filled: true,
                      keyboardType: TextInputType.number,
                    ),
                    secondInput: customField(
                      headingText: "Kundan Weight",
                      hintText: "Enter Weight",
                      controller: _kundanWeightController,
                      filled: true,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  appSpaces.spaceForHeight10,
                  _buildInputRow(
                    firstInput: customField(
                      headingText: "Trading",
                      hintText: "Enter Weight",
                      controller: _tradingController,
                      filled: true,
                      keyboardType: TextInputType.number,
                    ),
                    secondInput: customField(
                      headingText: "Gold Profit %",
                      hintText: "Enter Value",
                      controller: _goldProfitController,
                      filled: true,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  appSpaces.spaceForHeight10,
                  _buildInputRow(
                    firstInput: customField(
                      headingText: "Gross Weight",
                      hintText: "Enter Weight",
                      controller: _grossWeightController,
                      filled: true,
                      keyboardType: TextInputType.number,
                    ),
                    secondInput: customField(
                      headingText: "Net Weight",
                      hintText: "Enter Weight",
                      controller: _netWeightController,
                      filled: true,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  appSpaces.spaceForHeight10,
                  _buildInputRow(
                    firstInput: customField(
                      headingText: "G.C",
                      hintText: "Enter Weight",
                      controller: _goldContentController,
                      filled: true,
                      keyboardType: TextInputType.number,
                    ),
                    secondInput: customField(
                      headingText: "WEX Weight",
                      hintText: "Enter Weight",
                      controller: _wexWeightController,
                      filled: true,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  appSpaces.spaceForHeight20,
                  _buildHeadingRow(text: "Item Details"),
                  appSpaces.spaceForHeight20,

                  // fetching gemstones and others from API
                  _buildGemstoneInputs(),

                  // end of gemstones and others API call
                  _buildInputRow(
                    firstInput: customField(
                      headingText: "Cash Profit %",
                      hintText: "Enter Value",
                      controller: _cashProfitController,
                      filled: true,
                      keyboardType: TextInputType.number,
                    ),
                    secondInput: SizedBox.shrink(),
                  ),
                  appSpaces.spaceForHeight20,
                  _buildHeadingRow(text: "Terms & Conditions"),
                  appSpaces.spaceForHeight10,
                  InkWell(
                    onTap: () {
                      context.push(TermsAndConditionScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppText(
                          text: "Edit",
                          fontsize: 17,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.green.shade600,
                        ),
                        appSpaces.spaceForWidth7,
                        SvgPicture.asset(
                          SvgConstants.editProfileIcon,
                          colorFilter: ColorFilter.mode(
                            Colors.green.shade600,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                  appSpaces.spaceForHeight15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: "Show terms and conditions",
                        fontsize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: AppColor.darkBlue,
                      ),
                      Switch(
                        value: isShowTermsConditions,
                        activeColor: AppColor.white,
                        activeTrackColor: AppColor.yellow,
                        // activeTrackColor: Colors.green.shade400,
                        inactiveTrackColor: Colors.grey.shade400,
                        onChanged: (value) {
                          setState(() {
                            isShowTermsConditions = value;
                          });
                        },
                      ),
                    ],
                  ),
                  appSpaces.spaceForHeight30,
                  CustomButton(
                    text: 'Create Invoice',
                    fontsize: 16,
                    onPressed: () {
                      _createInvoice();
                    },
                  ),
                  // appSpaces.spaceForHeight30,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeadingRow({required String text}) {
    return Row(
      children: [
        Container(height: 1.2, width: 20, color: AppColor.textGrey),
        AppText(
          text: " $text ",
          fontsize: 16,
          fontWeight: FontWeight.w400,
          textColor: AppColor.textGrey,
        ),
        Expanded(child: Container(height: 1.2, color: AppColor.textGrey)),
      ],
    );
  }

  Widget _buildInputRow({
    required Widget firstInput,
    required Widget secondInput,
  }) {
    return Row(
      children: [
        Expanded(child: firstInput),
        appSpaces.spaceForWidth10,
        Expanded(child: secondInput),
      ],
    );
  }

  Widget _buildGemstoneInputs() {
    return Column(
      children:
          inventoryList.map((gemstone) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildInputRow(
                firstInput: customField(
                  headingText:
                      "${gemstone['name']} (${gemstone['weightType']})",
                  hintText: "Enter Price",
                  controller: _priceControllers[gemstone['id']],
                  filled: true,
                  keyboardType: TextInputType.number,
                ),
                secondInput: customField(
                  headingText: "Quantity",
                  hintText: "Enter Quantity",
                  controller: _weightControllers[gemstone['id']],
                  filled: true,
                  keyboardType: TextInputType.number,
                ),
              ),
            );
          }).toList(),
    );
  }
}
