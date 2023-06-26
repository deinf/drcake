class GetUserData {
  String? sId;
  String? username;
  String? password;
  // String? createdAt;
  // String? updatedAt;
  // int? iV;

  GetUserData({
    this.sId,
    this.username,
    this.password,
    // this.createdAt,
    // this.updatedAt,
    // this.iV
  });

  GetUserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    password = json['password'];
    // createdAt = json['createdAt'];
    // updatedAt = json['updatedAt'];
    // iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    data['password'] = password;
    // data['createdAt'] = createdAt;
    // data['updatedAt'] = updatedAt;
    // data['__v'] = iV;
    return data;
  }
}
