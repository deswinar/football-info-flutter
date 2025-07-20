import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/modules/home/controllers/home_controller.dart';
import 'package:football_app/modules/teams/controllers/teams_controller.dart';
import 'package:football_app/routes/app_routes.dart';
import 'package:football_app/shared/widgets/view_state_error_widget.dart';
import 'package:get/get.dart';

class TeamsScreen extends StatelessWidget {
  TeamsScreen({super.key});

  final TeamsController controller = Get.find<TeamsController>();

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    final leagueId = homeController.leagueId.value;
    final season = homeController.seasonYear.value;

    // Fetch only once when screen is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchTeams(leagueId: leagueId, season: season);
    });
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teams'),
        centerTitle: true,
      ),
      body: Obx(() {
        final state = controller.teamsState;

        if (state is ViewStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ViewStateError) {
          return Center(
            child: ViewStateErrorWidget(
              message: state.message,
              onRetry: () => controller.fetchTeams(leagueId: leagueId, season: season),
            ),
          );
        }

        if (state is ViewStateSuccess<List>) {
          final teams = state.data;

          if (teams.isEmpty) {
            return const Center(child: Text('No teams found.'));
          }

          return ListView.builder(
            itemCount: teams.length,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemBuilder: (context, index) {
              final team = teams[index].team;
              final venue = teams[index].venue;

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CachedNetworkImage(imageUrl:team.logo, width: 40, height: 40),
                  title: Text(team.name),
                  subtitle: Text('${team.country} • ${venue.name}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.playerSquad,
                      arguments: {
                        'teamId': team.id,
                        'teamName': team.name,
                        'teamLogoUrl': team.logo,
                      },
                    );
                  },
                ),
              );
            },
          );
        }

        return const SizedBox(); // ViewStateInitial
      }),
    );
  }
}
