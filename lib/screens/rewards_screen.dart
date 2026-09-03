import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_state.dart';
import '../widgets/common_widgets.dart';
import '../theme.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final s = app.strings;

    final badgeDefs = [
      ('alphabet', Icons.abc, s.badgeAlphabet),
      ('memory', Icons.psychology, s.badgeMemory),
      ('artist', Icons.palette, s.badgeArtist),
      ('storyteller', Icons.menu_book, s.badgeStoryteller),
      ('family', Icons.family_restroom, s.badgeFamily),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(s.rewardsTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.sun,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text('${app.stars}',
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w800)),
                  Text(s.rewardsStarsEarned),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: badgeDefs
                  .map((b) => BadgeTile(icon: b.$2, label: b.$3, unlocked: app.hasBadge(b.$1)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
