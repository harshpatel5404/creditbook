import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final name;

  @HiveField(1)
   final email;

  @HiveField(2)
  final phone;

  @HiveField(3)
   final password;

  const UserModel({this.name, this.email, this.phone, this.password});
}
