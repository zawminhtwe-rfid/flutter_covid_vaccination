class login {
  bool status;
  String id;
  String psw;
  String name;

  String message;

  login({this.status, this.id, this.message, this.psw, this.name});

  login.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    psw = json['psw'];
    name = json['name'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['message'] = this.message;
    data['psw'] = this.psw;
    data['name'] = this.name;
    return data;
  }
}
