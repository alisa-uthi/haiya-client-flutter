import 'package:flutter/material.dart';
import 'package:haiya_client/screens/purchase_history_detail/purchase_history_detail_screen.dart';
import 'package:haiya_client/shared/models/order.dart';
import 'package:haiya_client/shared/services/order_service.dart';
import 'package:haiya_client/shared/widgets/loader.dart';

class PurchaseHistoryList extends StatefulWidget {
  const PurchaseHistoryList({Key? key}) : super(key: key);

  @override
  _PurchaseHistoryListState createState() => _PurchaseHistoryListState();
}

class _PurchaseHistoryListState extends State<PurchaseHistoryList> {
  OrderService _orderService = new OrderService();
  List<Order>? _orders;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPurchaseHistory();
  }

  Future<dynamic> _fetchPurchaseHistory() async {
    var orders = await _orderService.getPurchaseHistories();
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
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                      _orders!.length,
                      (index) {
                        var order = _orders![index];
                        return _buildListItem(order);
                      },
                    ),
                  ],
                ),
              )
            : Center(child: Text("No purchase history found."))
        : Loader();
  }

  Widget _buildListItem(Order order) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        "${order.payTimestamp.split(' ')[0]}, ${order.pharmacyName}",
        style: Theme.of(context).textTheme.bodyText1,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 20,
      ),
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                PurchaseHistoryDetailScreen(orderId: order.id),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      },
    );
  }
}
