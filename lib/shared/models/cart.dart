import 'dart:collection';

import 'package:flutter/cupertino.dart';

import 'order_line.dart';

class Cart extends ChangeNotifier {
  List<OrderLine> _items = [];

  List<OrderLine> get items => UnmodifiableListView(_items);

  void add(OrderLine item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(OrderLine item) {
    _items.remove(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
