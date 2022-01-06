import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/delivery.dart';
import 'package:haiya_client/shared/models/order.dart';
import 'package:haiya_client/shared/models/track_order_status.dart';
import 'package:haiya_client/shared/services/constant_service.dart';
import 'package:haiya_client/shared/services/order_service.dart';
import 'package:haiya_client/shared/widgets/header_text.dart';
import 'package:haiya_client/shared/widgets/loader.dart';

import '../../constants.dart';
import 'widgets/chat_call_driver.dart';
import 'widgets/milestone_tracking.dart';

class DeliveryTrackingScreen extends StatefulWidget {
  static final routeName = '/delivery-tracking';

  final int orderId;

  const DeliveryTrackingScreen({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  _DeliveryTrackingScreenState createState() => _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen> {
  bool _isLoading = true;
  Order? _order;
  List<Delivery> _deliveryList = [];
  List<TrackOrderStatus> _trackOrderStatus = [];
  OrderService _orderService = new OrderService();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await _fetchOrder();
    await _fetchDelivery();
    setState(() => _isLoading = false);
  }

  Future<void> _fetchOrder() async {
    Order? result = await _orderService.getOrderById(widget.orderId);
    if (result != null && mounted) {
      setState(() => _order = result);
    }
  }

  Future<void> _fetchDelivery() async {
    // Assign datetime to each track order status
    List<TrackOrderStatus> tempTrack = ConstantService.trackOrderStatus();
    // For PICKED_UP status, timestamp will be timestamp when order is created
    if (_order != null) {
      tempTrack[0].datetime = _order!.createdAt;
    }

    List<Delivery> result =
        await _orderService.getDeliveryByOrderId(widget.orderId);

    if (result.isNotEmpty) {
      for (var i = 0; i < result.length; i++) {
        tempTrack[i + 1].datetime = result[i].timestamp;
      }
    }

    setState(() => {
          _trackOrderStatus = tempTrack,
          _deliveryList = result,
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderText(text: "Delivery Tracking"),
                  if (!_isLoading && _order!.driverId != null)
                    ChatCallDriver(driverId: _order!.driverId!),
                ],
              ),
              !_isLoading
                  ? _order != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order ID: ORD0000${_order!.id}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(height: kDefaultPadding / 2),
                            Text(
                              'Placed order at: ${_order!.createdAt}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            MileStoneTracking(
                              trackOrder: _trackOrderStatus,
                              deliveryStep: _deliveryList.length,
                            ),
                          ],
                        )
                      : Center(
                          child: Text("Unable to track your order."),
                        )
                  : Loader(),
            ],
          ),
        ),
      ),
    );
  }
}
