import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/order.dart';
import 'package:haiya_client/shared/services/order_service.dart';
import 'package:haiya_client/shared/widgets/loader.dart';

import 'order_list.dart';

class ApprovedOrders extends StatefulWidget {
  const ApprovedOrders({Key? key}) : super(key: key);

  @override
  _ApprovedOrdersState createState() => _ApprovedOrdersState();
}

class _ApprovedOrdersState extends State<ApprovedOrders> {
  OrderService _orderService = new OrderService();
  List<Order>? _orders;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchApprovedOrders();
  }

  Future<dynamic> _fetchApprovedOrders() async {
    var orders = await _orderService.getOrdersByOrderStatus('approved');
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
