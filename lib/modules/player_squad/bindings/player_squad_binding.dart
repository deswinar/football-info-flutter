import 'package:football_app/modules/home/controllers/home_controller.dart';
import 'package:football_app/modules/player_squad/controllers/player_squad_controller.dart';
import 'package:football_app/modules/player_squad/repositories/player_squad_repository.dart';
import 'package:get/get.dart';
import 'package:football_app/core/services/api_client.dart';

class PlayerSquadBinding extends Bindings {
  @override
  void dependencies() {
    //Repository
    Get.lazyPut(() => PlayerSquadRepository(Get.find<ApiClient>()));

    // Controller
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => PlayerSquadController(Get.find<PlayerSquadRepository>()));
  }
}
