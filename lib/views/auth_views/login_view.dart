import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storesight/components/custom_button.dart';
import 'package:storesight/components/custom_formField.dart';
import 'package:storesight/components/custom_navigation.dart';
import 'package:storesight/components/custom_text.dart';
import 'package:storesight/constants.dart';
import 'package:storesight/services/alert_service.dart';
import 'package:storesight/size_config.dart';
import 'package:storesight/view_models/app_cubit/cubit.dart';
import 'package:storesight/view_models/auth_cubit/auth_cubit.dart';
import 'package:storesight/view_models/auth_cubit/auth_state.dart';
import 'package:storesight/views/auth_views/forget_password.dart';
import 'package:storesight/views/auth_views/register_view.dart';
import 'package:storesight/views/auth_views/widgets/background_view.dart';
import 'package:storesight/views/auth_views/widgets/logo_widget.dart';
import 'package:storesight/views/client_views/layout_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var color = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundView(
            arcHeight: 575,
          ),
          SafeArea(
            child: BlocConsumer<AuthCubit, AuthStates>(
              listener: (context, state) {
                if (state is LoginUserSuccess) {
                  AppCubit.get(context).getUser();
                  navigateTo(view: const LayoutView(), context: context);
                } else if (state is LoginUserError) {
                  AlertService.showSnackbarAlert(
                    state.error.toString(),
                    SnackbarType.error,
                    context,
                  );
                }
              },
              builder: (context, state) {
                AuthCubit cubit = AuthCubit.get(context);
                return Form(
                  key: cubit.formKey,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: height(90),
                      ),
                      const LogoWidget(),
                      SizedBox(
                        height: height(70),
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
                              text: "Panel Logowania",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: height(15),
                            ),
                            CustomFormField(
                              hintText: "Wpisz swój adres email",
                              label: "Adres Email",
                              onChange: (value) {
                                cubit.chooseLoginEmail(value: value);
                              },
                            ),
                            SizedBox(
                              height: height(15),
                            ),
                            CustomFormField(
                              hintText: "Wpisz swoje hasło",
                              label: "Hasło",
                              onChange: (value) {
                                cubit.chooseLoginPassword(value: value);
                              },
                              suffix: SvgPicture.asset(
                                "assets/icons/eye.svg",
                                width: width(18),
                                height: height(18),
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            SizedBox(
                              height: height(15),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity,
                                  ),
                                  activeColor: color.primaryColor,
                                  value: cubit.isAccepted,
                                  onChanged: (value) {
                                    cubit.chooseAccepted(value: value!);
                                  },
                                ),
                                SizedBox(
                                  width: width(5),
                                ),
                                CustomText(
                                  fontSize: width(14),
                                  text: "Zapamietaj mnie",
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    navigateTo(
                                      view: const ForgetPasswordView(),
                                      context: context,
                                    );
                                  },
                                  child: CustomText(
                                    fontSize: width(12),
                                    text: "Resetowanie hasła",
                                    color: color.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height(15),
                            ),
                            CustomButton(
                              showLoader: state is LoginUserLoading,
                              radius: 5,
                              btnHeight: 50,
                              fontSize: width(14),
                              function: () {
                                if (cubit.formKey.currentState!.validate()) {
                                  cubit.loginUser();
                                }
                              },
                              text: "Zaloguj się",
                              fontColor: color.primaryColorLight,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height(25),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            fontSize: width(13),
                            text: "Niemasz jeszcze konta?",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: height(5),
                          ),
                          GestureDetector(
                            onTap: () {
                              navigateTo(
                                view: const RegisterView(),
                                context: context,
                              );
                            },
                            child: CustomText(
                              fontSize: width(13),
                              text: "Zarejestruj Się",
                              color: color.primaryColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
