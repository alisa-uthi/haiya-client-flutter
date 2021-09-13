import 'package:flutter/material.dart';
import 'package:haiya_client/screens/rate_pharmacy/widgets/rating_review_form.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/services/inventory_service.dart';
import 'package:haiya_client/shared/widgets/custom_snackbar.dart';
import 'package:haiya_client/shared/widgets/header_text.dart';
import 'package:haiya_client/shared/widgets/loader.dart';

import '../../constants.dart';

class RatePharmacyScreen extends StatefulWidget {
  static final routeName = '/rate-pharmacy';

  final String pharmacyName;

  const RatePharmacyScreen({
    Key? key,
    required this.pharmacyName,
  }) : super(key: key);

  @override
  _RatePharmacyScreenState createState() => _RatePharmacyScreenState();
}

class _RatePharmacyScreenState extends State<RatePharmacyScreen> {
  InventoryService _inventoryService = new InventoryService();
  Pharmacy? _pharmacy;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPharmacy();
  }

  Future<void> _fetchPharmacy() async {
    if (!mounted) return;

    Pharmacy? result =
        await _inventoryService.getPharmacyByName(widget.pharmacyName);

    if (result != null) {
      setState(() => _pharmacy = result);
    } else {
      CustomSnackBar.buildSnackbar(context, kGeneralError);
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kDefaultPadding),
        child: SingleChildScrollView(
          child: !_isLoading && _pharmacy != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: kDefaultPadding * 2),
                    Icon(
                      Icons.house_rounded,
                      size: 100,
                    ),
                    SizedBox(height: kDefaultPadding * 1.5),
                    HeaderText(text: "Pharmacy"),
                    HeaderText(text: widget.pharmacyName),
                    SizedBox(height: kDefaultPadding * 2),
                    RatingReviewForm(pharmacyId: _pharmacy!.id),
                  ],
                )
              : Loader(),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        "Rate Pharmacy",
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
