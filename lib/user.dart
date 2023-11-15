class UserModel {
  String? country;
  String? prefecture;
  String? municipality;
  String? apartment;
  String? streetAddress;

  UserModel({
    this.country,
    this.prefecture,
    this.municipality,
    this.apartment,
    this.streetAddress,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      country: json['country'],
      prefecture: json['prefecture'],
      municipality: json['municipality'],
      apartment: json['apartment'],
      streetAddress: json['streetAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'prefecture': prefecture,
      'municipality': municipality,
      'apartment': apartment,
      'streetAddress': streetAddress,
    };
  }
}
