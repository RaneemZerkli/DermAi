
class User {

  final String email;
  final String token;

  User({

    required this.email,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      token: json['token'],
    );
  }
}

class SignupRequest {
  final String first_name;
  final String last_name;
  final String email;
  final String password;

  SignupRequest({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password': password,
    };
  }
}

class SignupResponse {
  final String token;
  final String message;
  final String status;

  SignupResponse({
    required this.token,
    required this.message,
    required this.status,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      token: json['token'],
      message: json['message'],
      status: json['status'],
    );
  }
}
