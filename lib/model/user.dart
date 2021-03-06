
class UserModel {
  int? id;
  String? token;
  String? name;
  String? lastName;
  String? email;
  String? phone;
  int? userRole;
  bool? inHotel;

  UserModel({this.id, this.token, this.name, this.lastName, this.email, this.phone, this.userRole, this.inHotel});

  factory UserModel.fromJSON(Map<String, dynamic> jsonMap) => UserModel(
    id: jsonMap['id'],
    token: jsonMap['token'] ?? null,
    name: jsonMap['first_name'] ?? null,
    lastName: jsonMap['second_name'] ?? null,
    email: jsonMap['email'] ?? null,
    phone: jsonMap['phone'] ?? null,
    userRole: jsonMap['users_role_id'] ?? null,
  );

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'first_name': name,
      'second_name': lastName,
      'email': email,
      'phone': phone,
      'inHotel': inHotel,
      'users_role_id': userRole,
    };
  }
}