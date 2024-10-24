import 'package:flutter/material.dart';
import 'package:storesight/components/custom_text.dart';
import 'package:storesight/size_config.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Dialog(
      backgroundColor: color.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
          width: double.infinity,
          height: height(180),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color.scaffoldBackgroundColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(
              width(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Logout",
                  fontSize: width(14),
                ),
                CustomText(
                  text: "Are you sure you want to logout?",
                  fontSize: width(12),
                  color: color.disabledColor,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: onTap,
                      child: CustomText(
                        text: "yes",
                        fontSize: width(14),
                        color: color.primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: width(25),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CustomText(
                          text: "No",
                          color: color.primaryColorDark,
                          fontSize: width(14),
                        )),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
