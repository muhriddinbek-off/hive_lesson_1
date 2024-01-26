import 'package:hive/hive.dart';
import 'package:hive_database/model/user.dart';

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final name = reader.read() as String;
    final phoneNumber = reader.read() as int;
    return User(name: name, phoneNumber: phoneNumber);
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.write(obj.name);
    writer.write(obj.phoneNumber);
  }
}
