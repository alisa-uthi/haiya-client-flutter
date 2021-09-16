import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/order.dart';
import 'package:haiya_client/shared/services/order_service.dart';
import 'package:haiya_client/shared/widgets/loader.dart';

import 'order_list.dart';

class PlacedOrders extends StatefulWidget {
  const PlacedOrders({Key? key}) : super(key: key);

  @override
  _PlacedOrdersState createState() => _PlacedOrdersState();
}

class _PlacedOrdersState extends State<PlacedOrders> {
  OrderService _orderService = new OrderService();
  List<Order>? _orders;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPlacedOrders();
  }

  Future<dynamic> _fetchPlacedOrders() async {
    var orders = await _orderService.getOrdersByOrderStatus('created');
    setState(() => {_orders = orders, _isLoading = false});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? _orders != null && _orders!.length != 0
            ? OrderList(orders: _orders)
            : Center(child: Text("No Orders Yet."))
        : Loader();
  }
}
