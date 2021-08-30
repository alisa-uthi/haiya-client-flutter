import 'package:flutter/material.dart';

class NavigationItem {
  String title;
  String subTitle;
  Widget routeWidget;

  NavigationItem({
    required this.title,
    required this.subTitle,
    required this.routeWidget,
  });
}
