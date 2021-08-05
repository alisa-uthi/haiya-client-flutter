import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/nearest_pharmacy/widgets/pharmacy_detail_card.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/services/constant_service.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';

class NearestPharmacyScreen extends StatefulWidget {
  static final routeName = '/nearest-pharmacy';

  @override
  _NearestPharmacyScreenState createState() => _NearestPharmacyScreenState();
}

class _NearestPharmacyScreenState extends State<NearestPharmacyScreen> {
  String _searchText = '';
  List<Pharmacy> _nearestPharmacies = [];
  List<Pharmacy> _filteredResult = [];
  late SearchBar searchBar;

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Nearest Pharmacy",
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
        _filteredResult = _nearestPharmacies
            .where((phar) =>
                phar.name.toLowerCase().contains(_searchText.toLowerCase()))
            .toList()
      },
    );
  }

  void clearText() {
    setState(
      () => {_searchText = '', _filteredResult = _nearestPharmacies},
    );
  }

  void initState() {
    setState(() {
      _nearestPharmacies = ConstantService.dummyPharmacies();
      _filteredResult = _nearestPharmacies;
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
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(index: 0),
      appBar: searchBar.build(context),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  _filteredResult.length,
                  (index) {
                    return PharmacyDetailCard(pharmacy: _filteredResult[index]);
                  },
                ).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
