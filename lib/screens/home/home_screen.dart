import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/pharmacy_detail_list/phamacy_detail_list_screen.dart';
import 'package:haiya_client/shared/helper/firebase_messaging.dart';
import 'package:haiya_client/shared/models/category.dart';
import 'package:haiya_client/shared/models/notification.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/services/inventory_service.dart';
import 'package:haiya_client/shared/services/notification_service.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';
import 'package:haiya_client/shared/widgets/loader.dart';
import 'package:haiya_client/shared/widgets/pharmacy_list.dart';
import 'package:haiya_client/shared/widgets/title_section.dart';

import 'widgets/category_section.dart';
import 'widgets/current_location_tap.dart';
import 'widgets/nearest_phamacy_list.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/home';

  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserService _userService = new UserService();
  InventoryService _inventoryService = new InventoryService();
  NotificationService _notificationService = new NotificationService();

  bool _isLoading = true;
  String _location = '';

  @override
  void initState() {
    super.initState();
    _getRegistrationTokenAndSubscribeToNotification();
    _fetchData();
  }

  Future<void> _getRegistrationTokenAndSubscribeToNotification() async {
    await FirebaseMessagingHelper().getTokenAndSubscribe();
  }

  Future<dynamic> _fetchData() async {
    await _getUserLocation();
    if (allCategories.isEmpty) {
      await _getCategories();
    }
    if (nearestPharmacies.isEmpty) {
      await _getNearestPharmacies();
    }
    if (allPharmacies.isEmpty) {
      await _getAllPharmacies();
    }
    if (notifications.isEmpty) {
      await _getNotifications();
    }
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
    await _inventoryService.getNearestPharmacies();
  }

  _getAllPharmacies() async {
    await _inventoryService.getAllPharmacies();
  }

  _getNotifications() async {
    await _notificationService.getNotificationsByUserId();
  }

  @override
  void dispose() {
    super.dispose();
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
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  PharmacyDetailListScreen(
                                title: 'Nearest Pharmacy',
                                pharmacies: nearestPharmacies,
                              ),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: kDefaultPadding),
                      NearestPharmacyList(),
                      SizedBox(height: kDefaultPadding * 2),
                      TitleSection(
                        title: 'Pharmacy',
                        moreText: 'See more',
                        onMoreTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  PharmacyDetailListScreen(
                                title: 'Pharmacy',
                                pharmacies: allPharmacies,
                              ),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: kDefaultPadding),
                      PharmacyList(pharmacies: allPharmacies, itemCount: 6),
                      SizedBox(height: kDefaultPadding),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
