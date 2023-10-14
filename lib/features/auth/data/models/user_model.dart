class UserModel {
  String? name;
  String? email;
  String? password;
  String phone;
  String? gender;
  String? adress;
  String? imageUrl;
  String? oTp;
  String? city;
  String? fullName;
  UserModel(
      {this.name,
      this.fullName,
      this.city,
      this.oTp,
      this.email,
      this.password,
      required this.phone,
      this.gender,
      this.adress,
      this.imageUrl});
}
