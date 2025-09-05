// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:bill_sync_app/constants/app_constant.dart';
import 'package:bill_sync_app/constants/color_constants.dart';
import 'package:bill_sync_app/constants/svg_constants.dart';
import 'package:bill_sync_app/screens/home_tab/home_screen.dart';
import 'package:bill_sync_app/screens/inventory_tab/inventory_list_screen.dart';
import 'package:bill_sync_app/screens/profile_tab/profile_screen.dart';
import 'package:bill_sync_app/screens/invoice_tab/invoices_list_screen.dart';
import 'package:bill_sync_app/utils/text_utility.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    InvoicesListScreen(),
    InventoryListScreen(),
    ProfileScreen(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    AppConst.setOuterContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: SafeArea(
        child: CircleNavBar(
          activeIcons: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(SvgConstants.homeIcon),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(SvgConstants.invoiceIcon),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(SvgConstants.inventoryIcon),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(SvgConstants.personIcon),
            ),
          ],
          inactiveIcons: const [
            AppText(text: "Home", fontsize: 12, textColor: AppColor.textGreyColor,),
            AppText(text: "Invoice", fontsize: 12, textColor: AppColor.textGreyColor,),
            AppText(text: "Inventory", fontsize: 12, textColor: AppColor.textGreyColor,),
            AppText(text: "Profile", fontsize: 12, textColor: AppColor.textGreyColor,),
          ],
          color: Colors.white,
          circleColor: Colors.white,
          height: 55,
          circleWidth: 50,
          activeIndex: _selectedIndex,
          onTap: (v) {
            _onItemTapped(v);
          },
          // tabCurve: Curves.easeInOutCubic,
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 7),
          cornerRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(Platform.isIOS ? 50 : 24),
            bottomLeft: Radius.circular(Platform.isIOS ? 50 : 24),
          ),
          shadowColor: AppColor.blue.withOpacity(0.5),
          circleShadowColor: AppColor.blue.withOpacity(0.5),
          elevation: 10,
          // gradient: LinearGradient(
          //     begin: Alignment.topRight,
          //     end: Alignment.bottomLeft,
          //     colors: [ Colors.blue, Colors.red ],
          // ),
          // circleGradient: LinearGradient(
          //     begin: Alignment.topRight,
          //     end: Alignment.bottomLeft,
          //     colors: [ Colors.blue, Colors.red ],
          // ),
        ),
      ),
    );
  }
}