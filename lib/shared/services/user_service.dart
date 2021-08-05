import 'package:haiya_client/shared/models/user_detail.dart';
import 'package:haiya_client/shared/services/constant_service.dart';

class UserService {
  Future<UserDetail> getCurrentUser() async {
    return ConstantService.dummyCurrentUser();
  }

  Future<void> updateProfileImage(String filePath) async {
    print("Update profile image: " + filePath);
  }
}
