import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/track_order_status.dart';
import 'package:im_stepper/stepper.dart';

class MileStoneTracking extends StatefulWidget {
  const MileStoneTracking({
    Key? key,
    required this.trackOrder,
    required this.deliveryStep,
  }) : super(key: key);

  final List<TrackOrderStatus> trackOrder;
  final int deliveryStep;

  @override
  _MileStoneTrackingState createState() => _MileStoneTrackingState();
}

class _MileStoneTrackingState extends State<MileStoneTracking> {
  int _activeStep = 0;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() => _activeStep = widget.deliveryStep);
    }
  }
  // bool _isLoading = true;
  // Order? _order;
  // OrderService _orderService = new OrderService();

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchData();
  // }

  // Future<void> _fetchData() async {
  //   await _fetchOrder();
  //   await _fetchDelivery();
  //   setState(() => _isLoading = false);
  // }

  // Future<void> _fetchOrder() async {
  //   Order? result = await _orderService.getOrderById(widget.orderId);
  //   if (result != null && mounted) {
  //     setState(() => _order = result);

  //     int step = 0;
  //     switch (_order!.orderStatus) {
  //       case "ON_THE_WAY":
  //         step = 1;
  //         break;
  //       case "ARRIVE":
  //         step = 2;
  //         break;
  //       default:
  //         step = 0;
  //         break;
  //     }
  //     setState(() => _activeStep = step);
  //   }
  // }

  // Future<void> _fetchDelivery() async {
  //   List<Delivery> result =
  //       await _orderService.getDeliveryByOrderId(widget.orderId);
  //   if (result.isNotEmpty) {
  //     for (var i = 0; i < result.length; i++) {
  //       ConstantService.trackOrderStatus()[i].datetime = result[i].timestamp;
  //     }
  //   }
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width / 6,
          child: IconStepper(
            direction: Axis.vertical,
            enableNextPreviousButtons: false,
            enableStepTapping: false,
            activeStep: _activeStep,
            activeStepBorderColor: Colors.white,
            activeStepBorderWidth: 0.0,
            activeStepBorderPadding: 0.0,
            lineColor: kPrimaryColor,
            lineLength: 110.0,
            lineDotRadius: 2.0,
            stepRadius: 18.0,
            icons: [
              Icon(Icons.check, color: Colors.white),
              Icon(Icons.check, color: Colors.white),
              Icon(Icons.check, color: Colors.white),
            ],
            onStepReached: (index) {
              setState(() {
                _activeStep = index;
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: widget.trackOrder.length,
            itemBuilder: (context, index) {
              var track = widget.trackOrder[index];
              return _buildTrackingItem(track, context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrackingItem(
    TrackOrderStatus track,
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding * 1.7,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(
              track.title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.subtitle,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(height: 5),
                Text(
                  '${track.datetime}',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
