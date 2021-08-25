import 'package:flutter/material.dart';
import 'package:haiya_client/screens/operation_times/operation_times_screen.dart';
import 'package:haiya_client/shared/widgets/loader.dart';
import 'package:intl/intl.dart';
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

  String getCurrentWeekDay() {
    return DateFormat.E().format(DateTime.now());
  }

  OperationTime getCurrentOperationTime() {
    String weekday = getCurrentWeekDay();
    return widget.pharmacy.operationTime!
        .firstWhere((element) => element.optDay == weekday);
  }

  String _getTimePeriodUnit(String time) {
    if (int.parse(time.substring(0, 2)) < 12) {
      return 'AM';
    }
    return 'PM';
  }

  @override
  void initState() {
    super.initState();
    var result = _inventoryService.isPharmacyOpen(getCurrentOperationTime());
    setState(() => {
          _isOpen = result,
          _isLoading = false,
        });
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
                      widget.pharmacy.ratingScore != null
                          ? _buildRatingScore()
                          : Container(),
                      _buildOperationTime(),
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
                '${getCurrentOperationTime().openHr} ${_getTimePeriodUnit(getCurrentOperationTime().openHr)}',
                style: TextStyle(
                  color: !_isOpen ? kGreyColor.withOpacity(0.5) : Colors.black,
                ),
              ),
              Text(
                '${getCurrentOperationTime().closeHr} ${_getTimePeriodUnit(getCurrentOperationTime().closeHr)}',
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
