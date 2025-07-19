import 'package:football_app/modules/home/controllers/home_controller.dart';
import 'package:football_app/modules/teams/controllers/teams_controller.dart';
import 'package:football_app/modules/teams/repositories/teams_repository.dart';
import 'package:get/get.dart';
import 'package:football_app/core/services/api_client.dart';

class TeamsBinding extends Bindings {
  @override
  void dependencies() {
    //Repository
    Get.lazyPut(() => TeamsRepository(Get.find<ApiClient>()));

    // Controller
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => TeamsController(Get.find<TeamsRepository>()));
  }
}
