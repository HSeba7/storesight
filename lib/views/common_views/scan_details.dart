import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storesight/components/custom_text.dart';
import 'package:storesight/constants.dart';
import 'package:storesight/size_config.dart';
import 'package:storesight/view_models/scan_cubit/scan_cubit.dart';
import 'package:storesight/view_models/scan_cubit/scan_state.dart';
import 'package:storesight/views/client_views/widgets/back_widget.dart';

class ScanDetailsView extends StatelessWidget {
  const ScanDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: padding,
        child: BlocConsumer<ScanCubit, ScanState>(
          listener: (context, state) {
            if (state is ScanSuccessState) {}
          },
          builder: (context, state) {
            ScanCubit cubit = ScanCubit.get(context);
            return Column(
              children: [
                const BackWidget(),
                SizedBox(
                  height: height(25),
                ),
                CustomText(
                  text: "Informacje o produkcie",
                  fontSize: width(24),
                ),
                SizedBox(
                  height: height(25),
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(cubit.productImage!.path),
                      fit: BoxFit.cover,
                      width: width(200),
                      height: height(200),
                    ),
                  ),
                ),
                SizedBox(
                  height: height(25),
                ),
                if (cubit.detectLabelsResponse != null) ...[
                  Center(
                    child: CustomText(
                      text: cubit.detectLabelsResponse!.labels![0].name!,
                      fontSize: width(16),
                      color: color.primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: height(15),
                  ),
                  Center(
                    child: CustomText(
                        text: cubit.detectLabelsResponse!.labels![0]
                            .categories![0].name!,
                        fontSize: width(16)),
                  ),
                ],
                if (cubit.detectLabelsResponse == null ||
                    cubit.detectLabelsResponse?.labels == null) ...[
                  Center(
                    child: CustomText(
                      text: "Brak informacji o produkcie",
                      fontSize: width(16),
                      color: color.primaryColor,
                    ),
                  ),
                ]
              ],
            );
          },
        ),
      )),
    );
  }
}
