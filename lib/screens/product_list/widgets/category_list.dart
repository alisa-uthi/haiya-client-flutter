import 'package:flutter/material.dart';
import 'package:haiya_client/screens/product_list/product_list_screen.dart';

import '../../../constants.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    Key? key,
    required this.selectedCategory,
  }) : super(key: key);

  final String selectedCategory;

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String _selectedCategory = 'Drug';

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  List<String> categories = [
                    'Drug',
                    'Supplementary',
                    'Cosmeceutical',
                    'Equipment',
                  ];

                  return _buildCategoryOption(categories[index]);
                }),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryOption(String categoryName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = categoryName;
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  ProductListScreen(category: categoryName),
              transitionDuration: Duration(seconds: 0),
            ),
          );
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultPadding),
          color: _selectedCategory == categoryName ? kPrimaryColor : kGreyColor,
        ),
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        margin: const EdgeInsets.only(right: kDefaultPadding / 2),
        child: Text(
          categoryName,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
