import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/home/widgets/all_pharmacies.dart';
import 'package:haiya_client/shared/helper/firebase_messaging.dart';
import 'package:haiya_client/shared/models/category.dart';
import 'package:haiya_client/shared/models/notification.dart';
import 'package:haiya_client/shared/services/inventory_service.dart';
import 'package:haiya_client/shared/services/notification_service.dart';
import 'package:haiya_client/shared/services/user_service.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';
import 'package:haiya_client/shared/widgets/loader.dart';

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
                      // Current Location
                      CurrentLocationTap(location: _location),
                      SizedBox(height: kDefaultPadding),

                      // Category
                      CategorySection(),
                      SizedBox(height: kDefaultPadding * 2),

                      // Nearest Pharmacies
                      NearestPharmacyList(),

                      // All Pharmacies
                      AllPharmacies(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
