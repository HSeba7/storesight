import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storesight/components/custom_button.dart';
import 'package:storesight/components/custom_text.dart';
import 'package:storesight/components/expandable_text.dart';
import 'package:storesight/constants.dart';
import 'package:storesight/infrastructure/utils.dart';
import 'package:storesight/models/product_model.dart';
import 'package:storesight/size_config.dart';
import 'package:storesight/views/client_views/widgets/back_widget.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.productModel});

  final StoreModel productModel;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Scaffold(
      backgroundColor: color.colorScheme.secondary,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SafeArea(
            child: Container(
              alignment: Alignment.topCenter,
              width: double.infinity,
              height: SizeConfig.screenHeight,
              color: color.primaryColorLight,
              child: SizedBox(
                height: height(380),
                child: Stack(
                  children: [
                    SizedBox(
                      height: height(380),
                      child: CarouselSlider(
                        items: List.generate(
                          productModel.images!.length,
                          (index) => CachedNetworkImage(
                            imageUrl: productModel.images![index].src,
                            width: double.infinity,
                            height: height(367),
                            fit: BoxFit.cover,
                          ),
                        ),
                        options: CarouselOptions(
                          aspectRatio: 16 / 10,
                          initialPage: 0,
                          viewportFraction: 1,
                          enableInfiniteScroll: true,
                          disableCenter: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 4),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: padding,
                      child: const BackWidget(
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                    SizedBox(
                      height: height(367),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width(10)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/slide-left.svg",
                              height: height(40),
                              color: const Color(0xFF4A4A4A),
                            ),
                            SvgPicture.asset(
                              "assets/icons/slide-right.svg",
                              height: height(40),
                              color: const Color(0xFF4A4A4A),
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: padding,
            width: double.infinity,
            height: height(423),
            decoration: BoxDecoration(
              color: color.colorScheme.secondary,
              boxShadow: [boxShadow],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: productModel.name!,
                              maxlines: 2,
                              fontSize: width(20),
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(
                              height: height(8),
                            ),
                            CustomText(
                              text: productModel.categories![0].name,
                              fontSize: width(12),
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      PriceTag(
                        price: productModel.price!,
                        fontSize: width(24),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(20), //10
                  ),
                  Row(
                    children: [
                      TabWidget(
                        title: "Opis",
                        onTap: () {},
                        isSelected: true,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(10),
                  ),
                  ExpandableText(
                    text: productModel.description!,
                    limit: 100,
                    fontSize: width(14),
                    color: const Color(0xFFE9E9E9),
                  ),
                  SizedBox(
                    height: height(15),
                  ),
                  Center(
                    child: CustomText(
                      fontSize: width(14),
                      text: "Do Strony Producenta",
                      textDecoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(
                    height: height(20),
                  ),
                  Center(
                    child: CustomButton(
                      btnHeight: 50,
                      btnWidth: width(300),
                      fontSize: width(14),
                      function: () {
                        LinkUtil().launchURL(productModel.permalink!);
                      },
                      text: "Do Koszyka",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.onTap,
    required this.title,
    this.isSelected = false,
  });

  final Function() onTap;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          fontSize: width(16),
          text: title,
          fontWeight: FontWeight.w600,
        ),
        if (isSelected)
          Container(
            width: width(30),
            height: 4,
            decoration: BoxDecoration(
              color: color.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
          )
      ],
    );
  }
}
