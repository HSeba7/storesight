class AppStates {}

class OnChangeAppState extends AppStates {}

class GetUserDataLoadingState extends AppStates {}

class GetUserDataSuccessState extends AppStates {}

class GetUserDataErrorState extends AppStates {}

class UpdateUserDataLoadingState extends AppStates {}

class UpdateUserDataSuccessState extends AppStates {}

class UpdateUserDataErrorState extends AppStates {
  final String error;
  UpdateUserDataErrorState(this.error);
}
