import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/cart/cart_screen.dart';
import 'package:haiya_client/screens/home/home_screen.dart';
import 'package:haiya_client/screens/notification/notification_screen.dart';
import 'package:haiya_client/screens/profile_navigation/profile_navigation_screen.dart';
import 'package:haiya_client/shared/models/notification.dart';
import 'package:haiya_client/shared/models/order_line.dart';

import 'num_items_noti.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Widget gotoScreen = HomeScreen();

    switch (_selectedIndex) {
      case 0:
        gotoScreen = HomeScreen();
        break;
      case 1:
        gotoScreen = CartScreen();
        break;
      case 2:
        gotoScreen = NotificationScreen();
        break;
      case 3:
        gotoScreen = ProfileNavigationScreen();
        break;
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => gotoScreen,
        transitionDuration: Duration(seconds: 0),
      ),
    ).then((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kDefaultPadding * 2),
          topRight: Radius.circular(kDefaultPadding * 2),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kGreyColor.withOpacity(0.25),
            blurRadius: 15,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kDefaultPadding * 2),
          topRight: Radius.circular(kDefaultPadding * 2),
        ),
        child: _buildBottomNavBar(),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      elevation: 10,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              Icon(Icons.shopping_bag),
              if (cart.length != 0) NumItemsNoti(notiFor: cart),
            ],
          ),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              Icon(Icons.notifications),
              if (notifications.length != 0)
                NumItemsNoti(notiFor: notifications),
            ],
          ),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Account',
        ),
      ],
      currentIndex: _selectedIndex,
      backgroundColor: Colors.white,
      iconSize: 35,
      unselectedItemColor: kGreyColor,
      showUnselectedLabels: true,
      selectedItemColor: kPrimaryColor,
      onTap: _onItemTapped,
    );
  }
}
