import 'package:flutter/material.dart';
import 'package:haiya_client/shared/models/category.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/models/product.dart';
import 'package:haiya_client/shared/services/inventory_service.dart';
import 'package:haiya_client/shared/widgets/custom_snackbar.dart';
import 'package:haiya_client/shared/widgets/loader.dart';

import '../../constants.dart';
import 'widgets/address_section.dart';
import 'widgets/header_section.dart';
import 'widgets/operation_time_section.dart';
import 'widgets/product_section.dart';

class PharmacyScreen extends StatefulWidget {
  static final routeName = '/pharmacy';
  const PharmacyScreen({
    Key? key,
    required this.pharmacyId,
  }) : super(key: key);

  final int pharmacyId;

  @override
  _PharmacyScreenState createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  Category _category = allCategories[0];
  Pharmacy? _pharmacy;
  List<Product> _products = [];
  bool _isLoading = true;
  InventoryService _inventoryService = new InventoryService();

  @override
  void initState() {
    super.initState();
    _fecthData();
  }

  Future<dynamic> _fecthData() async {
    await _fetchPharmacy();
    await _fetchProducts();
    setState(() => _isLoading = false);
  }

  Future<dynamic> _fetchPharmacy() async {
    Pharmacy? result =
        await _inventoryService.getPharmacyById(widget.pharmacyId);
    if (result != null) {
      setState(() => _pharmacy = result);
    } else {
      CustomSnackBar.buildSnackbar(
        context,
        "Error occurred. Please try again.",
      );
    }
  }

  Future<dynamic> _fetchProducts() async {
    List<Product> result =
        await _inventoryService.getProductByCategoryAndPharmacy(
      _pharmacy!.id,
      _category.id,
    );
    if (result.length > 0) {
      setState(() => _products = result);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text("Pharmacy Detail"),
      centerTitle: true,
    );

    return Scaffold(
      appBar: appBar,
      body: _isLoading || _pharmacy == null
          ? Loader()
          : Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                kDefaultPadding,
                0,
                kDefaultPadding,
                kDefaultPadding,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Header
                    HeaderSection(pharmacy: _pharmacy),
                    SizedBox(height: kDefaultPadding * 1.5),

                    // Address
                    AddressSection(address: _pharmacy!.address!),
                    SizedBox(height: kDefaultPadding * 1.5),

                    // Operation Time
                    OperationTimeSection(
                      operationTime: _pharmacy!.operationTime!,
                    ),
                    SizedBox(height: kDefaultPadding * 1.5),

                    // Product
                    ProductSection(
                      category: _category,
                      pharmacy: _pharmacy!,
                      products: _products,
                    ),
                    SizedBox(height: kDefaultPadding * 1.5),

                    // Rating and review
                  ],
                ),
              ),
            ),
    );
  }
}
