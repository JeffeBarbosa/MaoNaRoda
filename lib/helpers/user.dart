class User {
  int _id;
  final String _name;
  final String _email;
  final String _senha;

  User(
    this._id,
    this._name,
    this._email,
    this._senha,
  );

  set id(int id) => _id = id;

  int get id => _id;
  String get name => _name;
  String get email => _email;
  String get senha => _senha;

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'email': _email,
      'senha': _senha,
    };
  }

  factory User.fromMap(Map<String, dynamic> json) {
    return User(json['id'], json['name'], json['email'], json['senha']);
  }
  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['id'], json['name'], json['email'], json['senha']);
  }
}
