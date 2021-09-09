import 'package:flutter/material.dart';
import 'package:haiya_client/screens/product_list/product_list_screen.dart';
import 'package:haiya_client/shared/models/category.dart';

import '../../../constants.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    Key? key,
    required this.selectedCategory,
    this.pharmacyId,
    this.pharmacyName,
  }) : super(key: key);

  final Category selectedCategory;
  final int? pharmacyId;
  final String? pharmacyName;

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late Category _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
  }

  @override
  void dispose() {
    super.dispose();
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
                  return _buildCategoryOption(allCategories[index]);
                }),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryOption(Category category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  ProductListScreen(
                category: category,
                pharmacyId: widget.pharmacyId,
                pharmacyName: widget.pharmacyName,
              ),
              transitionDuration: Duration(seconds: 0),
            ),
          ).then((_) => setState(() {}));
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultPadding),
          color: _selectedCategory == category ? kPrimaryColor : kGreyColor,
        ),
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        margin: const EdgeInsets.only(right: kDefaultPadding / 2),
        child: Text(
          category.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
