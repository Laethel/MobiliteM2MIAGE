class User {

  String id;
  String name;
  String firstName;
  String mail;

  User({this.id, this.name, this.firstName, this.mail});

  User.fromMap(Map snapshot, String id) :
        id = id ?? '',
        name = snapshot['name'] ?? '',
        firstName = snapshot['firstName'] ?? '',
        mail = snapshot['mail'] ?? '';

  toJson() {

    return {
      "name": name,
      "firstName": firstName,
      "mail": mail
    };
  }
}