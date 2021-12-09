import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/pharmacy_detail_list/phamacy_detail_list_screen.dart';
import 'package:haiya_client/shared/models/pharmacy.dart';
import 'package:haiya_client/shared/services/inventory_service.dart';
import 'package:haiya_client/shared/widgets/loader.dart';
import 'package:haiya_client/shared/widgets/pharmacy_list.dart';
import 'package:haiya_client/shared/widgets/title_section.dart';

class AllPharmacies extends StatefulWidget {
  const AllPharmacies({Key? key}) : super(key: key);

  @override
  _AllPharmaciesState createState() => _AllPharmaciesState();
}

class _AllPharmaciesState extends State<AllPharmacies> {
  InventoryService _inventoryService = new InventoryService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (allPharmacies.isEmpty) {
      _getAllPharmacies();
    } else {
      setState(() => _isLoading = false);
    }
  }

  _getAllPharmacies() async {
    await _inventoryService.getAllPharmacies();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container()
        : Column(
            children: [
              TitleSection(
                title: 'Pharmacy',
                moreText: 'See more',
                onMoreTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          PharmacyDetailListScreen(
                        title: 'Pharmacy',
                        pharmacies: allPharmacies,
                      ),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
              ),
              SizedBox(height: kDefaultPadding),
              if (allPharmacies.isNotEmpty)
                PharmacyList(pharmacies: allPharmacies, itemCount: 6),
              SizedBox(height: kDefaultPadding),
            ],
          );
  }
}
