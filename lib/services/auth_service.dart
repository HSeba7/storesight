import 'package:storesight/infrastructure/http_service.dart';
import 'package:storesight/infrastructure/local_storage.dart';
import 'package:storesight/infrastructure/utils.dart';
import 'package:storesight/models/login_model.dart';
import 'package:storesight/models/reset_model.dart';
import 'package:storesight/models/signup_request.dart';
import 'package:storesight/models/user_model.dart';

class AuthService {
  final HttpService _httpService = HttpService();

  Future<void> register({required SignUpRequest model}) async {
    await _httpService.doPost(
      url: "/api/signup/",
      pawsRequest: model,
    );
  }

  Future<void> login({required LoginRequest model}) async {
    var httpResponse = await _httpService.doPost(
      url: "/api/login/",
      pawsRequest: model,
    );
    LoginResponse response = LoginResponse.fromJson(httpResponse);
    await LocalStorage()
        .setString(key: LocalStorageKeys.authKey, value: response.csrfToken);
    await LocalStorage()
        .setString(key: LocalStorageKeys.sessionKey, value: response.sessionId);
  }

  Future<void> resetByEmail({required ResetByEmail email}) async {
    printLn(email.email);
    await _httpService.doPost(
      url: "/api/forgot-password/",
      pawsRequest: email,
    );
  }

  Future<void> logout() async {
    await _httpService.doPost(
      url: "/api/logout/",
    );
    await LocalStorage().remove(LocalStorageKeys.authKey);
    await LocalStorage().remove(LocalStorageKeys.sessionKey);
    await LocalStorage().remove(LocalStorageKeys.boardingKey);
  }

  Future<void> updateUser({required UserAccount updateUser}) async {
    await _httpService.doPost(
      url: "/api/update-profile/",
      pawsRequest: updateUser,
    );
  }

  Future<UserAccount> getUser() async {
    var userData = await _httpService.doGet("/api/get-user-info/");
    return UserAccount.fromJson(userData);
  }

  Future<void> resetPassword({required ResetRequest resetRequest}) async {
    await _httpService.doPost(
      url: "/api/reset-password/",
      pawsRequest: resetRequest,
    );
  }

  Future<void> changePassword({required ChangePassword changeRequest}) async {
    await _httpService.doPost(
      url: "/api/change-password/",
      pawsRequest: changeRequest,
    );
  }
}
