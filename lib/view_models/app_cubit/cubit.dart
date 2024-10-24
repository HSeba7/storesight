import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storesight/infrastructure/exceptions.dart';
import 'package:storesight/infrastructure/local_storage.dart';
import 'package:storesight/infrastructure/utils.dart';
import 'package:storesight/models/reset_model.dart';
import 'package:storesight/models/user_model.dart';
import 'package:storesight/services/auth_service.dart';
import 'package:storesight/services/file_service.dart';
import 'package:storesight/view_models/app_cubit/states.dart';
import 'package:storesight/views/auth_views/login_view.dart';
import 'package:storesight/views/auth_views/tutorial_view.dart';
import 'package:storesight/views/client_views/layout_view.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppStates());

  static AppCubit get(context) => BlocProvider.of(context);
  final AuthService _authService = AuthService();
  final FileService _fileService = FileService();
  final ChangePassword changePassword = ChangePassword.instance();
  var formKey = GlobalKey<FormState>();
  UserAccount? userAccount;
  File? profilePic;
  bool isChangePass = false;
  bool isBoarding = false;

  chooseProfilePic({required File value}) {
    profilePic = value;
    updateProfilePic(value: value);
    emit(OnChangeAppState());
  }

  togglePassword() {
    isChangePass = !isChangePass;
    emit(OnChangeAppState());
  }

  changeOldPassword({required String value}) {
    changePassword.oldPassword = value;
    emit(OnChangeAppState());
  }

  changeNewPasswword({required String value}) {
    changePassword.newPassword = value;
    emit(OnChangeAppState());
  }

  changeConfirmPasswword({required String value}) {
    changePassword.confirmPassword = value;
    emit(OnChangeAppState());
  }

  changeName({required String value}) {
    userAccount!.fullname = value;
    emit(OnChangeAppState());
  }

  changePhone({required String value}) {
    userAccount!.phoneNumber = value;
    emit(OnChangeAppState());
  }

  changeEmail({required String value}) {
    userAccount!.email = value;
    emit(OnChangeAppState());
  }

  updateUser() {
    emit(UpdateUserDataLoadingState());
    _authService.updateUser(updateUser: userAccount!).then((value) {
      emit(UpdateUserDataSuccessState());
    }).catchError((error) {
      printLn(error.toString());
      if (error is ApiException) {
        emit(UpdateUserDataErrorState(error.errorMessage.toString()));
      }
    });
  }

  updatePassword() {
    emit(UpdateUserDataLoadingState());
    _authService.changePassword(changeRequest: changePassword).then((value) {
      emit(UpdateUserDataSuccessState());
    }).catchError((error) {
      printLn(error.toString());
      if (error is ApiException) {
        emit(UpdateUserDataErrorState(error.errorMessage.toString()));
      }
    });
  }

  updateProfilePic({required File value}) {
    _fileService.uploadImage(image: value).then((value) {
      printLn("Done Uploading");
      emit(OnChangeAppState());
    }).catchError((error) {
      printLn(error.toString());
    });
  }

  Future<void> getUser() async {
    emit(GetUserDataLoadingState());
    _authService.getUser().then((value) async {
      userAccount = value;
      isBoarding = await LocalStorage().getBool(LocalStorageKeys.boardingKey);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState());
    });
  }

  logout() {
    emit(GetUserDataLoadingState());
    _authService.logout().then((value) {
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      printLn(error.toString());
      emit(GetUserDataErrorState());
    });
  }

  Widget? currentView() {
    Widget? view;
    if (userAccount == null && isBoarding) {
      view = const LoginView();
    } else if (userAccount == null && isBoarding == false) {
      view = const TutorialView();
    } else if (userAccount != null) {
      view = const LayoutView();
    }
    return view;
  }
}
