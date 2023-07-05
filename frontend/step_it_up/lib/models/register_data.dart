class RegisterData {
  final String email;
  final String password;
  final String name;

  RegisterData({required this.email, required this.password, required this.name});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name
    };
  }
}