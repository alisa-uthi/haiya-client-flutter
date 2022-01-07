import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/category.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/models/product.dart';
import 'package:haiya_client/shared/services/inventory_service.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';
import 'package:haiya_client/shared/widgets/consultation_btn.dart';
import 'package:haiya_client/shared/widgets/loader.dart';
import 'package:haiya_client/shared/widgets/product_list.dart';

import 'widgets/header_section.dart';

class ProductListScreen extends StatefulWidget {
  static final routeName = '/products';
  final Category category;
  final int? pharmacyId;
  final String? pharmacyName;

  const ProductListScreen({
    Key? key,
    required this.category,
    this.pharmacyId,
    this.pharmacyName,
  }) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String _searchText = '';
  bool _isLoading = true;
  late List<Product> _allProducts;
  List<Product> _filteredResult = [];
  late SearchBar searchBar;
  InventoryService _inventoryService = new InventoryService();

  @override
  void initState() {
    super.initState();
    _fetchData();

    searchBar = new SearchBar(
      inBar: false,
      buildDefaultAppBar: _buildAppBar,
      setState: setState,
      onSubmitted: _onValueChanged,
      onChanged: _onValueChanged,
      onCleared: _clearText,
      onClosed: _clearText,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onValueChanged(String value) {
    setState(
      () => {
        _searchText = value,
        _filteredResult = _allProducts
            .where((product) => product.tradeName
                .toLowerCase()
                .contains(_searchText.toLowerCase()))
            .toList()
      },
    );
  }

  void _clearText() {
    setState(
      () => {
        _searchText = '',
        _filteredResult = _allProducts,
      },
    );
  }

  Future<dynamic> _fetchData() async {
    if (widget.pharmacyId != null) {
      await _getProductByCategoryAndPharmacy(widget.pharmacyId!);
    } else if (widget.pharmacyName != null) {
      int tempPharmacyId = allPharmacies
          .firstWhere((phar) => phar.name == widget.pharmacyName)
          .id;
      await _getProductByCategoryAndPharmacy(tempPharmacyId);
    } else {
      await _getProductByCategory();
    }

    setState(() => _isLoading = false);
  }

  _getProductByCategoryAndPharmacy(int pharmacyId) async {
    var products;
    products = await _inventoryService.getProductByCategoryAndPharmacy(
      pharmacyId,
      widget.category.id,
    );
    setState(() {
      _allProducts = products;
      _filteredResult = products;
    });
  }

  _getProductByCategory() async {
    var products;
    products = await _inventoryService.getProductByCategory(widget.category.id);
    setState(() {
      _allProducts = products;
      _filteredResult = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(index: 0),
      appBar: searchBar.build(context),
      body: !_isLoading
          ? SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HeaderSection(
                      category: widget.category,
                      pharmacyId: widget.pharmacyId,
                      pharmacyName: widget.pharmacyName,
                    ),
                    SizedBox(height: kDefaultPadding / 1.5),
                    if (widget.pharmacyName != null &&
                        widget.pharmacyName != "")
                      ConsultationBtn(
                          pharmacyId: widget.pharmacyId!,
                          pharmacyName: widget.pharmacyName!),
                    Container(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Column(
                        children: [
                          ProductList(
                            products: _filteredResult,
                            itemCount: _filteredResult.length,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          : Loader(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        widget.pharmacyName == null
            ? widget.category.name
            : widget.pharmacyName!,
        style: TextStyle(color: Colors.black),
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: true,
      actions: [searchBar.getSearchAction(context)],
    );
  }
}
