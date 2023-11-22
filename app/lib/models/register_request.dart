class RegisterRequest {
  String name;
  String email;
  String password;

  RegisterRequest(
      {required this.name, required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }
}
