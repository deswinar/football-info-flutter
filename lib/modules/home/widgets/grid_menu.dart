import 'package:flutter/material.dart';
import 'package:football_app/routes/app_routes.dart';
import 'package:get/get.dart';

class GridMenu extends StatelessWidget {
  const GridMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final items = [
      {'icon': Icons.people, 'label': 'Teams', 'route': AppRoutes.teams},
      {'icon': Icons.person, 'label': 'All Players', 'route': AppRoutes.playerList},
    ];

    return GridView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () => Get.toNamed(item['route'] as String),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: colorScheme.primary.withAlpha(25),
                child: Icon(
                  item['icon'] as IconData,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item['label'] as String,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        );
      },
    );
  }
}
