import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:merostore_mobile/models/stores_model.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/view_models/store_view_model.dart';
import 'package:merostore_mobile/views/core_widgets/custom_shadow_container.dart';
import 'package:merostore_mobile/views/instock_page/in_stock_page.dart';
import 'package:merostore_mobile/views/other_page/other_page.dart';
import 'package:merostore_mobile/views/summary_page/summary_page.dart';
import 'package:merostore_mobile/views/today_sold_page/today_sold_page.dart';
import 'package:provider/provider.dart';

/// This widget is responsible for changing screen and acts as container to host other responsible screen

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  late List<Widget> _pagesList;

  Stores _stores = Stores();

  bool showLoading = true; // show loading indicator while fetching data

  @override
  void initState() {
    fetchNecessary();
    _pagesList = const [
      TodaySoldPage(),
      SummaryPage(),
      InStockPage(),
      OtherPage(),
    ];
    super.initState();
  }

  Future<void> fetchNecessary() async {
    setState(() => showLoading = true);

    var allStores = await StoreViewModel().getAllStores();

    // Adding stores
    for (var store in allStores) {
      _stores.addStore(store);
    }

    setState(() => showLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // body part
      body: showLoading
          ? const Center(child: CircularProgressIndicator())
          : ChangeNotifierProvider<Stores>(
              create: (_) => _stores,
              builder: (context, child) {
                return SafeArea(
                  child: _pagesList.elementAt(_selectedIndex),
                );
              },
            ),

      // Bottom nav part
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: CustomShadowContainer(
              foregroundColor: ConstantAppColors.greenColor,
              backgroundColor: ConstantAppColors.yellowColor,
              height: 48,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 32,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: ConstantAppColors.yellowColor,
                  tabBorderRadius: 14,
                  color: Colors.black,
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  tabActiveBorder: Border.all(),
                  tabs: const [
                    GButton(
                      icon: Icons.paid_outlined,
                      text: 'Today',
                    ),
                    GButton(
                      icon: Icons.summarize_outlined,
                      text: 'Summary',
                    ),
                    GButton(
                      icon: Icons.inventory_outlined,
                      text: 'Stock',
                    ),
                    GButton(
                      icon: Icons.account_circle_outlined,
                      text: 'Profile',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
