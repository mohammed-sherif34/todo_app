class MyUser {
  static const String collection='Users';
   String id;
   String name;
   String email;

  MyUser({
    required this.id,
    required this.name,
    required this.email,
  });

  MyUser.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          email: json['email'] as String,
          name: json['name'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
