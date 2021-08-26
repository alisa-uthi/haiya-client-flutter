import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';

import 'widgets/pharmacy_detail_card.dart';

class PharmacyDetailListScreen extends StatefulWidget {
  static final routeName = '/nearest-pharmacy';

  PharmacyDetailListScreen({
    Key? key,
    required this.title,
    required this.pharmacies,
  }) : super(key: key);

  final String title;
  final List<Pharmacy> pharmacies;

  @override
  _PharmacyDetailListScreenState createState() =>
      _PharmacyDetailListScreenState();
}

class _PharmacyDetailListScreenState extends State<PharmacyDetailListScreen> {
  String _searchText = '';
  List<Pharmacy> _filteredResult = [];
  late SearchBar searchBar;

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      actions: [searchBar.getSearchAction(context)],
    );
  }

  void onValueChanged(String value) {
    setState(
      () {
        _searchText = value;
        _filteredResult = widget.pharmacies
            .where((phar) =>
                phar.name.toLowerCase().contains(_searchText.toLowerCase()))
            .toList();
      },
    );
  }

  void clearText() {
    setState(
      () => {_searchText = '', _filteredResult = widget.pharmacies},
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _filteredResult = widget.pharmacies;
    });

    searchBar = new SearchBar(
      inBar: false,
      buildDefaultAppBar: _buildAppBar,
      setState: setState,
      onSubmitted: onValueChanged,
      clearOnSubmit: false,
      closeOnSubmit: false,
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
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: _filteredResult.length != 0
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      ...List.generate(
                        _filteredResult.length,
                        (index) {
                          return PharmacyDetailCard(
                            pharmacy: _filteredResult[index],
                          );
                        },
                      ).toList(),
                    ],
                  ),
                )
              : Center(
                  child: Text("No Result Found."),
                ),
        ),
      ),
    );
  }
}
