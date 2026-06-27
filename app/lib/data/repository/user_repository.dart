import 'package:app/data/model/user_model.dart';
import 'package:app/data/provider/user_provider.dart';


// contract for repository implementation
abstract class IUserRepository {
  Future<UserModel> getUsers();
}


// repository implementation
class UserRepository implements IUserRepository {

  final UserProvider userProvider;

  UserRepository(this.userProvider);

  @override
  Future<UserModel> getUsers() {
    return userProvider.getUsers();
  }
}

