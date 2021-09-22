import 'package:flutter/material.dart';
import 'package:haiya_client/screens/order_detail/widgets/rate_pharmacy_button.dart';
import 'package:haiya_client/shared/models/order.dart';
import 'package:haiya_client/shared/services/order_service.dart';
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
  final bool isCompleted;

  const OrderDetailScreen({
    Key? key,
    required this.orderId,
    this.isDelivering = false,
    this.isCompleted = false,
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
                        "${_order!.pharmacyName}\n${_order!.payTimestamp}",
                        style: TextStyle(fontWeight: FontWeight.w500),
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
                      if (widget.isDelivering)
                        DeliveryTrackingButton(
                          orderId: widget.orderId,
                        ),
                      if (widget.isCompleted)
                        RatePharmacyButton(pharmacyName: _order!.pharmacyName),
                    ],
                  ),
                )
              : Loader(),
        ),
      ),
    );
  }
}
