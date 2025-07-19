import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football_app/routes/app_routes.dart';
import 'package:football_app/shared/data/responses/top_assist_response.dart';
import 'package:get/get.dart';

class TopAssistPlayerCard extends StatelessWidget {
  final TopAssistResponse player;

  const TopAssistPlayerCard({required this.player, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.playerProfile, arguments: {'playerId': player.player.id});
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: colorScheme.surfaceContainerHighest,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: colorScheme.surface,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: player.player.photo,
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
            const SizedBox(height: 8),
            Text(
              player.player.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              '${player.statistics.first.goals['total'] ?? 0} Goals',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
