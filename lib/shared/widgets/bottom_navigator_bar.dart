import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/home/home_screen.dart';

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
    String gotoScreen = HomeScreen.routeName;

    switch (_selectedIndex) {
      case 0:
        gotoScreen = HomeScreen.routeName;
        break;
      case 1:
        gotoScreen = HomeScreen.routeName;
        break;
      case 2:
        gotoScreen = HomeScreen.routeName;
        break;
      case 3:
        gotoScreen = HomeScreen.routeName;
        break;
    }

    Navigator.pushNamed(context, gotoScreen);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Account',
        ),
      ],
      currentIndex: _selectedIndex,
      unselectedItemColor: kGreyColor,
      showUnselectedLabels: true,
      selectedItemColor: kPrimaryColor,
      onTap: _onItemTapped,
    );
  }
}
