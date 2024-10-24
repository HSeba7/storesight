import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storesight/infrastructure/exceptions.dart';
import 'package:storesight/models/login_model.dart';
import 'package:storesight/models/signup_request.dart';
import 'package:storesight/services/auth_service.dart';
import 'package:storesight/view_models/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthStates());

  static AuthCubit get(context) => BlocProvider.of(context);
  final AuthService _authService = AuthService();
  SignUpRequest signUpRequest = SignUpRequest.instance();
  LoginRequest loginRequest = LoginRequest.instance();
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  bool isAccepted = false;
  bool isPassword = false;

  chooseName({required String value}) {
    signUpRequest.name = value;
    emit(OnChangeState());
  }

  chooseEmail({required String value}) {
    signUpRequest.email = value;
    emit(OnChangeState());
  }

  choosePassword({required String value}) {
    signUpRequest.password = value;
    emit(OnChangeState());
  }

  chooseConfirmPassword({required String value}) {
    signUpRequest.confirmPassword = value;
    emit(OnChangeState());
  }

  chooseLoginEmail({required String value}) {
    loginRequest.email = value;
    emit(OnChangeState());
  }

  chooseLoginPassword({required String value}) {
    loginRequest.password = value;
    emit(OnChangeState());
  }

  chooseAccepted({required bool value}) {
    isAccepted = value;
    emit(OnChangeState());
  }

  chooseIspassword() {
    isPassword = !isPassword;
    emit(OnChangeState());
  }

  creatUser() {
    emit(CreateUserLoading());
    _authService.register(model: signUpRequest).then((value) {
      emit(CreateUserSuccess());
    }).catchError((error) {
      if (error is ApiException) {
        emit(CreateUserError(error: error.errorMessage));
      }
    });
  }

  loginUser() {
    emit(LoginUserLoading());
    _authService.login(model: loginRequest).then((value) {
      emit(LoginUserSuccess());
    }).catchError((error) {
      if (error is ApiException) {
        emit(LoginUserError(error: error.errorMessage));
      }
    });
  }
}
