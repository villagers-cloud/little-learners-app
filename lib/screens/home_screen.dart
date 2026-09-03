import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_state.dart';
import '../theme.dart';
import '../l10n/strings.dart';
import '../widgets/zone_card.dart';
import '../widgets/common_widgets.dart';
import 'learning_zone_screen.dart';
import 'play_zone_screen.dart';
import 'creative_zone_screen.dart';
import 'coplay_hub_screen.dart';
import 'rewards_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final s = app.strings;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('🦊', style: TextStyle(fontSize: 28)),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.appName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                Text(s.tagline, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: LanguageToggle(
              isHindi: app.language == AppLanguage.hi,
              onChanged: (isHindi) =>
                  context.read<AppState>().setLanguage(isHindi ? AppLanguage.hi : AppLanguage.en),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StarBar(stars: app.stars, label: s.stars),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.05,
                children: [
                  ZoneCard(
                    icon: Icons.abc,
                    title: s.zoneLearning,
                    subtitle: s.zoneLearningSub,
                    accentColor: AppColors.sky,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LearningZoneScreen())),
                  ),
                  ZoneCard(
                    icon: Icons.extension,
                    title: s.zonePlay,
                    subtitle: s.zonePlaySub,
                    accentColor: AppColors.sun,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const PlayZoneScreen())),
                  ),
                  ZoneCard(
                    icon: Icons.palette,
                    title: s.zoneCreative,
                    subtitle: s.zoneCreativeSub,
                    accentColor: AppColors.leaf,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const CreativeZoneScreen())),
                  ),
                  ZoneCard(
                    icon: Icons.family_restroom,
                    title: s.zoneCoplay,
                    subtitle: s.zoneCoplaySub,
                    accentColor: AppColors.coral,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const CoplayHubScreen())),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const RewardsScreen())),
              icon: const Icon(Icons.emoji_events, color: AppColors.grape),
              label: Text(s.viewRewards,
                  style: const TextStyle(color: AppColors.grape, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}
