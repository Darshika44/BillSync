import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/customs/custom_loader.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/screens/inventory_tab/track_inventory_screen.dart';
import 'package:bill_sync_app/services/base_url.dart';
import 'package:bill_sync_app/services/get_request_service.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:bill_sync_app/widgets/no_data_found.dart';
import 'package:flutter/material.dart';

class InventoryListScreen extends StatefulWidget {
  const InventoryListScreen({super.key});

  @override
  State<InventoryListScreen> createState() => _InventoryListScreenState();
}

class _InventoryListScreenState extends State<InventoryListScreen> {
  List<Map<String, dynamic>> stockItems = [
    {"itemName": "Emrald", "unit": "ct", "inStock": 15.0},
    {"itemName": "Polki", "unit": "ct", "inStock": 23.5},
    {"itemName": "Ruby", "unit": "ct", "inStock": 10.5},
    {"itemName": "Pearl", "unit": "gm", "inStock": 50.0},
    {"itemName": "Emrald Mani", "unit": "ct", "inStock": 21.0},
    {"itemName": "Ruby Mani", "unit": "ct", "inStock": 10.5},
  ];

  bool isLoading = false;
  List inventoryList = [];
  dynamic userDetail = {};
  String? userId;

  void _getUserDetails() async {
    setState(() {
      isLoading = true;
    });
    final response = await GetRequestServices().getUserDetails(
      context: context,
    );
    if (response != null && response.statusCode == 200) {
      userDetail = response.data['data'];
      userId = userDetail["id"];
      _fetchInventoryList();
    }
    setState(() {
      // isLoading = false;
    });
  }

  void _fetchInventoryList() async {
    // setState(() {
    //   isLoading = true;
    // });
    inventoryList = await GetRequestServices().getInventoryList(
      context: context,
      url: "${ServiceUrl.getAllInventoryUrl}?userId=$userId",
      // url: ServiceUrl.getAllInventoryUrl,
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Inventory"),
      body:
          isLoading
              ? Center(child: SizedBox(child: Loader()))
              : inventoryList.isEmpty
              ? NoDataFound(height: 500)
              : SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                      children: [
                        // isLoading
                        //     ? Center(child: SizedBox(height: 500, child: Loader()))
                        //     : inventoryList.isEmpty
                        //     ? NoDataFound(height: 500)
                        //     :
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: inventoryList.length,
                          itemBuilder: (context, index) {
                            final item = inventoryList[index];
                            return InventoryCard(
                              onArrowTap: () {
                                context.push(
                                  TrackInventoryScreen(
                                    inventoryId: item['id'],
                                    onRefreshInventoryList: _fetchInventoryList,
                                  ),
                                );
                              },
                              itemName: item['name'],
                              unit: item['weightType'],
                              isInventoryEmpty: item['inventory']['inventoryCount'] == "0",
                              // isInventoryEmpty: item['inventory'] == null,
                              inStock:
                                  item['inventory'] != null
                                      ? item['inventory']['inventoryCount']
                                      : null,
                            );
                            // return InventoryCard(
                            //   itemName: item['itemName'],
                            //   unit: item['unit'],
                            //   inStock: item['inStock'],
                            // );
                          },
                        ),
                        appSpaces.spaceForHeight30,
                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}

class InventoryCard extends StatelessWidget {
  final String? itemName;
  final String? unit;
  final String? inStock;
  final bool isInventoryEmpty;
  final Function()? onArrowTap;

  const InventoryCard({
    super.key,
    this.itemName,
    this.unit,
    this.inStock,
    this.isInventoryEmpty = true,
    this.onArrowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            spreadRadius: -2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          appSpaces.spaceForWidth10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText(
                      text: itemName ?? "Item",
                      fontsize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    appSpaces.spaceForWidth7,
                    AppText(
                      text: unit != null ? "($unit)" : " ",
                      // text: "ct",
                      fontsize: 12,
                      fontWeight: FontWeight.w400,
                      textColor: AppColor.textGreyColor,
                    ),
                  ],
                ),
                appSpaces.spaceForHeight15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text:
                          isInventoryEmpty == false
                              ? "In Stock : $inStock"
                              : "Out of Stock",
                      // text: "In Stock : 15.2",
                      fontsize: 13,
                      fontWeight: FontWeight.w500,
                      textColor:
                          isInventoryEmpty == false
                              ? AppColor.primary
                              : AppColor.red,
                    ),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Icon(Icons.keyboard_arrow_right_rounded, size: 30),
                    //   // child: SvgPicture.asset(SvgConstants.circleAddIcon),
                    // ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onArrowTap,
            child: Icon(Icons.keyboard_arrow_right_rounded, size: 30),
            // child: SvgPicture.asset(SvgConstants.circleAddIcon),
          ),
        ],
      ),
    );
  }
}
