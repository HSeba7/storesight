import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storesight/components/custom_button.dart';
import 'package:storesight/components/custom_formField.dart';
import 'package:storesight/components/custom_navigation.dart';
import 'package:storesight/components/custom_text.dart';
import 'package:storesight/constants.dart';
import 'package:storesight/services/alert_service.dart';
import 'package:storesight/size_config.dart';
import 'package:storesight/view_models/forget_cubit/cubit.dart';
import 'package:storesight/view_models/forget_cubit/states.dart';
import 'package:storesight/views/auth_views/change_password.dart';
import 'package:storesight/views/auth_views/widgets/background_view.dart';
import 'package:storesight/views/auth_views/widgets/logo_widget.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundView(arcHeight: 475),
          SafeArea(
              child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
            listener: (context, state) {
              if (state is ResendPasswordSuccess) {
                navigateTo(
                  view: const ConfirmPasswordView(),
                  context: context,
                );
              } else if (state is ResendPasswordError) {
                AlertService.showSnackbarAlert(
                  state.error.toString(),
                  SnackbarType.error,
                  context,
                );
              }
            },
            builder: (context, state) {
              ForgetPasswordCubit cubit = ForgetPasswordCubit.get(context);
              return Form(
                key: cubit.formKey2,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: height(28),
                    ),
                    const LogoWidget(),
                    SizedBox(
                      height: height(170),
                    ),
                    Container(
                      width: double.infinity,
                      margin: padding,
                      padding: EdgeInsets.symmetric(
                        horizontal: width(22),
                        vertical: height(24),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: color.primaryColorDark,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            fontSize: width(22),
                            text: "Resetowanie Hasła",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: height(25),
                          ),
                          CustomFormField(
                            hintText: "Wpisz swój adres email",
                            label: "Adres Email",
                            onChange: (value) {
                              cubit.onChangeEmail(value: value);
                            },
                          ),
                          SizedBox(
                            height: height(15),
                          ),
                          CustomButton(
                            showLoader: state is ResendPasswordLoading,
                            radius: 5,
                            btnHeight: 50,
                            fontSize: width(14),
                            function: () {
                              if (cubit.formKey2.currentState!.validate()) {
                                cubit.forgetPassword();
                              }
                            },
                            text: "Resetuj hasło",
                            fontColor: color.primaryColorLight,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height(160),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          fontSize: width(13),
                          text: "Pamiętasz hasło?",
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: height(5),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CustomText(
                            fontSize: width(13),
                            text: "Logowanie",
                            color: color.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
