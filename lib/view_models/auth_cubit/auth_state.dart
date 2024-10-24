class AuthStates {}

class OnChangeState extends AuthStates {}

class CreateUserLoading extends AuthStates {}

class CreateUserSuccess extends AuthStates {}

class CreateUserError extends AuthStates {
  String? error;
  CreateUserError({this.error});
}

class LoginUserLoading extends AuthStates {}

class LoginUserSuccess extends AuthStates {}

class LoginUserError extends AuthStates {
  String? error;
  LoginUserError({this.error});
}
