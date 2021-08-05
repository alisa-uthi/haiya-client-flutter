import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/home/widgets/category_section.dart';
import 'package:haiya_client/screens/home/widgets/nearest_phamacy_list.dart';
import 'package:haiya_client/screens/home/widgets/recommended_products.dart';
import 'package:haiya_client/shared/widgets/bottom_navigator_bar.dart';
import 'package:haiya_client/shared/widgets/title_section.dart';

class HomeScreen extends StatelessWidget {
  static final routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(index: 0),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: kDefaultPadding),
                CategorySection(),
                SizedBox(height: kDefaultPadding * 2),
                TitleSection(
                  title: 'Nearest Pharmacy',
                  moreText: "See more",
                  onMoreTap: () {},
                ),
                SizedBox(height: kDefaultPadding),
                NearestPharmacyList(),
                SizedBox(height: kDefaultPadding * 2),
                TitleSection(
                  title: 'Recommended Products',
                  moreText: "",
                  onMoreTap: () {},
                ),
                SizedBox(height: kDefaultPadding),
                RecommendedProductsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
