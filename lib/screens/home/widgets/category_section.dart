import 'package:flutter/material.dart';
import 'package:haiya_client/constants.dart';

class CategorySection extends StatefulWidget {
  CategorySection({Key? key}) : super(key: key);

  @override
  _CategorySectionState createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  int _selectedIndex = 0;

  final List<String> _categoryName = [
    'Drug',
    'Supplementary',
    'Cosmeceutical',
    'Equipment',
  ];

  final List<IconData> _categoryIcon = [
    Icons.medication_rounded,
    Icons.all_inbox_rounded,
    Icons.auto_awesome_sharp,
    Icons.medical_services,
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          4,
          (index) {
            return _buildCategoryOption(
              index,
              _categoryName[index],
              _categoryIcon[index],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryOption(int index, String categoryName, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() => _selectedIndex = index);
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
                color: _selectedIndex == index ? kPrimaryColor : Colors.white,
              ),
              child: Icon(
                icon,
                color: _selectedIndex == index ? Colors.white : Colors.black38,
                size: 30,
              ),
            ),
            SizedBox(height: kDefaultPadding / 2),
            Text(
              categoryName,
              style: TextStyle(
                color: _selectedIndex == index ? kPrimaryColor : Colors.black,
              ),
              overflow: TextOverflow.clip,
            ),
          ],
        ),
      ),
    );
  }
}
