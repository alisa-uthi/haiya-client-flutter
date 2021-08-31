import 'package:flutter/material.dart';
import 'package:haiya_client/screens/purchase_history_detail/widgets/order_summary_section.dart';
import 'package:haiya_client/screens/purchase_history_detail/widgets/payment_method_section.dart';
import 'package:haiya_client/screens/purchase_history_detail/widgets/shipping_address_section.dart';
import 'package:haiya_client/shared/models/order.dart';
import 'package:haiya_client/shared/services/order_service.dart';
import 'package:haiya_client/shared/widgets/loader.dart';

import '../../constants.dart';

class PurchaseHistoryDetailScreen extends StatefulWidget {
  static final routeName = '/purchase-history-detail';

  final int orderId;

  const PurchaseHistoryDetailScreen({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  _PurchaseHistoryDetailScreenState createState() =>
      _PurchaseHistoryDetailScreenState();
}

class _PurchaseHistoryDetailScreenState
    extends State<PurchaseHistoryDetailScreen> {
  OrderService _orderService = new OrderService();
  Order? _order;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPurchaseHistory();
  }

  Future<dynamic> _fetchPurchaseHistory() async {
    var order = await _orderService.getPurchaseHistoryById(widget.orderId);
    setState(() => {_order = order, _isLoading = false});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: !_isLoading
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Purchase History",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(height: kDefaultPadding * 1.3),
                      Text(
                        "${_order!.payTimestamp.split(' ')[0]}, ${_order!.pharmacyName}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: kDefaultPadding * 1.3),
                      ShippingAddressSection(
                        deliveryAddress: _order!.deliveryAddress,
                      ),
                      SizedBox(height: kDefaultPadding),
                      OrderSummarySection(order: _order!),
                      SizedBox(height: kDefaultPadding),
                      PaymentMethodSection(
                        paymentMethod: _order!.paymentMethod,
                      ),
                    ],
                  ),
                )
              : Loader(),
        ),
      ),
    );
  }
}
