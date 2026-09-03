import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_state.dart';
import '../theme.dart';
import '../widgets/zone_card.dart';
import 'team_challenge_screen.dart';
import 'story_time_screen.dart';
import 'voice_recording_screen.dart';
import 'rewards_screen.dart';

class CoplayHubScreen extends StatelessWidget {
  const CoplayHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>().strings;

    return Scaffold(
      appBar: AppBar(title: Text(s.coplayHubTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1.05,
          children: [
            ZoneCard(
              icon: Icons.flag,
              title: s.coplayTeamChallenge,
              subtitle: s.coplayTeamChallengeSub,
              accentColor: AppColors.coral,
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const TeamChallengeScreen())),
            ),
            ZoneCard(
              icon: Icons.menu_book,
              title: s.coplayStoryTime,
              subtitle: s.coplayStoryTimeSub,
              accentColor: AppColors.coral,
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const StoryTimeScreen())),
            ),
            ZoneCard(
              icon: Icons.mic,
              title: s.coplayVoiceNotes,
              subtitle: s.coplayVoiceNotesSub,
              accentColor: AppColors.coral,
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const VoiceRecordingScreen())),
            ),
            ZoneCard(
              icon: Icons.emoji_events,
              title: s.coplayFamilyBadges,
              subtitle: s.coplayFamilyBadgesSub,
              accentColor: AppColors.coral,
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const RewardsScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
