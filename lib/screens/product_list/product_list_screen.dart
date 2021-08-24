import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/category.dart';
import 'package:haiya_client/shared/models/product.dart';
import 'package:haiya_client/shared/services/constant_service.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';
import 'package:haiya_client/shared/widgets/product_list.dart';

import 'widgets/category_list.dart';
import 'widgets/header_section.dart';

class ProductListScreen extends StatefulWidget {
  static final routeName = '/products';
  final Category category;
  final int? pharmacy;

  const ProductListScreen({
    Key? key,
    required this.category,
    this.pharmacy,
  }) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String _searchText = '';
  List<Product> _allProducts = [];
  List<Product> _filteredResult = [];
  late SearchBar searchBar;

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        widget.category.name,
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      actions: [searchBar.getSearchAction(context)],
    );
  }

  void onValueChanged(String value) {
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

  void clearText() {
    setState(
      () => {_searchText = '', _filteredResult = _allProducts},
    );
  }

  void initState() {
    setState(() {
      // TODO: All products should be based on category and pharmacy, so no need to where() again ////
      _allProducts = ConstantService.dummyProducts();
      if (widget.pharmacy == null) {
        _filteredResult = _allProducts
            .where((product) => product.category[0].category
                .toLowerCase()
                .contains(widget.category.name.toLowerCase()))
            .toList();
      } else {
        // If user select nearest pharmacy, products will be based on pharmacy
        _filteredResult = _allProducts.where((product) {
          return product.category[0].category
              .toLowerCase()
              .contains(widget.category.name.toLowerCase());
        }).toList();
      }
      //////////////////////////////////////////////
    });

    searchBar = new SearchBar(
      inBar: false,
      buildDefaultAppBar: _buildAppBar,
      setState: setState,
      onSubmitted: onValueChanged,
      onChanged: onValueChanged,
      onCleared: clearText,
      onClosed: clearText,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(index: 0),
      appBar: searchBar.build(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderSection(category: widget.category),
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
      ),
    );
  }
}
