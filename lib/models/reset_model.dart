import 'package:storesight/infrastructure/request.dart';

class ResetByEmail extends Serialized {
  String? email;

  ResetByEmail.instance();

  ResetByEmail({
    this.email,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
    };
  }
}

class ResetRequest extends Serialized {
  String? newPassword;
  String? code;

  ResetRequest.instance();

  ResetRequest({
    required this.newPassword,
    required this.code,
  });

  @override
  Map<String, dynamic> toJson() => {
        'password': newPassword,
        'code': code,
      };
}

class ChangePassword extends Serialized {
  String? newPassword;
  String? confirmPassword;
  String? oldPassword;

  ChangePassword.instance();

  ChangePassword({
    required this.newPassword,
    required this.oldPassword,
    required this.confirmPassword,
  });

  @override
  Map<String, dynamic> toJson() => {
        'old_password': oldPassword,
        'new_password': newPassword,
      };
}
