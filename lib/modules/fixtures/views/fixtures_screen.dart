import 'package:flutter/material.dart';
import 'package:football_app/core/enums/fixture_sort_options.dart';
import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/modules/fixtures/controllers/fixtures_controller.dart';
import 'package:football_app/modules/fixtures/models/fixture_response.dart';
import 'package:football_app/modules/fixtures/widgets/fixtures_list.dart';
import 'package:football_app/modules/home/controllers/home_controller.dart';
import 'package:football_app/shared/widgets/view_state_error_widget.dart';
import 'package:get/get.dart';

class FixturesScreen extends StatelessWidget {
  const FixturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FixturesController>();
    final homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fixtures'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Obx(() {
              final league = homeController.leagueName.value;
              final season = homeController.seasonYear.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    league,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$season/${season + 1}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              );
            }),
          ),
          // Search + Sort
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Search Field
                Expanded(
                  flex: 3,
                  child: TextField(
                    onChanged: controller.setSearchQuery,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Sort Dropdown
                Expanded(
                  flex: 2,
                  child: Obx(() {
                    return DropdownButtonFormField<FixtureSortOption>(
                      value: controller.selectedSort.value,
                      onChanged: (option) {
                        if (option != null) {
                          controller.setSortOption(option);
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      items: const [
                        DropdownMenuItem(value: FixtureSortOption.dateAsc, child: Text('Date ↑')),
                        DropdownMenuItem(value: FixtureSortOption.dateDesc, child: Text('Date ↓')),
                        DropdownMenuItem(value: FixtureSortOption.homeTeam, child: Text('Home A-Z')),
                        DropdownMenuItem(value: FixtureSortOption.awayTeam, child: Text('Away A-Z')),
                        DropdownMenuItem(value: FixtureSortOption.venue, child: Text('Venue A-Z')),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),

          // Refresh + Fixture List
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await controller.fetchFixturesByLeagueAndSeason(
                  leagueId: homeController.leagueId.value,
                  season: homeController.seasonYear.value,
                );
              },
              child: Obx(() {
                final state = controller.fixturesState;

                if (state is ViewStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ViewStateError) {
                  return Center(
                    child: ViewStateErrorWidget(
                      message: state.message,
                      onRetry: () => controller.fetchFixturesByLeagueAndSeason(
                        leagueId: homeController.leagueId.value,
                        season: homeController.seasonYear.value,
                      ),
                    ),
                  );
                } else if (state is ViewStateSuccess<List<FixtureEntry>>) {
                  final filtered = controller.filteredFixtures;
                  if (filtered.isEmpty) {
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Text('No fixtures match your search.'),
                          ),
                        ),
                      ],
                    );
                  }

                  return FixturesList(fixtures: filtered);
                }

                return const SizedBox();
              }),
            ),
          ),
        ],
      ),
    );
  }
}
