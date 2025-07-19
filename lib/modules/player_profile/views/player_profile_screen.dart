import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:football_app/modules/player_profile/widgets/player_info_tile.dart';
import 'package:football_app/shared/widgets/view_state_error_widget.dart';
import 'package:get/get.dart';
import 'package:football_app/core/state/view_state.dart';
import 'package:football_app/modules/player_profile/controllers/player_profile_controller.dart';
import 'package:football_app/modules/player_profile/models/player_profile.dart';

class PlayerProfileScreen extends StatelessWidget {
  const PlayerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlayerProfileController(Get.find()));
    final args = Get.arguments as Map<String, dynamic>;

    final int playerId = args['playerId'];

    // Fetch profile on screen load
    controller.fetchPlayerProfile(playerId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Profile'),
      ),
      body: Obx(() {
        final state = controller.profileState;

        if (state is ViewStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ViewStateError) {
          return Center(
            child: ViewStateErrorWidget(
              message: state.message,
              onRetry: () => controller.fetchPlayerProfile(playerId),
            ),
          );
        }

        if (state is ViewStateSuccess<PlayerProfile>) {
          final player = state.data;
          final theme = Theme.of(context);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Player photo
                ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: CachedNetworkImage(
                    imageUrl: player.photo,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(height: 16),

                // Name & position
                Text(
                  player.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  player.position,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 16),

                // Divider and Info
                const Divider(),
                PlayerInfoTile(label: 'Age', value: '${player.age}'),
                PlayerInfoTile(label: 'Jersey Number', value: player.number?.toString() ?? '-'),
                PlayerInfoTile(label: 'Nationality', value: player.nationality),
                PlayerInfoTile(label: 'Height', value: player.height),
                PlayerInfoTile(label: 'Weight', value: player.weight),
                const Divider(),

                PlayerInfoTile(label: 'Birth Date', value: player.birthDate),
                PlayerInfoTile(label: 'Birth Place', value: '${player.birthPlace}, ${player.birthCountry}'),
              ],
            ),
          );
        }

        return const SizedBox.shrink(); // fallback
      }),
    );
  }
}
