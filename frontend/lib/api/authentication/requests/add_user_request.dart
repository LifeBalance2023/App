class AddUserRequest {
  String email;
  String userId;

  AddUserRequest({required this.email, required this.userId});

  Map<String, dynamic> toJson() => {
        'email': email,
        'id': userId,
      };
}
