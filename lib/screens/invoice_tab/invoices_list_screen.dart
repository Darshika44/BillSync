import 'package:bill_sync_app/constants/app_constant.dart';
import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/image_constants.dart';
import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/customs/custom_loader.dart';
import 'package:bill_sync_app/screens/invoice_tab/create_invoice_screen.dart';
import 'package:bill_sync_app/services/base_url.dart';
import 'package:bill_sync_app/services/get_request_service.dart';
import 'package:bill_sync_app/utils/common_utils.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:bill_sync_app/widgets/no_data_found.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bill_sync_app/customs/custom_appbar.dart';
import 'package:bill_sync_app/customs/custom_field.dart';
import 'package:bill_sync_app/extensions/extension.dart';
import 'package:bill_sync_app/utils/app_spaces.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class InvoicesListScreen extends StatefulWidget {
  const InvoicesListScreen({super.key});

  @override
  State<InvoicesListScreen> createState() => _InvoicesListScreenState();
}

class _InvoicesListScreenState extends State<InvoicesListScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = false;
  bool isPdfLoading = false;
  List invoiceList = [];

  void _fetchInvoicesList({String search = ""}) async {
    setState(() {
      isLoading = true;
    });
    invoiceList = await GetRequestServices().getInvoicesList(
      context: context,
      url: "${ServiceUrl.getAllInvoicesUrl}?searchData=$search",
    );
    setState(() {
      isLoading = false;
    });
  }

  Future<void> downloadAndOpenPdf({
    required String url,
    required String token,
    String fileName = "invoice.pdf",
  }) async {
    setState(() {
      isPdfLoading = true;
    });
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';

      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      AppConst.showConsoleLog('Downloading PDF from: $url');
      final response = await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = (received / total) * 100;
            AppConst.showConsoleLog(
              'Downloading: ${progress.toStringAsFixed(0)}%',
            );
          }
        },
      );
      if (response.statusCode == 200) {
        Utils.snackBar("Invoice downloaded successfully", context);
      } else {
        Utils.errorSnackBar("Failed to download invoice", context);
      }
      setState(() {
        isPdfLoading = false;
      });
      AppConst.showConsoleLog('PDF downloaded to: $filePath');
      OpenFilex.open(filePath);
    } catch (e) {
      setState(() {
        isPdfLoading = false;
      });
      AppConst.showConsoleLog('Error downloading or opening the file: $e');
    }
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
          context.push(
            CreateInvoiceScreen(onRefreshInvoiceList: _fetchInvoicesList),
          );
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
                controller: _searchController,
                borderRadius: BorderRadius.circular(40),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                fillColor: AppColor.white,
                filled: true,
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
                onChanged: (value) {
                  _fetchInvoicesList(search: _searchController.text);
                },
              ),
              // appSpaces.spaceForHeight15,
              // Row(
              //   children: [
              //     AppText(
              //       text: "Filter ",
              //       fontsize: 16,
              //       fontWeight: FontWeight.bold,
              //       textColor: AppColor.primary,
              //     ),
              //     Icon(Icons.calendar_month_outlined, color: AppColor.primary, size: 21,)
              //   ],
              // ),
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
                        invoieId: invoice["id"],
                        invoiceNumber: invoice["invoiceNo"],
                        invoiceDate: invoice["invoiceDate"].toString(),
                        // invoice["invoiceDate"].toString().toDDMMYYYY(),
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
    String? invoieId,
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
                    itemImage != null
                        ? Image.network(
                          "${ServiceUrl.baseUrl}/v1/$itemImage",
                          height: 68,
                          width: 68,
                          fit: BoxFit.cover,
                        )
                        : Image.asset(
                          ImageConstant.emptyImagePlaceholder,
                          height: 68,
                          width: 68,
                          fit: BoxFit.cover,
                        ),
              ),
              appSpaces.spaceForWidth15,
              Flexible(
                child: Column(
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
                    appSpaces.spaceForHeight5,
                    AppText(
                      text: "Invoice Value : ₹${invoicevalue ?? "0"}",
                      // text: "Invoice Value : ₹10,0000",
                      fontsize: 12,
                      fontWeight: FontWeight.w400,
                      textColor: Colors.grey.shade800,
                    ),
                    // appSpaces.spaceForHeight5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 35,
                            width: 35,
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColor.yellow.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SvgPicture.asset(
                              SvgConstants.visibilitySvg,
                              colorFilter: ColorFilter.mode(
                                AppColor.yellow,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            downloadAndOpenPdf(
                              url: "${ServiceUrl.downloadInvoiceUrl}/$invoieId",
                              token: "${AppConst.getAccessToken()}",
                            );
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.download,
                                color: Colors.green.shade600,
                                size: 22,
                              ),
                            ),
                            // SvgPicture.asset(
                            //   SvgConstants.downloadIcon,
                            //   colorFilter: ColorFilter.mode(
                            //     Colors.green.shade600,
                            //     BlendMode.srcIn,
                            //   ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
