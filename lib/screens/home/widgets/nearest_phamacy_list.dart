import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/pharmacy_detail_list/phamacy_detail_list_screen.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/services/inventory_service.dart';
import 'package:haiya_client/shared/widgets/loader.dart';
import 'package:haiya_client/shared/widgets/pharmacy_card.dart';
import 'package:haiya_client/shared/widgets/title_section.dart';

class NearestPharmacyList extends StatefulWidget {
  const NearestPharmacyList({Key? key}) : super(key: key);

  @override
  _NearestPharmacyListState createState() => _NearestPharmacyListState();
}

class _NearestPharmacyListState extends State<NearestPharmacyList> {
  InventoryService _inventoryService = new InventoryService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (nearestPharmacies.isEmpty) {
      _getNearestPharmacies();
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future _getNearestPharmacies() async {
    await _inventoryService.getNearestPharmacies();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loader()
        : Column(
            children: [
              TitleSection(
                title: 'Nearest Pharmacy',
                moreText: "See more",
                onMoreTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          PharmacyDetailListScreen(
                        title: 'Nearest Pharmacy',
                        pharmacies: nearestPharmacies,
                      ),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
              ),
              SizedBox(height: kDefaultPadding),
              nearestPharmacies.length > 0
                  ? GridView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: kDefaultPadding / 2,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (context, index) {
                        return PharmacyCard(pharmacy: nearestPharmacies[index]);
                      },
                    )
                  : !_isLoading
                      ? Center(
                          child: Text(
                              "There is no pharmacy within 10 kilometers."),
                        )
                      : Container(),
              SizedBox(height: kDefaultPadding * 2),
            ],
          );
  }
}
