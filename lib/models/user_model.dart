import 'package:storesight/infrastructure/request.dart';

class UserAccount extends Serialized {
  bool? isAdmin;
  String? email;
  String? fullname;
  String? phoneNumber;
  String? profilePic;

  UserAccount({
    this.isAdmin,
    this.email,
    this.fullname,
    this.phoneNumber,
    this.profilePic,
  });

  UserAccount.instance();

  factory UserAccount.fromJson(Map<String, dynamic> json) => UserAccount(
        email: json['email'],
        isAdmin: json['isAdmin'],
        fullname: json['first_name'],
        profilePic: json['image'],
        phoneNumber: json['phone'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'email': email,
        'first_name': fullname,
        'image': profilePic,
        'phone': phoneNumber,
      };
}
