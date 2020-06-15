class User {
  String id;
  String email;
  String password;
  String role;
  String avatar;
  String phoneNumber;
  double latitude;
  double longitude;
  String country;
  String city;
  String address;
  String zipCode;
  bool activated;
  String token;

  User({
    this.id,
    this.email,
    this.password,
    this.role,
    this.avatar,
    this.phoneNumber,
    this.latitude,
    this.longitude,
    this.country,
    this.city,
    this.address,
    this.zipCode,
    this.activated,
    this.token,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['user']['_id'];
    email = json['user']['email'];
    password = json['user']['password'];
    phoneNumber = json['user']['phoneNumber'];
    role = json['user']['role'];
    avatar = json['user']['avatar'];
    latitude = json['user']['latitude'];
    longitude = json['user']['longitude'];
    country = json['user']['country'];
    city = json['user']['city'];
    address = json['user']['address'];
    zipCode = json['user']['zipCode'];
    activated = json['user']['activated'];
    token = json['user']['token'];
  }

  User.ownerfromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    role = json['role'];
    avatar = json['avatar'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    country = json['country'];
    city = json['city'];
    address = json['address'];
    zipCode = json['zipCode'];
    activated = json['activated'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user']['_id'] = this.id;
    data['user']['email'] = this.email;
    data['user']['phoneNumber'] = this.phoneNumber;
    data['user']['password'] = this.password;
    data['user']['role'] = this.role;
    data['user']['avatar'] = this.avatar;
    data['user']['latitude'] = this.latitude;
    data['user']['longitude'] = this.longitude;
    data['user']['country'] = this.country;
    data['user']['city'] = this.city;
    data['user']['zipCode'] = this.zipCode;
    data['user']['address'] = this.address;
    data['user']['activated'] = this.activated;
    data['user']['token'] = this.token;
    return data;
  }
}
