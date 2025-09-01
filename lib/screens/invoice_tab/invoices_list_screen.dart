import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/image_constants.dart';
import 'package:bill_sync_app/customs/custom_loader.dart';
import 'package:bill_sync_app/screens/invoice_tab/create_invoice_screen.dart';
import 'package:bill_sync_app/services/get_request_service.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:bill_sync_app/widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/customs/custom_field.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';

class InvoicesListScreen extends StatefulWidget {
  const InvoicesListScreen({super.key});

  @override
  State<InvoicesListScreen> createState() => _InvoicesListScreenState();
}

class _InvoicesListScreenState extends State<InvoicesListScreen> {
  bool isLoading = false;
  List invoiceList = [];

  void _fetchInvoicesList() async {
    setState(() {
      isLoading = true;
    });
    invoiceList = await GetRequestServices().getInvoicesList(context: context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchInvoicesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Invoices"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(CreateInvoiceScreen());
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: AppColor.yellow.withValues(alpha: 0.8),
        child: Icon(Icons.add, color: AppColor.white, size: 30),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // StatusFilterSelector(),
              // appSpaces.spaceForHeight20,
              customField(
                hintText: 'Search',
                borderRadius: BorderRadius.circular(40),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                keyboardType: TextInputType.text,
                // borderColor: Color(0xFF98A2AD),
                // enabledBordercolor: AppColor.secondary,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: SvgPicture.asset("assets/svg/search.svg"),
                ),
              ),
              appSpaces.spaceForHeight25,
              isLoading
                  ? SizedBox(height: 450, child: Loader())
                  : invoiceList.isEmpty
                  ? NoDataFound()
                  : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: invoiceList.length,
                    itemBuilder: (context, index) {
                      final invoice = invoiceList[index];
                      return _buildInvoiCard(
                        invoiceNumber: invoice["invoiceNo"],
                        invoiceDate:
                            invoice["invoiceDate"].toString().toDDMMYYYY(),
                        itemImage: invoice["productPhoto"],
                        partyName: invoice["partyName"],
                        invoicevalue: invoice["finalPrice"],
                      );
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiCard({
    String? invoiceNumber,
    String? invoiceDate,
    String? itemImage,
    String? partyName,
    // String? partyDetail,
    String? invoicevalue,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Color(0XFFEFF3F9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // color: AppColor.blue.withAlpha(50),
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: invoiceNumber ?? "",
                // text: "IN-2024/25-01",
                fontsize: 14,
                fontWeight: FontWeight.w600,
                textColor: AppColor.textBlue,
              ),
              AppText(
                text: invoiceDate ?? "",
                // text: "12-07-2025",
                fontsize: 14,
                fontWeight: FontWeight.w600,
                textColor: AppColor.textBlue,
              ),
            ],
          ),
          Divider(color: AppColor.lightGrey),
          appSpaces.spaceForHeight5,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(2),
                child:
                // itemImage != null
                //     ? Image.network(itemImage)
                //     :
                Image.asset(
                  ImageConstant.profilePlaceholder,
                  height: 68,
                  width: 68,
                  fit: BoxFit.cover,
                ),
              ),
              appSpaces.spaceForWidth15,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "Party Name : ${partyName ?? "not available"}",
                    // text: "Party Name : Shreenath Gold Pvt. Ltd.",
                    fontsize: 12,
                    fontWeight: FontWeight.w400,
                    textColor: Colors.grey.shade800,
                    overflow: TextOverflow.ellipsis,
                  ),
                  appSpaces.spaceForHeight20,
                  AppText(
                    text: "Invoice Value : ₹${invoicevalue ?? "0"}",
                    // text: "Invoice Value : ₹10,0000",
                    fontsize: 12,
                    fontWeight: FontWeight.w400,
                    textColor: Colors.grey.shade800,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
