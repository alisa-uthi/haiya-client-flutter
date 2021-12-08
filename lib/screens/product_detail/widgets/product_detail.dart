import 'package:flutter/material.dart';
import 'package:haiya_client/screens/pharmacy/pharmacy_screen.dart';
import 'package:haiya_client/screens/product_detail/widgets/order_form.dart';
import 'package:haiya_client/screens/product_detail/widgets/row_detail.dart';
import 'package:haiya_client/shared/models/product.dart';

import '../../../constants.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product? product;

  bool _isPrescriptionRequired() {
    return product!.presReq == 'y' || product!.presReq == 'Y';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product!.tradeName,
          style: Theme.of(context).textTheme.headline1,
          overflow: TextOverflow.clip,
        ),
        SizedBox(height: kDefaultPadding / 2),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    PharmacyScreen(pharmacyId: product!.pharmacyId),
                transitionDuration: Duration(seconds: 0),
              ),
            );
          },
          child: Text(
            product!.pharmacyName,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: kPrimaryColor,
                  decoration: TextDecoration.underline,
                ),
          ),
        ),

        // Generic Name
        SizedBox(height: kDefaultPadding * 2),
        if (product!.genericName != null)
          RowDetail(
            title: "Generic Name",
            detail: product!.genericName!,
          ),
        SizedBox(height: kDefaultPadding / 1.3),

        // Company Name
        if (product!.companyName != null)
          RowDetail(
            title: "Company",
            detail: product!.companyName ?? '',
          ),
        SizedBox(height: kDefaultPadding / 1.3),

        // Detail
        RowDetail(title: "Detail", detail: product!.detail),
        SizedBox(height: kDefaultPadding / 1.3),

        // Generic Advice
        if (product!.genericAdvice != null)
          RowDetail(
            title: "Advice",
            detail: product!.genericAdvice ?? '',
          ),
        SizedBox(height: kDefaultPadding / 1.3),

        // Prescription Requirement
        RowDetail(
          title: "Prescription",
          detail: _isPrescriptionRequired() ? 'Required' : 'Not Required',
          textColor: _isPrescriptionRequired() ? kErrorColor : kSuccessColor,
        ),
        if (_isPrescriptionRequired())
          Column(
            children: [
              SizedBox(height: kDefaultPadding / 2),
              Text(
                "Note: If prescription is required, please contact our pharmacist to continue ordering.",
                style: Theme.of(context).textTheme.caption,
                maxLines: 2,
              ),
            ],
          ),

        SizedBox(height: kDefaultPadding * 2.5),

        OrderForm(product: product!),
      ],
    );
  }
}
