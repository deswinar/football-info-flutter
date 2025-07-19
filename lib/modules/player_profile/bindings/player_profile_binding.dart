import 'package:football_app/modules/home/controllers/home_controller.dart';
import 'package:football_app/modules/player_profile/controllers/player_profile_controller.dart';
import 'package:football_app/modules/player_profile/repositories/player_profile_repository.dart';
import 'package:get/get.dart';
import 'package:football_app/core/services/api_client.dart';

class PlayerProfileBinding extends Bindings {
  @override
  void dependencies() {
    //Repository
    Get.lazyPut(() => PlayerProfileRepository(Get.find<ApiClient>()));

    // Controller
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => PlayerProfileController(Get.find<PlayerProfileRepository>()));
  }
}
