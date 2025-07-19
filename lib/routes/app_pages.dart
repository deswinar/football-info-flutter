import 'package:football_app/modules/fixtures/bindings/fixtures_binding.dart';
import 'package:football_app/modules/fixtures/views/fixtures_screen.dart';
import 'package:football_app/modules/home/bindings/home_binding.dart';
import 'package:football_app/modules/home/views/home_screen.dart';
import 'package:football_app/modules/league_picker/bindings/league_season_picker_binding.dart';
import 'package:football_app/modules/league_picker/views/league_season_picker_screen.dart';
import 'package:football_app/modules/player_profile/bindings/player_profile_binding.dart';
import 'package:football_app/modules/player_profile/views/player_profile_screen.dart';
import 'package:football_app/modules/player_squad/bindings/player_squad_binding.dart';
import 'package:football_app/modules/player_squad/views/player_squad_screen.dart';
import 'package:football_app/modules/players/bindings/player_binding.dart';
import 'package:football_app/modules/players/views/all_player_screen.dart';
import 'package:football_app/modules/teams/bindings/team_binding.dart';
import 'package:football_app/modules/teams/views/teams_screen.dart';
import 'package:football_app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.fixtures,
      page: () => FixturesScreen(),
      binding: FixturesBinding(),
    ),
    GetPage(
      name: AppRoutes.leagueSeasonPicker,
      page: () => LeagueSeasonPickerScreen(),
      binding: LeagueSeasonPickerBinding(),
    ),
    GetPage(
      name: AppRoutes.teams,
      page: () => TeamsScreen(),
      binding: TeamsBinding(),
    ),
    // Player Squad
    GetPage(
      name: AppRoutes.playerSquad,
      page: () => const PlayerSquadScreen(),
      binding: PlayerSquadBinding(),
    ),
    GetPage(
      name: AppRoutes.playerProfile,
      page: () => const PlayerProfileScreen(),
      binding: PlayerProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.playerList,
      page: () => const AllPlayersScreen(),
      binding: PlayerBinding(),
    )
  ];
}
