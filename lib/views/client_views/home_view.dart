import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storesight/components/custom_formField.dart';
import 'package:storesight/components/custom_text.dart';
import 'package:storesight/constants.dart';
import 'package:storesight/size_config.dart';
import 'package:storesight/view_models/home_cubit/home_cubit.dart';
import 'package:storesight/view_models/home_cubit/home_state.dart';
import 'package:storesight/views/auth_views/widgets/logo_widget.dart';
import 'package:storesight/views/client_views/widgets/product_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color.colorScheme.secondary,
          ),
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              HomeCubit cubit = HomeCubit.get(context);
              return Column(
                children: [
                  SizedBox(
                    height: height(10),
                  ),
                  const LogoWidget(),
                  SizedBox(
                    height: height(35),
                  ),
                  CustomSearchForm(
                    onChange: (value) {},
                    hintText: "Szukaj Sklepów",
                  ),
                  SizedBox(
                    height: height(20),
                  ),
                  Expanded(
                    child: ConditionalBuilder(
                        condition: state is! GetProductsLoadingState,
                        fallback: (context) => const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                        builder: (context) {
                          return cubit.products.isNotEmpty
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) => ProductCard(
                                    productModel: cubit.products[index],
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: height(10),
                                  ),
                                  itemCount: cubit.products.length,
                                )
                              : Center(
                                  child: CustomText(
                                    fontSize: width(18),
                                    text: "No Products Yet",
                                    color: color.primaryColor,
                                  ),
                                );
                        }),
                  ),
                ],
              );
            },
          ),
        ),
        Container(
          height: height(215),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.cardColor.withOpacity(0),
                color.cardColor.withOpacity(0.84),
                color.cardColor,
              ],
              begin: Alignment.center,
              end: Alignment.bottomCenter,
            ),
          ),
        )
      ],
    );
  }
}
