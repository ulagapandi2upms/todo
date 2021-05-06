final String tableUsers = 'Users';

class UserFields {
  static final List<String> values = [id, name, emailId, password];

  static final String id = '_id';
  static final String name = 'name';
  static final String emailId = 'email_address';
  static final String password = 'password';
}

class User {
  final int? id;
  final String name;
  final String emailId;
  final String password;

  const User({
    this.id,
    required this.name,
    required this.emailId,
    required this.password,
  });

  User copy({
    int? id,
    String? name,
    String? emailId,
    String? password,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        emailId: emailId ?? this.emailId,
        password: password ?? this.password,
      );

  static User fromJson(Map<String, Object?> json) => User(
      id: json[UserFields.id] as int?,
      name: json[UserFields.name] as String,
      emailId: json[UserFields.emailId] as String,
      password: json[UserFields.password] as String);

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.emailId: emailId,
        UserFields.password: password,
      };
}
