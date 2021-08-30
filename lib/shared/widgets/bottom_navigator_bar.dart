import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/cart/cart_screen.dart';
import 'package:haiya_client/screens/home/home_screen.dart';
import 'package:haiya_client/screens/profile_navigation/profile_navigation_screen.dart';

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
        gotoScreen = HomeScreen();
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
    );
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
        child: BottomNavigationBar(
          elevation: 10,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Cart',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notification',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account',
              backgroundColor: Colors.white,
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: kGreyColor,
          showUnselectedLabels: true,
          selectedItemColor: kPrimaryColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
