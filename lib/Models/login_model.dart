class LoginModel {
  bool ?status;
  String ?message;
  UserData? data;

  LoginModel(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData.fromJson(data) {
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
