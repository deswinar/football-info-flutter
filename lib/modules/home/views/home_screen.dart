import 'package:flutter/material.dart';
import 'package:football_app/modules/fixtures/controllers/fixtures_controller.dart';
import 'package:football_app/modules/home/controllers/home_controller.dart';
import 'package:football_app/modules/home/widgets/fixtures_section.dart';
import 'package:football_app/modules/home/widgets/grid_menu.dart';
import 'package:football_app/modules/home/widgets/league_season_info_picker.dart';
import 'package:football_app/shared/controllers/top_assists_controller.dart';
import 'package:football_app/shared/widgets/top_assists_list.dart';
import 'package:football_app/shared/controllers/top_scorers_controller.dart';
import 'package:football_app/shared/widgets/top_scorers_list.dart';
import 'package:football_app/routes/app_routes.dart';
import 'package:football_app/shared/controllers/theme_controller.dart';
import 'package:football_app/shared/widgets/section_header.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.find<HomeController>();
  final topScorersController = Get.find<TopScorersController>();
  final topAssistsController = Get.find<TopAssistsController>();
  final fixturesController = Get.find<FixturesController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football Info'),
        centerTitle: true,
        actions: [
          // Theme Swithcer
          Obx(() => IconButton(
            icon: Icon(
              themeController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: themeController.toggleTheme,
          )),

        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            topScorersController.refreshTopScorers(
              leagueId: homeController.leagueId.value,
              season: homeController.seasonYear.value,
            ),
            topAssistsController.refreshTopAssists(
              leagueId: homeController.leagueId.value,
              season: homeController.seasonYear.value,
            ),
            fixturesController.fetchFixturesByLeagueAndSeason(
              leagueId: homeController.leagueId.value,
              season: homeController.seasonYear.value,
            ),
          ]);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // League & Season Info Picker
              LeagueSeasonInfoPicker(
                homeController: homeController, 
                topScorersController: topScorersController, 
                topAssistsController: topAssistsController,
                fixturesController: fixturesController,
              ),
              const SizedBox(height: 16),

              // Grid Menu
              const GridMenu(),

              const SizedBox(height: 16),
              SectionHeader(title: 'Top Scorers', icon: Icons.sports_soccer),
              const SizedBox(height: 8),
              TopScorersList(topScorersController: topScorersController),

              const SizedBox(height: 24),
              SectionHeader(title: 'Top Assists', icon: Icons.group),
              const SizedBox(height: 8),
              TopAssistsList(topAssistsController: topAssistsController),

              const SizedBox(height: 24),
              SectionHeader(
                title: 'Fixtures', 
                icon: Icons.event, 
                trailing: TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.fixtures),
                  child: const Text('See All'),
                ),
              ),
              const SizedBox(height: 8),
              FixturesSection(fixturesController: fixturesController,),
            ],
          ),
        ),
      ),
    );
  }
}
