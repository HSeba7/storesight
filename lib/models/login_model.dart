import 'package:storesight/infrastructure/request.dart';

class LoginRequest extends Serialized {
  String? email;
  String? password;

  LoginRequest.instance();

  LoginRequest({
    this.email,
    this.password,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }
}

class LoginResponse {
  final String message;
  final String csrfToken;
  final String sessionId;

  LoginResponse({
    required this.message,
    required this.csrfToken,
    required this.sessionId,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message: json['message'] as String,
        csrfToken: json['csrf_token'] as String,
        sessionId: json['sessionid'] as String,
      );
}
