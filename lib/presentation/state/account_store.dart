import 'package:erta7o/data/models/user_profile_model.dart';
import 'package:erta7o/data/repository/account_repo.dart';
import 'package:erta7o/presentation/state/auth_store.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class AccountStore {
  final AccountRepo accountRepo;
  AccountStore(this.accountRepo);

  UserProfileModel userProfile;

  Future editPassword(String password) async {
    return await accountRepo.editPass(password);
  }
  Future editProfile(String image, String phone) async {
    return await accountRepo.editUserImage(image, phone);
  }
  Future editNotify(shouldNotify) async {
    return await accountRepo.editNotify(shouldNotify);
  }
  Future getProfile()async{
    final userID = IN.get<AuthStore>().credentialsModel.data.id;
    userProfile = UserProfileModel.fromJson(await accountRepo.uesrProfile(userID));
    return userProfile;
  }
}