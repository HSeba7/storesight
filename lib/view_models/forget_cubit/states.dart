class ForgetPasswordStates {}

class OnChangeStates extends ForgetPasswordStates {}

class ResendPasswordLoading extends ForgetPasswordStates {}

class ResendPasswordSuccess extends ForgetPasswordStates {}

class ResendPasswordError extends ForgetPasswordStates {
  String? error;
  ResendPasswordError({this.error});
}

class ConfirmPasswordLoading extends ForgetPasswordStates {}

class ConfirmPasswordSuccess extends ForgetPasswordStates {}

class ConfirmPasswordError extends ForgetPasswordStates {
  String? error;
  ConfirmPasswordError({this.error});
}
