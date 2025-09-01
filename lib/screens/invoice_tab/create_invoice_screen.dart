// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/customs/custom_button.dart';
import 'package:bill_sync_app/customs/custom_field.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateInvoiceScreen extends ConsumerStatefulWidget {
  const CreateInvoiceScreen({super.key});

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
  final TextEditingController _profitPercentController =
      TextEditingController();
  final TextEditingController _grossWeightController = TextEditingController();
  final TextEditingController _netWeightController = TextEditingController();
  final TextEditingController _goldContentController = TextEditingController();
  final TextEditingController _wexWeightController = TextEditingController();
  // final TextEditingController _kundanJadaiLabourController = TextEditingController();
  // final TextEditingController _kundanJadaiQuantityController = TextEditingController();

  bool isLoading = false;
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
    // setState(() {
    //   isLoading = false;
    // });
  }

  void _createInvoice() async {
    List<Map<String, String>> productDetails = [];

    for (var gem in inventoryList) {
      final price = _priceControllers[gem['id']]?.text;
      final weight = _weightControllers[gem['id']]?.text;

      if (price != null &&
          price.isNotEmpty &&
          weight != null &&
          weight.isNotEmpty) {
        productDetails.add({
          "categoryId": gem['id'],
          "todayRate": price,
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
        "discount": "1000",
        "discountWeight": _profitPercentController.text,
        "grossWeight": _grossWeightController.text,
        "netWeight": _netWeightController.text,
        "gc": _goldContentController.text,
        "wexWeight": _wexWeightController.text,
        "productDetail": productDetailsJson,
      },
      imageMap:
          selectedItemImage != null ? {"productPhoto": selectedItemImage} : {},
    );
    if (response?.statusCode == 201) {
      Utils.snackBar("Invoice created successfully", context);
      context.pop();
    } else {
      Utils.errorSnackBar(
        "Failed to create invoice",
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
                                        fit: BoxFit.fill,
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
                      keyboardType: TextInputType.text,
                    ),
                    secondInput: customField(
                      headingText: "Kundan Weight",
                      hintText: "Enter Weight",
                      controller: _kundanWeightController,
                      filled: true,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  appSpaces.spaceForHeight10,
                  _buildInputRow(
                    firstInput: customField(
                      headingText: "Trading",
                      hintText: "Enter Weight",
                      controller: _tradingController,
                      filled: true,
                      keyboardType: TextInputType.text,
                    ),
                    secondInput: customField(
                      headingText: "Profit Percent %",
                      hintText: "Enter Value",
                      controller: _profitPercentController,
                      filled: true,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  appSpaces.spaceForHeight10,
                  _buildInputRow(
                    firstInput: customField(
                      headingText: "Gross Weight",
                      hintText: "Enter Weight",
                      controller: _grossWeightController,
                      filled: true,
                      keyboardType: TextInputType.text,
                    ),
                    secondInput: customField(
                      headingText: "Net Weight",
                      hintText: "Enter Weight",
                      controller: _netWeightController,
                      filled: true,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  appSpaces.spaceForHeight10,
                  _buildInputRow(
                    firstInput: customField(
                      headingText: "G.C",
                      hintText: "Enter Weight",
                      controller: _goldContentController,
                      filled: true,
                      keyboardType: TextInputType.text,
                    ),
                    secondInput: customField(
                      headingText: "WEX Weight",
                      hintText: "Enter Weight",
                      controller: _wexWeightController,
                      filled: true,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  appSpaces.spaceForHeight20,
                  _buildHeadingRow(text: "Item Details"),
                  appSpaces.spaceForHeight20,
                  _buildInputRow(
                    firstInput: customField(
                      headingText: "Kundan Jadai L.A.",
                      hintText: "Enter Price",
                      // controller: _nameController,
                      filled: true,
                      keyboardType: TextInputType.text,
                    ),
                    secondInput: customField(
                      headingText: "Quantity",
                      hintText: "Enter Quantity",
                      // controller: _nameController,
                      filled: true,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  appSpaces.spaceForHeight10,
                  _buildGemstoneInputs(),

                  // _buildInputRow(
                  //   firstInput: customField(
                  //     headingText: "Ruby (ct)",
                  //     hintText: "Enter Price",
                  //     // controller: _nameController,
                  //     filled: true,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  //   secondInput: customField(
                  //     headingText: "Quantity",
                  //     hintText: "Enter Quantity",
                  //     // controller: _nameController,
                  //     filled: true,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  // ),
                  // appSpaces.spaceForHeight10,
                  // _buildInputRow(
                  //   firstInput: customField(
                  //     headingText: "Emrald (ct)",
                  //     hintText: "Enter Price",
                  //     // controller: _nameController,
                  //     filled: true,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  //   secondInput: customField(
                  //     headingText: "Quantity",
                  //     hintText: "Enter Quantity",
                  //     // controller: _nameController,
                  //     filled: true,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  // ),
                  // appSpaces.spaceForHeight10,
                  // _buildInputRow(
                  //   firstInput: customField(
                  //     headingText: "Polki (ct)",
                  //     hintText: "Enter Price",
                  //     // controller: _nameController,
                  //     filled: true,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  //   secondInput: customField(
                  //     headingText: "Quantity",
                  //     hintText: "Enter Quantity",
                  //     // controller: _nameController,
                  //     filled: true,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  // ),
                  // appSpaces.spaceForHeight10,
                  // _buildInputRow(
                  //   firstInput: customField(
                  //     headingText: "Pearl (gm)",
                  //     hintText: "Enter Price",
                  //     // controller: _nameController,
                  //     filled: true,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  //   secondInput: customField(
                  //     headingText: "Quantity",
                  //     hintText: "Enter Quantity",
                  //     // controller: _nameController,
                  //     filled: true,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  // ),
                  // appSpaces.spaceForHeight10,
                  // _buildInputRow(
                  //   firstInput: customField(
                  //     headingText: "Emrald Mani (ct)",
                  //     hintText: "Enter Price",
                  //     // controller: _nameController,
                  //     filled: true,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  //   secondInput: customField(
                  //     headingText: "Quantity",
                  //     hintText: "Enter Quantity",
                  //     // controller: _nameController,
                  //     filled: true,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  // ),
                  // appSpaces.spaceForHeight10,
                  // _buildInputRow(
                  //   firstInput: customField(
                  //     headingText: "Ruby Mani (ct)",
                  //     hintText: "Enter Price",
                  //     // controller: _nameController,
                  //     filled: true,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  //   secondInput: customField(
                  //     headingText: "Quantity",
                  //     hintText: "Enter Quantity",
                  //     // controller: _nameController,
                  //     filled: true,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  // ),
                  // appSpaces.spaceForHeight10,
                  _buildInputRow(
                    firstInput: customField(
                      headingText: "Other",
                      hintText: "Enter Price",
                      // controller: _nameController,
                      filled: true,
                      keyboardType: TextInputType.text,
                    ),
                    secondInput: customField(
                      headingText: "Quantity",
                      hintText: "Enter Quantity",
                      // controller: _nameController,
                      filled: true,
                      keyboardType: TextInputType.text,
                    ),
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
