class ProfileModel {
  Data data;

  ProfileModel({this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String name;
  String fathername;
  String dob;
  String age;
  String gender;
  String phno;
  String email;
  String nrcdivisionid;
  String nrccityid;
  String nrcno;
  String divisionid;
  String cityid;
  String quarterid;
  String username;
  String password;
  String nrcDivisionCode;
  String divisionname;
  String nrcCityCode;
  String cityname;
  String quartername;
  String image;

  Data(
      {this.name,
      this.fathername,
      this.dob,
      this.age,
      this.gender,
      this.phno,
      this.email,
      this.nrcdivisionid,
      this.nrccityid,
      this.nrcno,
      this.divisionid,
      this.cityid,
      this.quarterid,
      this.username,
      this.password,
      this.nrcDivisionCode,
      this.divisionname,
      this.nrcCityCode,
      this.cityname,
      this.quartername,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fathername = json['fathername'];
    dob = json['dob'];
    age = json['age'];
    gender = json['gender'];
    phno = json['phno'];
    email = json['email'];
    nrcdivisionid = json['nrcdivisionid'];
    nrccityid = json['nrccityid'];
    nrcno = json['nrcno'];
    divisionid = json['divisionid'];
    cityid = json['cityid'];
    quarterid = json['quarterid'];
    username = json['username'];
    password = json['password'];
    nrcDivisionCode = json['nrc_division_code'];
    divisionname = json['divisionname'];
    nrcCityCode = json['nrc_city_code'];
    cityname = json['cityname'];
    quartername = json['quartername'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['fathername'] = this.fathername;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['phno'] = this.phno;
    data['email'] = this.email;
    data['nrcdivisionid'] = this.nrcdivisionid;
    data['nrccityid'] = this.nrccityid;
    data['nrcno'] = this.nrcno;
    data['divisionid'] = this.divisionid;
    data['cityid'] = this.cityid;
    data['quarterid'] = this.quarterid;
    data['username'] = this.username;
    data['password'] = this.password;
    data['nrc_division_code'] = this.nrcDivisionCode;
    data['divisionname'] = this.divisionname;
    data['nrc_city_code'] = this.nrcCityCode;
    data['cityname'] = this.cityname;
    data['quartername'] = this.quartername;
    data['image'] = this.image;
    return data;
  }
}
