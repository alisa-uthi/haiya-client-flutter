import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/home/widgets/category_section.dart';
import 'package:haiya_client/screens/home/widgets/nearest_phamacy_list.dart';
import 'package:haiya_client/screens/home/widgets/recommended_products.dart';
import 'package:haiya_client/screens/nearest_pharmacy/nearest_phamacy_screen.dart';
import 'package:haiya_client/shared/services/inventory_service.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';
import 'package:haiya_client/shared/widgets/loader.dart';
import 'package:haiya_client/shared/widgets/title_section.dart';

import 'widgets/current_location_tap.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/home';

  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserService _userService = new UserService();
  InventoryService _inventoryService = new InventoryService();

  bool _isLoading = true;
  String _location = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<dynamic> _fetchData() async {
    await _getUserLocation();
    await _getCategories();
    await _getNearestPharmacies();
    setState(() => _isLoading = false);
  }

  _getUserLocation() async {
    String location = await _userService.getCurrentLocation();
    setState(() => _location = location);
  }

  _getCategories() async {
    await _inventoryService.getAllProductCategories();
  }

  _getNearestPharmacies() async {
    InventoryService _inventoryService = new InventoryService();
    await _inventoryService.getNearestPharmacies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _isLoading ? null : BottomNavBar(index: 0),
      body: SafeArea(
        child: _isLoading
            ? Loader()
            : Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CurrentLocationTap(location: _location),
                      SizedBox(height: kDefaultPadding),
                      CategorySection(),
                      SizedBox(height: kDefaultPadding * 2),
                      TitleSection(
                        title: 'Nearest Pharmacy',
                        moreText: "See more",
                        onMoreTap: () {
                          Navigator.pushNamed(
                            context,
                            NearestPharmacyScreen.routeName,
                          );
                        },
                      ),
                      SizedBox(height: kDefaultPadding),
                      NearestPharmacyList(),
                      SizedBox(height: kDefaultPadding * 2),
                      TitleSection(
                        title: 'Recommended Products',
                        moreText: "",
                        onMoreTap: () {},
                      ),
                      SizedBox(height: kDefaultPadding),
                      // RecommendedProductsSection(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
