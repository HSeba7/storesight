import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storesight/components/custom_button.dart';
import 'package:storesight/components/custom_formField.dart';
import 'package:storesight/components/custom_text.dart';
import 'package:storesight/constants.dart';
import 'package:storesight/services/alert_service.dart';
import 'package:storesight/size_config.dart';
import 'package:storesight/view_models/auth_cubit/auth_cubit.dart';
import 'package:storesight/view_models/auth_cubit/auth_state.dart';
import 'package:storesight/views/auth_views/widgets/background_view.dart';
import 'package:storesight/views/auth_views/widgets/logo_widget.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
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
                if (state is CreateUserSuccess) {
                  Navigator.pop(context);
                  AlertService.showSnackbarAlert(
                    "Konto utworzone pomyślnie",
                    SnackbarType.success,
                    context,
                  );
                } else if (state is CreateUserError) {
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
                  key: cubit.formKey2,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: height(28),
                      ),
                      const LogoWidget(),
                      SizedBox(
                        height: height(30),
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
                              text: "Rejestracja",
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: height(25),
                            ),
                            CustomFormField(
                              hintText: "Podaj swoje imię",
                              label: "Imię",
                              onChange: (value) {
                                cubit.chooseName(value: value);
                              },
                            ),
                            SizedBox(
                              height: height(15),
                            ),
                            CustomFormField(
                              hintText: "Wpisz swój adres email",
                              label: "Adres Email",
                              onChange: (value) {
                                cubit.chooseEmail(value: value);
                              },
                            ),
                            SizedBox(
                              height: height(15),
                            ),
                            CustomFormField(
                              hintText: "Nadaj hasło do aplikacji",
                              label: "Hasło",
                              onChange: (value) {
                                cubit.choosePassword(value: value);
                              },
                              suffix: Padding(
                                padding:
                                    EdgeInsetsDirectional.only(end: width(15)),
                                child: SvgPicture.asset(
                                  "assets/icons/eye.svg",
                                  width: width(18),
                                  height: height(18),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height(15),
                            ),
                            CustomFormField(
                              hintText: "Powtórz wpisane wyżej hasło",
                              label: "Powtórz hasło",
                              validate: (value) {
                                if (value!.isEmpty ||
                                    value != cubit.signUpRequest.password) {
                                  return "";
                                }
                                return null;
                              },
                              onChange: (value) {
                                cubit.chooseConfirmPassword(value: value);
                              },
                              suffix: Padding(
                                padding:
                                    EdgeInsetsDirectional.only(end: width(10)),
                                child: SvgPicture.asset(
                                  "assets/icons/eye.svg",
                                  width: width(18),
                                  height: height(18),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height(15),
                            ),
                            CustomButton(
                              showLoader: state is CreateUserLoading,
                              radius: 5,
                              btnHeight: 50,
                              fontSize: width(14),
                              function: () {
                                if (cubit.formKey2.currentState!.validate()) {
                                  cubit.creatUser();
                                }
                              },
                              text: "Rejestruj się",
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
                            text: "Już masz konto?",
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
