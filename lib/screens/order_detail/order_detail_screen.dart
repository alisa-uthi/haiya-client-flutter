import 'package:flutter/material.dart';
import 'package:haiya_client/screens/delivery_tracking/delivery_tracking_screen.dart';
import 'package:haiya_client/shared/models/order.dart';
import 'package:haiya_client/shared/services/order_service.dart';
import 'package:haiya_client/shared/widgets/custom_btn.dart';
import 'package:haiya_client/shared/widgets/loader.dart';

import '../../constants.dart';
import 'widgets/delivery_tracking_button.dart';
import 'widgets/order_summary_section.dart';
import 'widgets/payment_method_section.dart';
import 'widgets/shipping_address_section.dart';

class OrderDetailScreen extends StatefulWidget {
  static final routeName = '/order-detail';

  final int orderId;
  final bool isDelivering;

  const OrderDetailScreen({
    Key? key,
    required this.orderId,
    this.isDelivering = false,
  }) : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  OrderService _orderService = new OrderService();
  Order? _order;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPurchaseHistory();
  }

  Future<dynamic> _fetchPurchaseHistory() async {
    var order = await _orderService.getOrderById(widget.orderId);
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
                        "Order Details",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(height: kDefaultPadding * 1.3),
                      Text(
                        "${_order!.payTimestamp.split(' ')[0]}, ${_order!.pharmacyName}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
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
                      if (widget.isDelivering) DeliveryTrackingButton(),
                    ],
                  ),
                )
              : Loader(),
        ),
      ),
    );
  }
}
