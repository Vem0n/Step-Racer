class Friend {
  late final String name;
  late final String email;
  late final String status;
  late final String? profilePicture;

  Friend(
      {required this.name,
      required this.email,
      required this.status,
      this.profilePicture});
}
