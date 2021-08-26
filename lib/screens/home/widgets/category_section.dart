import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';
import 'package:haiya_client/screens/product_list/product_list_screen.dart';
import 'package:haiya_client/shared/models/category.dart';

class CategorySection extends StatefulWidget {
  CategorySection({
    Key? key,
  }) : super(key: key);

  @override
  _CategorySectionState createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  final List<String> _categoryLogo = [
    'assets/images/medicine.png',
    'assets/images/supplementary.png',
    'assets/images/equipment.png',
    'assets/images/cosmetic.png',
  ];

  @override
  Widget build(BuildContext context) {
    return allCategories.length != 0
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                allCategories.length,
                (index) {
                  return _buildCategoryOption(
                    index,
                    allCategories[index],
                    _categoryLogo[index],
                  );
                },
              ),
            ),
          )
        : Container();
  }

  Widget _buildCategoryOption(int index, Category category, String logo) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (buider, animation1, animation2) =>
                  ProductListScreen(category: category)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(kDefaultPadding / 1.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: kGreyColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(1.0, 7.0),
                  ),
                ],
              ),
              child: Image.asset(
                logo,
                width: 30,
                height: 30,
              ),
            ),
            SizedBox(height: kDefaultPadding / 2),
            Text(
              category.name.contains(' ')
                  ? "${category.name.split(' ')[0]}\n${category.name.split(' ')[1]}"
                  : category.name,
              overflow: TextOverflow.clip,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
