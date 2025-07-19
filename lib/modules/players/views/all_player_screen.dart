import 'package:flutter/material.dart';
import 'package:football_app/modules/player_squad/models/player_entry.dart';
import 'package:football_app/modules/players/controllers/player_controller.dart';
import 'package:football_app/shared/widgets/view_state_error_widget.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:football_app/core/state/view_state.dart';

class AllPlayersScreen extends StatelessWidget {
  const AllPlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlayerController>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Players'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              controller: searchController,
              onChanged: (query) {
                // debounce if needed, or instant search:
                controller.searchPlayers(query.trim());
              },
              decoration: InputDecoration(
                hintText: 'Search player...',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        final state = controller.playersState;

        if (state is ViewStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ViewStateError) {
          return Center(
            child: ViewStateErrorWidget(
              message: state.message,
              onRetry: () => controller.fetchPlayers(reset: true),
            ),
          );
        }

        if (state is ViewStateSuccess<List<PlayerEntry>>) {
          final players = state.data;

          if (players.isEmpty) {
            return const Center(child: Text('No players found.'));
          }

          return RefreshIndicator(
            onRefresh: controller.refreshPlayers,
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200 &&
                    controller.hasMore &&
                    !controller.isLoadingMore) {
                  controller.loadMore();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: players.length + (controller.hasMore ? 1 : 0),
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  if (index >= players.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final player = players[index];
                  return _buildPlayerTile(context, player, colorScheme, textTheme);
                },
              ),
            ),
          );
        }

        return const SizedBox();
      }),
    );
  }

  Widget _buildPlayerTile(BuildContext context, PlayerEntry player, ColorScheme colorScheme, TextTheme textTheme) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: colorScheme.surface,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: player.photo,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              placeholder: (_, __) => CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(colorScheme.primary),
              ),
              errorWidget: (_, __, ___) => Icon(Icons.error, size: 28, color: colorScheme.error),
            ),
          ),
        ),
        title: Text(player.name, style: textTheme.titleMedium),
        subtitle: Text(
          '${player.position} • #${player.number ?? '-'} • Age: ${player.age}',
          style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
        onTap: () {
          Get.toNamed('/player-profile', arguments: {'playerId': player.id});
        },
      ),
    );
  }
}
