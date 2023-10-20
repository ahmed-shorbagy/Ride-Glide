class DriverModel {
  String? name;
  String? email;
  String? password;

  String? gender;
  String? adress;
  String? imageUrl;
  String? oTp;
  String? city;
  String? fullName;
  String? carType;
  String? carColor;
  bool? status;
  String? uID;
  DriverModel(
      {this.name,
      this.status,
      this.fullName,
      this.city,
      this.carColor,
      this.carType,
      this.oTp,
      this.email,
      this.password,
      this.gender,
      this.adress,
      this.imageUrl,
      this.uID});

  factory DriverModel.fromFireStore(Map<String, dynamic> driver) {
    return DriverModel(
        adress: driver['address'],
        carColor: driver['carColor'],
        carType: driver['carType'],
        email: driver['email'],
        gender: driver['gender'],
        name: driver['name'],
        status: driver['status'],
        imageUrl: driver['imageUrl'],
        uID: driver['UId']);
  }
}
