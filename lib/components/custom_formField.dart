// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storesight/components/custom_text.dart';
import 'package:storesight/size_config.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? type;
  final void Function(String)? onSubmit;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final bool isPassword, isAbout;
  final String? Function(String?)? validate;
  final String label;
  final int? maxLines;
  final int? maxLength;
  final String? hintText, helperText;

  final Widget? prefix;
  final bool isSearch;
  final Widget? suffix, phone;
  final bool isClickable;

  const CustomFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.isClickable = true,
    this.isPassword = false,
    required this.label,
    this.maxLength,
    this.isSearch = false,
    this.maxLines = 1,
    this.onChange,
    this.onSubmit,
    this.onTap,
    this.prefix,
    this.suffix,
    this.type,
    this.validate,
    this.isAbout = false,
    this.phone,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              fontSize: width(14),
              text: label,
              color: color.primaryColorLight,
              fontWeight: FontWeight.w600,
            ),
            GestureDetector(
              onTap: onTap,
              child: CustomText(
                fontSize: width(14),
                text: helperText ?? "",
                color: color.primaryColorLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(
          height: height(5),
        ),
        TextFormField(
          maxLength: maxLength,
          maxLines: maxLines,
          controller: controller,
          keyboardType: type,
          obscureText: isPassword,
          enabled: isClickable,
          onFieldSubmitted: onSubmit,
          onChanged: onChange,
          onTap: onTap,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          textAlignVertical: TextAlignVertical.center,
          validator: validate ??
              (value) {
                if (value!.isEmpty) {
                  return "";
                }
                return null;
              },
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            filled: false,
            errorStyle: const TextStyle(
              height: 0,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            counterText: "",
            focusColor: Colors.transparent,
            prefixIcon: prefix,
            suffixIcon: suffix,
            contentPadding: EdgeInsets.symmetric(
              horizontal: width(15),
              vertical: height(13),
            ),
            hintStyle: TextStyle(
              fontSize: width(14),
              color: color.hintColor,
            ),
            alignLabelWithHint: false,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: color.hintColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: color.hintColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: color.hintColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: color.primaryColor,
              ),
            ),
          ),
          style: TextStyle(
            color: color.hintColor,
            fontSize: width(12),
          ),
        ),
      ],
    );
  }
}

class PhoneDropDown extends StatelessWidget {
  const PhoneDropDown({
    super.key,
    this.value,
  });

  final String? value;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: color.colorScheme.secondary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          context: context,
          builder: (context) => Container(),
        );
      },
      child: Container(
        constraints: BoxConstraints(
          maxHeight: height(70),
          minHeight: height(70),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width(14),
          vertical: height(20),
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(5),
          ),
          color: color.colorScheme.secondary,
        ),
        child: Center(
          child: CustomText(
            fontSize: width(12),
            text: value ?? "+968",
            align: TextAlign.center,
            color: color.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class CustomSearchForm extends StatelessWidget {
  const CustomSearchForm({
    Key? key,
    this.onChange,
    this.enabled = true,
    this.hintText,
    this.fillColor,
  }) : super(key: key);

  final Function(String)? onChange;
  final bool enabled;
  final String? hintText;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return TextFormField(
      onChanged: onChange,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      textInputAction: TextInputAction.search,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        isDense: false,
        hintText: hintText,
        fillColor: fillColor ?? color.colorScheme.secondary,
        filled: true,
        errorStyle: const TextStyle(
          height: 0,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        counterText: "",
        focusColor: Colors.transparent,
        prefixIcon: SvgPicture.asset(
          "assets/icons/search.svg",
          width: width(15),
          height: height(15),
          fit: BoxFit.scaleDown,
        ),
        suffixIcon: SvgPicture.asset(
          "assets/icons/gps.svg",
          width: width(15),
          height: height(15),
          fit: BoxFit.scaleDown,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: width(20),
          vertical: height(18),
        ),
        hintStyle: TextStyle(
          fontSize: width(14),
          color: color.primaryColorLight,
          fontWeight: FontWeight.bold,
        ),
        alignLabelWithHint: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: color.primaryColorLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: color.primaryColorLight,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: color.primaryColorLight,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: color.primaryColorLight,
          ),
        ),
      ),
      style: TextStyle(
        color: color.colorScheme.primaryContainer,
        fontSize: width(12),
      ),
    );
  }
}

class ReportFormField extends StatelessWidget {
  const ReportFormField({
    Key? key,
    this.onChange,
    this.enabled = true,
    this.hintText,
    this.fillColor,
    this.maxLines,
    this.maxLength,
  }) : super(key: key);

  final Function(String)? onChange;
  final bool enabled;
  final String? hintText;
  final Color? fillColor;
  final int? maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color.primaryColorDark.withOpacity(0.16),
            offset: const Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: TextFormField(
        maxLength: maxLength,
        maxLines: maxLines,
        validator: (value) {
          if (value!.isEmpty) {
            return "required field";
          }
          return null;
        },
        onChanged: onChange,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: false,
          hintText: hintText,
          fillColor: color.colorScheme.onSecondaryContainer,
          filled: true,
          errorStyle: const TextStyle(
            height: 0,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          counterText: "",
          focusColor: Colors.transparent,
          suffixIconConstraints: const BoxConstraints(),
          contentPadding: EdgeInsets.symmetric(
            horizontal: width(20),
            vertical: height(6),
          ),
          hintStyle: TextStyle(
            fontSize: width(14),
            color: color.colorScheme.primaryContainer,
          ),
          alignLabelWithHint: false,
          floatingLabelStyle: TextStyle(
            color: color.primaryColor,
            fontSize: width(18),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: color.primaryColor,
            ),
          ),
        ),
        style: TextStyle(
          color: color.colorScheme.primaryContainer,
          fontSize: width(12),
        ),
      ),
    );
  }
}

