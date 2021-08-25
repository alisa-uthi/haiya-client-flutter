import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/nearest_pharmacy/widgets/pharmacy_detail_card.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';

class NearestPharmacyScreen extends StatefulWidget {
  static final routeName = '/nearest-pharmacy';

  @override
  _NearestPharmacyScreenState createState() => _NearestPharmacyScreenState();
}

class _NearestPharmacyScreenState extends State<NearestPharmacyScreen> {
  String _searchText = '';
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
        _filteredResult = nearestPharmacies
            .where((phar) =>
                phar.name.toLowerCase().contains(_searchText.toLowerCase()))
            .toList()
      },
    );
  }

  void clearText() {
    setState(
      () => {_searchText = '', _filteredResult = nearestPharmacies},
    );
  }

  void initState() {
    setState(() {
      _filteredResult = nearestPharmacies;
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
                              pharmacy: _filteredResult[index]);
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
