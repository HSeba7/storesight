import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storesight/components/circle_image.dart';
import 'package:storesight/components/custom_button.dart';
import 'package:storesight/components/custom_formField.dart';
import 'package:storesight/components/custom_navigation.dart';
import 'package:storesight/components/custom_text.dart';
import 'package:storesight/constants.dart';
import 'package:storesight/services/alert_service.dart';
import 'package:storesight/size_config.dart';
import 'package:storesight/view_models/app_cubit/cubit.dart';
import 'package:storesight/view_models/app_cubit/states.dart';
import 'package:storesight/view_models/client_cubit/cubit.dart';
import 'package:storesight/views/auth_views/login_view.dart';
import 'package:storesight/views/client_views/widgets/back_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is UpdateUserDataErrorState) {
          AlertService.showSnackbarAlert(
            state.error,
            SnackbarType.error,
            context,
          );
        } else if (state is UpdateUserDataSuccessState) {
          AlertService.showSnackbarAlert(
            "Informacje o użytkowniku zostały pomyślnie zaktualizowane",
            SnackbarType.success,
            context,
          );
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: ConditionalBuilder(
              condition: state is! GetUserDataLoadingState,
              fallback: (context) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
              builder: (context) {
                return Container(
                  padding: padding,
                  decoration: BoxDecoration(
                    color: color.colorScheme.secondary,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BackWidget(
                              onBack: () {
                                if (cubit.isChangePass) {
                                  cubit.togglePassword();
                                } else {
                                  ClientCubit.get(context).changeIndex(0);
                                }
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                cubit.logout();
                                navigateReplacment(
                                  view: const LoginView(),
                                  context: context,
                                );
                                ClientCubit.get(context).changeIndex(0);
                              },
                              child: Icon(
                                Icons.logout_rounded,
                                color: color.primaryColorLight,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height(28),
                        ),
                        ProfilePictureWidget(
                          profileImage: cubit.profilePic,
                          onPickImage: (file) {
                            cubit.chooseProfilePic(value: file);
                          },
                          profileImageUrl: cubit.userAccount!.profilePic != ""
                              ? "$baseUrl${cubit.userAccount!.profilePic}"
                              : null,
                        ),
                        SizedBox(
                          height: height(10),
                        ),
                        CustomText(
                          fontSize: width(20),
                          text: cubit.userAccount!.fullname!,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: height(20),
                        ),
                        if (!cubit.isChangePass)
                          Column(
                            children: [
                              CustomFormField(
                                label: "Twoje dane",
                                hintText: "Przykładowe imię",
                                type: TextInputType.emailAddress,
                                onChange: (value) {
                                  cubit.changeName(value: value);
                                },
                              ),
                              SizedBox(
                                height: height(15),
                              ),
                              CustomFormField(
                                label: "Numer telefonu",
                                hintText: "+1 123456789",
                                type: TextInputType.phone,
                                onChange: (value) {
                                  cubit.changePhone(value: value);
                                },
                              ),
                              SizedBox(
                                height: height(15),
                              ),
                              CustomFormField(
                                isPassword: true,
                                label: "Hasło",
                                helperText: "Aktualizuj",
                                hintText: "**********",
                                isClickable: false,
                                type: TextInputType.visiblePassword,
                                suffix: SvgPicture.asset(
                                  "assets/icons/eye.svg",
                                  width: width(18),
                                  height: height(18),
                                  fit: BoxFit.scaleDown,
                                ),
                                onTap: () {
                                  cubit.togglePassword();
                                },
                              ),
                              SizedBox(
                                height: height(15),
                              ),
                              CustomFormField(
                                label: "Email",
                                hintText: "EMAIL@test.com",
                                type: TextInputType.emailAddress,
                                onChange: (value) {
                                  cubit.changeEmail(value: value);
                                },
                              ),
                            ],
                          ),
                        if (cubit.isChangePass)
                          Form(
                            key: cubit.formKey,
                            child: Column(
                              children: [
                                CustomFormField(
                                  isPassword: true,
                                  label: "Stare Hasło",
                                  hintText: "Wpisz stare hasło",
                                  type: TextInputType.visiblePassword,
                                  suffix: SvgPicture.asset(
                                    "assets/icons/eye.svg",
                                    width: width(18),
                                    height: height(18),
                                    fit: BoxFit.scaleDown,
                                  ),
                                  onChange: (value) {
                                    cubit.changeOldPassword(value: value);
                                  },
                                ),
                                SizedBox(
                                  height: height(15),
                                ),
                                CustomFormField(
                                  isPassword: true,
                                  label: "Nowe hasło",
                                  hintText: "Wpisz nowe hasło",
                                  type: TextInputType.visiblePassword,
                                  suffix: SvgPicture.asset(
                                    "assets/icons/eye.svg",
                                    width: width(18),
                                    height: height(18),
                                    fit: BoxFit.scaleDown,
                                  ),
                                  onChange: (value) {
                                    cubit.changeNewPasswword(value: value);
                                  },
                                ),
                                SizedBox(
                                  height: height(15),
                                ),
                                CustomFormField(
                                  isPassword: true,
                                  label: "Powtórz nowe hasło",
                                  hintText: "Powtórz nowe hasło",
                                  validate: (value) {
                                    if (value!.isEmpty ||
                                        value !=
                                            cubit.changePassword.newPassword) {
                                      return "";
                                    }
                                    return null;
                                  },
                                  type: TextInputType.visiblePassword,
                                  suffix: SvgPicture.asset(
                                    "assets/icons/eye.svg",
                                    width: width(18),
                                    height: height(18),
                                    fit: BoxFit.scaleDown,
                                  ),
                                  onChange: (value) {
                                    cubit.changeConfirmPasswword(value: value);
                                  },
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: height(15),
                        ),
                        CustomButton(
                          btnHeight: 50,
                          showLoader: state is UpdateUserDataLoadingState,
                          fontSize: width(14),
                          function: () {
                            if (cubit.isChangePass) {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.updatePassword();
                              }
                            } else {
                              cubit.updateUser();
                            }
                          },
                          text: "Zapisz",
                        ),
                        SizedBox(
                          height: height(100),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