class CustomEditField extends StatelessWidget {
  const CustomEditField(
      {super.key,
      this.controller,
      this.type,
      this.onSubmit,
      this.onChange,
      this.onTap,
      this.isPassword = false,
      this.isAbout = false,
      this.validate,
      this.label,
      this.maxLines,
      this.helperText,
      this.maxLength,
      this.phone,
      this.isClickable = true,
      this.hinttext});

  final TextEditingController? controller;
  final TextInputType? type;
  final void Function(String)? onSubmit;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final bool isPassword, isAbout;
  final String? Function(String?)? validate;
  final String? label;
  final int? maxLines;
  final String? hinttext, helperText;
  final int? maxLength;
  final Widget? phone;
  final bool isClickable;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Row(
      children: [
        if (phone != null) ...[
          phone!,
          SizedBox(
            width: width(5),
          ),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                fontSize: width(15),
                text: label!,
                color: color.primaryColor,
              ),
              SizedBox(
                height: height(5),
              ),
              TextFormField(
                controller: controller,
                obscureText: isPassword,
                keyboardType: type,
                enabled: isClickable,
                onFieldSubmitted: onSubmit,
                onChanged: onChange,
                onTap: onTap,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                textAlignVertical: TextAlignVertical.center,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: color.colorScheme.surface,
                  filled: true,
                  hintText: hinttext,
                  helperStyle: TextStyle(
                    fontSize: width(12),
                    color: color.primaryColor,
                  ),
                  errorStyle: const TextStyle(
                    height: 0,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  counterText: "",
                  focusColor: Colors.transparent,
                  suffixIcon: Padding(
                    padding: EdgeInsetsDirectional.only(end: width(15)),
                    child: SvgPicture.asset(
                      'assets/icons/pick.svg',
                      width: width(12),
                      height: height(12),
                    ),
                  ),
                  suffixIconConstraints: const BoxConstraints(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: width(15),
                    vertical: height(10),
                  ),
                  hintStyle: TextStyle(
                    fontSize: width(14),
                    color: color.primaryColorDark,
                  ),
                  alignLabelWithHint: false,
                  floatingLabelStyle: TextStyle(
                    color: color.primaryColor,
                    fontSize: width(18),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: phone != null
                        ? const BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          )
                        : BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: phone != null
                        ? const BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          )
                        : BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: phone != null
                        ? const BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          )
                        : BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: phone != null
                        ? const BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          )
                        : BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: color.primaryColor,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: color.primaryColorDark,
                  fontSize: width(12),
                ),
              ),
              if (helperText != null) ...[
                SizedBox(
                  height: height(5),
                ),
                CustomText(
                  fontSize: width(12),
                  text: helperText!,
                  color: color.primaryColor,
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }
}

class WalletFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? type;
  final void Function(String)? onSubmit;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final bool isPassword, isAbout;
  final String? Function(String?)? validate;
  final String? label;
  final int? maxLines;
  final String? hintText, helperText;
  final int? maxLength;
  final Widget? prefix;
  final bool isSearch;
  final Widget? suffix, phone;
  final bool isClickable;

  const WalletFormField({
    Key? key,
    this.hintText,
    this.controller,
    this.isClickable = true,
    this.isPassword = false,
    this.label,
    this.maxLength,
    this.isSearch = false,
    this.maxLines = 1,
    this.onChange,
    this.onSubmit,
    this.onTap,
    this.prefix,
    this.suffix,
    this.type,
    this.validate,
    this.isAbout = false,
    this.phone,
    this.helperText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          fontSize: width(15),
          text: label!,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: height(10),
        ),
        TextFormField(
          maxLength: null,
          maxLines: isPassword ? 1 : null,
          controller: controller,
          keyboardType: type,
          obscureText: isPassword,
          enabled: isClickable,
          onFieldSubmitted: onSubmit,
          onChanged: onChange,
          onTap: onTap,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          textAlignVertical: TextAlignVertical.center,
          validator: validate ??
              (value) {
                if (value!.isEmpty) {
                  return "";
                }
                return null;
              },
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            fillColor: color.colorScheme.secondary,
            filled: true,
            errorStyle: const TextStyle(
              height: 0,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            counterText: "",
            focusColor: Colors.transparent,
            suffixIcon: suffix != null
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width(30),
                    ),
                    child: suffix,
                  )
                : null,
            suffixIconConstraints: const BoxConstraints(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: width(20),
              vertical: height(20),
            ),
            hintStyle: TextStyle(
              fontSize: width(14),
              color: color.colorScheme.primaryContainer,
            ),
            labelStyle: TextStyle(
              fontSize: width(16),
              color: color.colorScheme.primaryContainer,
            ),
            alignLabelWithHint: false,
            floatingLabelStyle: TextStyle(
              color: color.primaryColor,
              fontSize: width(18),
            ),
            border: OutlineInputBorder(
              borderRadius: phone != null
                  ? const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    )
                  : BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: phone != null
                  ? const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    )
                  : BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: phone != null
                  ? const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    )
                  : BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: phone != null
                  ? const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    )
                  : BorderRadius.circular(5),
              borderSide: BorderSide(
                color: color.primaryColor,
              ),
            ),
          ),
          style: TextStyle(
            color: color.primaryColorDark,
            fontSize: width(12),
          ),
        ),
      ],
    );
  }
}
