import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storesight/components/custom_app_bar.dart';
import 'package:storesight/components/custom_button.dart';
import 'package:storesight/components/custom_formField.dart';
import 'package:storesight/components/custom_navigation.dart';
import 'package:storesight/components/custom_text.dart';
import 'package:storesight/constants.dart';
import 'package:storesight/services/alert_service.dart';
import 'package:storesight/size_config.dart';
import 'package:storesight/view_models/forget_cubit/cubit.dart';
import 'package:storesight/view_models/forget_cubit/states.dart';
import 'package:storesight/views/auth_views/login_view.dart';

class ConfirmPasswordView extends StatelessWidget {
  const ConfirmPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (context, state) {
      if (state is ConfirmPasswordSuccess) {
        navigateReplacment(
          view: const LoginView(),
          context: context,
        );
        AlertService.showSnackbarAlert(
          "Hasło zostało pomyślnie zmienione",
          SnackbarType.success,
          context,
        );
      } else if (state is ConfirmPasswordError) {
        AlertService.showSnackbarAlert(
          state.error.toString(),
          SnackbarType.error,
          context,
        );
      }
    }, builder: (context, state) {
      ForgetPasswordCubit cubit = ForgetPasswordCubit.get(context);
      return Scaffold(
        body: SafeArea(
            child: Padding(
          padding: padding,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomAppBar(),
                  SizedBox(
                    height: height(80),
                  ),
                  SvgPicture.asset(
                    "assets/icons/password.svg",
                    width: width(90),
                    height: height(90),
                  ),
                  SizedBox(
                    height: height(30),
                  ),
                  CustomText(
                    text: "Zresetuj swoje hasło",
                    fontWeight: FontWeight.w600,
                    fontSize: width(20),
                  ),
                  SizedBox(
                    height: height(60),
                  ),
                  CustomFormField(
                    label: "otp",
                    isPassword: true,
                    type: TextInputType.number,
                    hintText: "Wprowadź kod",
                    onChange: (value) {
                      cubit.onChangeCode(value: value);
                    },
                  ),
                  SizedBox(
                    height: height(25),
                  ),
                  CustomFormField(
                    isPassword: true,
                    label: "nowe hasło",
                    type: TextInputType.visiblePassword,
                    hintText: "Proszę wprowadzić nowe hasło",
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    onChange: (value) {
                      cubit.onChangePassword(value: value);
                    },
                  ),
                  SizedBox(
                    height: height(60),
                  ),
                  CustomButton(
                    showLoader: state is ConfirmPasswordLoading,
                    fontSize: width(20),
                    function: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.confirmPassword();
                      }
                    },
                    text: "Ratować",
                  ),
                ],
              ),
            ),
          ),
        )),
      );
    });
  }
}
