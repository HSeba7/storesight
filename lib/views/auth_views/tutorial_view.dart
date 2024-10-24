import 'package:flutter/material.dart';
import 'package:storesight/components/custom_button.dart';
import 'package:storesight/components/custom_navigation.dart';
import 'package:storesight/components/custom_text.dart';
import 'package:storesight/infrastructure/local_storage.dart';
import 'package:storesight/size_config.dart';
import 'package:storesight/views/auth_views/login_view.dart';

class TutorialView extends StatelessWidget {
  const TutorialView({super.key, this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var color = Theme.of(context);
    return Scaffold(
      extendBody: true,
      body: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Column(
            children: [
              Image.asset(
                "assets/images/tutorial.png",
                width: double.infinity,
                height: height(590),
                fit: BoxFit.cover,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: color.primaryColorDark,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width(20),
                          vertical: height(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              fontSize: width(38),
                              text: "Proste zakupy\nz StoreSight",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: height(10),
                            ),
                            CustomText(
                              fontSize: width(14),
                              maxlines: 3,
                              text:
                                  "Włącz aplikację, i skanuj\nprodukty by poznawać więcej, i zamawiać\nswoje produkty online",
                            ),
                          ],
                        ),
                      ),
                      CustomButton(
                        radius: 0,
                        btnWidth: width(320),
                        btnHeight: 60,
                        fontSize: width(18),
                        svgLeadingIcon: Icon(
                          Icons.arrow_forward,
                          color: color.primaryColorLight,
                          size: 35,
                        ),
                        function: onTap ??
                            () {
                              navigateTo(
                                view: const LoginView(),
                                context: context,
                              );
                              LocalStorage()
                                  .setBool(LocalStorageKeys.boardingKey, true);
                            },
                        text: "Zaczynamy",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width(25),
                    vertical: height(40),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: width(40),
                        height: height(4),
                        decoration: BoxDecoration(
                          color: index == 2
                              ? color.colorScheme.secondaryContainer
                              : color.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
