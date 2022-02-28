import 'package:tiki/models/user.dart';

abstract class BaseUsersRepo {
  Stream<List<User>> getUsers();
}
