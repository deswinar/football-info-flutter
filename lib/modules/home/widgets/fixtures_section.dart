import 'package:flutter/material.dart';
import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/modules/fixtures/controllers/fixtures_controller.dart';
import 'package:football_app/modules/fixtures/models/fixture_response.dart';
import 'package:football_app/modules/fixtures/widgets/fixtures_card.dart';
import 'package:football_app/modules/home/controllers/home_controller.dart';
import 'package:football_app/shared/widgets/view_state_error_widget.dart';
import 'package:get/get.dart';

class FixturesSection extends StatelessWidget {
   const FixturesSection({
    super.key,
    required this.fixturesController,
  });

  final FixturesController fixturesController;

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    final leagueId = homeController.leagueId.value;
    final season = homeController.seasonYear.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fixture list
        Obx(() {
          final state = fixturesController.fixturesState;

          if (state is ViewStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ViewStateError) {
            return ViewStateErrorWidget(
              message: state.message,
              onRetry: () => fixturesController.fetchFixturesByLeagueAndSeason(leagueId: leagueId, season: season),
            );
          } else if (state is ViewStateSuccess<List<FixtureEntry>>) {
            final fixtures = state.data.take(5).toList(); // Limit to 5 items
            if (fixtures.isEmpty) {
              return const Center(child: Text('No fixtures today.'));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(0),
              itemCount: fixtures.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final entry = fixtures[index];
                final fixture = entry.fixture;
                final league = entry.league;
                final venue = fixture.venue;
                final status = fixture.status;
                final homeTeam = entry.teams.home;
                final awayTeam = entry.teams.away;
            
                return FixturesCard(league: league, status: status, fixture: fixture, homeTeam: homeTeam, awayTeam: awayTeam, venue: venue);
              },
            );
          }

          return const SizedBox(); // ViewStateInitial or unknown
        }),
      ],
    );
  }
}
