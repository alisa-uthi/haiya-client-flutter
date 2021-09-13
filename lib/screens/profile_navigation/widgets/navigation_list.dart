import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/customer_service/customer_service_screen.dart';
import 'package:haiya_client/screens/my_orders/my_orders_screen.dart';
import 'package:haiya_client/screens/personal_information/personal_information_screen.dart';
import 'package:haiya_client/screens/settings/setting_screen.dart';
import 'package:haiya_client/shared/models/navigation_item.dart';

class NavigationList extends StatelessWidget {
  final List<NavigationItem> items = [
    new NavigationItem(
      title: 'Settings',
      subTitle: 'Edit application',
      routeWidget: SettingScreen(),
    ),
    new NavigationItem(
      title: 'Help Center',
      subTitle: 'Customer support',
      routeWidget: CustomerServiceScreen(),
    ),
    new NavigationItem(
      title: 'Personal Information',
      subTitle: 'Edit your personal information',
      routeWidget: PersonalInformationScreen(),
    ),
    new NavigationItem(
      title: 'My Orders',
      subTitle: 'View details of my orders',
      routeWidget: MyOrdersScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          var navItem = items[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      navItem.routeWidget,
                  transitionDuration: Duration(seconds: 0),
                ),
              );
            },
            child: _buildNavItem(navItem),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(NavigationItem navItem) {
    return ListTile(
      title: Text(
        navItem.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        navItem.subTitle,
        style: TextStyle(color: kGreyColor),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 15,
      ),
    );
  }
}
