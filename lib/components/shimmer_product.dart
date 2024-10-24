import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:storesight/size_config.dart';

import '../constants.dart';

class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width(270),
        height: height(140),
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.hintColor.withOpacity(0.25),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: width(40),
                  height: height(40),
                  decoration: BoxDecoration(
                    color: color.hintColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: width(12),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width(150),
                      height: height(10),
                      decoration: BoxDecoration(
                        color: color.hintColor.withOpacity(0.15),
                      ),
                    ),
                    SizedBox(
                      height: height(10),
                    ),
                    Container(
                      width: width(120),
                      height: height(10),
                      decoration: BoxDecoration(
                        color: color.hintColor.withOpacity(0.15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: width(60),
                  height: height(20),
                  decoration: BoxDecoration(
                    color: color.hintColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  width: width(15),
                ),
                Container(
                  width: width(60),
                  height: height(20),
                  decoration: BoxDecoration(
                    color: color.hintColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const Spacer(),
                Container(
                  width: width(70),
                  height: height(20),
                  decoration: BoxDecoration(
                    color: color.hintColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    Key? key,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);

  final Axis? scrollDirection;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: scrollDirection!,
        itemBuilder: (context, index) => const ShimmerProductCard(),
        separatorBuilder: (context, index) => scrollDirection == Axis.horizontal
            ? SizedBox(
                width: width(15),
              )
            : SizedBox(
                height: height(25),
              ),
        itemCount: 6);
  }
}
