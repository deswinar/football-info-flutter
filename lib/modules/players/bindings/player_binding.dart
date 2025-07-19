import 'package:football_app/modules/home/controllers/home_controller.dart';
import 'package:football_app/modules/players/controllers/player_controller.dart';
import 'package:football_app/modules/players/repositories/player_repository.dart';
import 'package:get/get.dart';
import 'package:football_app/core/services/api_client.dart';

class PlayerBinding extends Bindings {
  @override
  void dependencies() {
    //Repository
    Get.lazyPut(() => PlayerRepository(Get.find<ApiClient>()));

    // Controller
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => PlayerController(Get.find<PlayerRepository>()));
  }
}
