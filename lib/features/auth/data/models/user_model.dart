
class UserModel {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String nationalId;
  final String engineeringNumber;
  final String password;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.nationalId,
    required this.engineeringNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "nationalId": nationalId,
      "engineeringNumber": engineeringNumber,
      "password": password,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      nationalId: json['nationalId'] ?? '',
      engineeringNumber: json['engineeringNumber'] ?? '',
      password: json['password'] ?? '',
    );
  }
}