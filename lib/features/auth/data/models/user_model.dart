import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? email;
  @HiveField(2)
  String? password;
  @HiveField(3)
  String phone;
  @HiveField(4)
  String? gender;
  @HiveField(5)
  String? adress;
  @HiveField(6)
  String? imageUrl;
  @HiveField(7)
  String? oTp;
  @HiveField(8)
  String? city;
  @HiveField(9)
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
