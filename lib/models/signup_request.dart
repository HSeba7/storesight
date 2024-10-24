import 'package:storesight/infrastructure/request.dart';

class SignUpRequest extends Serialized {
  String? email;
  String? password;
  String? confirmPassword;
  String? name;

  SignUpRequest.instance();

  SignUpRequest({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.name,
  });

  @override
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
      };
}
