import 'package:football_app/modules/fixtures/controllers/fixtures_controller.dart';
import 'package:football_app/modules/fixtures/repositories/fixtures_repository.dart';
import 'package:football_app/modules/home/controllers/home_controller.dart';
import 'package:football_app/shared/controllers/top_assists_controller.dart';
import 'package:football_app/shared/controllers/top_scorers_controller.dart';
import 'package:get/get.dart';
import 'package:football_app/shared/data/repositories/player_stats_repository.dart';
import 'package:football_app/core/services/api_client.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    //Repository
    Get.lazyPut(() => PlayerStatsRepository(Get.find<ApiClient>()));
    Get.lazyPut(() => FixturesRepository(Get.find<ApiClient>()));

    // Controller
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => TopScorersController(Get.find<PlayerStatsRepository>()));
    Get.lazyPut(() => TopAssistsController(Get.find<PlayerStatsRepository>()));
    Get.lazyPut(() => FixturesController(Get.find<FixturesRepository>()));
  }
}
