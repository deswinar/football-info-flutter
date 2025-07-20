import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/modules/player_squad/controllers/player_squad_controller.dart';
import 'package:football_app/modules/player_squad/models/player_entry.dart';
import 'package:football_app/routes/app_routes.dart';
import 'package:football_app/shared/widgets/view_state_error_widget.dart';
import 'package:get/get.dart';

class PlayerSquadScreen extends StatelessWidget {
  const PlayerSquadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlayerSquadController>();
    final args = Get.arguments as Map<String, dynamic>;

    final int teamId = args['teamId'];
    final String teamName = args['teamName'];
    final String teamLogoUrl = args['teamLogoUrl'];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CachedNetworkImage(imageUrl: teamLogoUrl, height: 24, width: 24),
            const SizedBox(width: 8),
            Text(teamName),
          ],
        ),
      ),
      body: Obx(() {
        final state = controller.squadState;

        if (state is ViewStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ViewStateError) {
          return Center(
            child: ViewStateErrorWidget(
              message: state.message,
              onRetry: () => controller.fetchSquad(teamId: teamId),
            ),
          );
        }

        if (state is ViewStateSuccess<List<PlayerEntry>>) {
          final players = state.data;

          if (players.isEmpty) {
            return const Center(child: Text('No players found.'));
          }

          return RefreshIndicator(
            onRefresh: () => controller.refreshSquad(teamId: teamId),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: players.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final player = players[index];
                return ListTile(
                  onTap: () => Get.toNamed(AppRoutes.playerProfile, arguments: {'playerId': player.id}),
                  leading: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: player.photo ?? '',
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 2),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  title: Text(player.name ?? ''),
                  subtitle: Text('${player.position} • #${player.number ?? '-'}'),
                  trailing: Text('Age: ${player.age}'),
                );
              },
            ),
          );
        }

        return const SizedBox.shrink(); // ViewStateInitial
      }),
    );
  }
}
