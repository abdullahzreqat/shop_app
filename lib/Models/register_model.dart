class RegisterModel {
  bool ?status;
  String ?message;
  UserRegisterData? data;

  RegisterModel(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserRegisterData.fromJson(json['data']) : null;
  }
}

class UserRegisterData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserRegisterData.fromJson(data) {
    id = data["id"];
    name = data["name"];
    email = data["email"];
    phone = data["phone"];
    image = data["image"];
    points = data["points"];
    credit = data["credit"];
    token = data["token"];
  }
}
