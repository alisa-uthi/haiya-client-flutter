import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

import 'package:haiya_client/screens/operation_times/operation_times_screen.dart';
import 'package:haiya_client/shared/widgets/loader.dart';
import 'package:haiya_client/shared/models/operation_time.dart';
import 'package:haiya_client/shared/services/inventory_service.dart';
import 'package:haiya_client/screens/product_list/product_list_screen.dart';
import 'package:haiya_client/shared/models/category.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import '../../../constants.dart';

class PharmacyDetailCard extends StatefulWidget {
  PharmacyDetailCard({
    Key? key,
    required this.pharmacy,
  }) : super(key: key);

  final Pharmacy pharmacy;

  @override
  _PharmacyDetailCardState createState() => _PharmacyDetailCardState();
}

class _PharmacyDetailCardState extends State<PharmacyDetailCard> {
  InventoryService _inventoryService = new InventoryService();
  bool _isOpen = false;
  bool _isLoading = true;
  OperationTime? _opt;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void didUpdateWidget(PharmacyDetailCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pharmacy != oldWidget.pharmacy) {
      _fetchData();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<dynamic> _fetchData() async {
    await _getCurrentOperationTime();
    if (_opt != null) {
      var result = _inventoryService.isPharmacyOpen(_opt!);
      setState(() => _isOpen = result);
    } else {
      setState(() => _isOpen = false);
    }
    setState(() => _isLoading = false);
  }

  String getCurrentWeekDay() {
    return DateFormat.E().format(DateTime.now());
  }

  _getCurrentOperationTime() async {
    String weekday = getCurrentWeekDay();
    setState(() {
      _opt = widget.pharmacy.operationTime!
          .firstWhereOrNull((element) => element.optDay == weekday);
    });
  }

  String _getTimePeriodUnit(String time) {
    if (int.parse(time.substring(0, 2)) < 12) {
      return 'AM';
    }
    return 'PM';
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loader()
        : GestureDetector(
            onTap: _isOpen
                ? () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (buider, animation1, animation2) =>
                            ProductListScreen(
                          category: allCategories[0],
                          pharmacyId: widget.pharmacy.id,
                          pharmacyName: widget.pharmacy.name,
                        ),
                      ),
                    );
                  }
                : () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              margin: const EdgeInsets.only(bottom: kDefaultPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kDefaultPadding / 3),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.pharmacy.name,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: !_isOpen
                                  ? kGreyColor.withOpacity(0.5)
                                  : Colors.black,
                            ),
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                      ),
                      Text(
                        '${widget.pharmacy.distanceFromCurrentLoc!.toString()} KM',
                        style: TextStyle(
                          color: !_isOpen
                              ? kGreyColor.withOpacity(0.5)
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Rating Score
                      widget.pharmacy.ratingScore != null
                          ? _buildRatingScore()
                          : Container(),

                      // Operation Time
                      _opt != null
                          ? _buildOperationTime()
                          : Text(
                              "Closed",
                              style: TextStyle(
                                color: kGreyColor.withOpacity(0.5),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildRatingScore() {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: _isOpen ? Colors.yellow : kGreyColor.withOpacity(0.5),
        ),
        SizedBox(width: 5),
        Text(
          widget.pharmacy.ratingScore.toString(),
          style: TextStyle(
            color: !_isOpen ? kGreyColor.withOpacity(0.5) : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildOperationTime() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (buider, animation1, animation2) =>
                OperationTimesScreen(pharmacy: widget.pharmacy),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.access_time_filled,
            size: 30,
            color: !_isOpen ? kGreyColor.withOpacity(0.5) : Colors.black,
          ),
          SizedBox(width: kDefaultPadding / 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${_opt!.openHr} ${_getTimePeriodUnit(_opt!.openHr)}',
                style: TextStyle(
                  color: !_isOpen ? kGreyColor.withOpacity(0.5) : Colors.black,
                ),
              ),
              Text(
                '${_opt!.closeHr} ${_getTimePeriodUnit(_opt!.closeHr)}',
                style: TextStyle(
                  color: !_isOpen ? kGreyColor.withOpacity(0.5) : Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
