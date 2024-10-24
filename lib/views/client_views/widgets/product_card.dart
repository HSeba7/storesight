import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:storesight/components/custom_button.dart';
import 'package:storesight/components/custom_navigation.dart';
import 'package:storesight/components/custom_text.dart';
import 'package:storesight/constants.dart';
import 'package:storesight/models/product_model.dart';
import 'package:storesight/size_config.dart';
import 'package:storesight/views/common_views/product_details.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productModel});

  final StoreModel productModel;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return GestureDetector(
      onTap: () {
        navigateTo(
          view: ProductDetails(
            productModel: productModel,
          ),
          context: context,
        );
      },
      child: Container(
        padding: padding,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color.primaryColorDark,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [boxShadow],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: productModel.images!.isNotEmpty
                    ? productModel.images![0].src
                    : "",
                width: width(118),
                height: height(118),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: width(14),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: productModel.name!,
                    maxlines: 2,
                    fontSize: width(16),
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    text: productModel.categories![0].name,
                    fontSize: width(12),
                    fontWeight: FontWeight.w600,
                    color: color.hintColor,
                  ),
                  SizedBox(
                    height: height(10),
                  ),
                  PriceTag(
                    price: productModel.price!,
                    fontSize: width(14),
                  ),
                  SizedBox(
                    height: height(10),
                  ),
                  CustomButton(
                    btnWidth: width(140),
                    btnHeight: 33,
                    fontSize: width(16),
                    function: () {},
                    text: "Do Koszyka",
                    radius: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
