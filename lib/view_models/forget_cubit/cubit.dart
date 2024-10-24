import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storesight/infrastructure/exceptions.dart';
import 'package:storesight/models/reset_model.dart';
import 'package:storesight/services/auth_service.dart';
import 'package:storesight/view_models/forget_cubit/states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit() : super(ForgetPasswordStates());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  final AuthService _authService = AuthService();
  var formKey = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  ResetRequest resetRequest = ResetRequest.instance();
  ResetByEmail resetByEmail = ResetByEmail.instance();

  onChangeEmail({required String value}) {
    resetByEmail.email = value;
    emit(OnChangeStates());
  }

  onChangeCode({required String value}) {
    resetRequest.code = value;
    emit(OnChangeStates());
  }

  onChangePassword({required String value}) {
    resetRequest.newPassword = value;
    emit(OnChangeStates());
  }

  forgetPassword() {
    emit(ResendPasswordLoading());
    _authService.resetByEmail(email: resetByEmail).then((value) {
      emit(ResendPasswordSuccess());
    }).catchError((error) {
      if (error is ApiException) {
        emit(ResendPasswordError(error: error.errorMessage.toString()));
      }
    });
  }

  confirmPassword() {
    emit(ConfirmPasswordLoading());
    _authService.resetPassword(resetRequest: resetRequest).then((value) {
      emit(ConfirmPasswordSuccess());
    }).catchError((error) {
      if (error is ApiException) {
        emit(ConfirmPasswordError(error: error.errorMessage.toString()));
      }
    });
  }
}
