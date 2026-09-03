import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_state.dart';
import '../services/tts_service.dart';
import '../data/content_data.dart';
import '../theme.dart';

class LearningZoneScreen extends StatefulWidget {
  const LearningZoneScreen({super.key});

  @override
  State<LearningZoneScreen> createState() => _LearningZoneScreenState();
}

class _LearningZoneScreenState extends State<LearningZoneScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TtsService _tts = TtsService();
  int _spokenNumber = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final s = app.strings;
    final lang = app.language;

    return Scaffold(
      appBar: AppBar(
        title: Text(s.zoneLearning),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.grape,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.grape,
          tabs: [Tab(text: s.learningAlphabetTab), Tab(text: s.learningNumbersTab)],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _AlphabetTab(strings: s, lang: lang, tts: _tts),
          _NumbersTab(
            spoken: _spokenNumber,
            tts: _tts,
            lang: lang,
            title: s.countWithMe,
            onTap: (n) {
              setState(() => _spokenNumber = n);
              _tts.speak('$n', lang);
              context.read<AppState>().addStars(1);
            },
          ),
        ],
      ),
    );
  }
}

class _AlphabetTab extends StatelessWidget {
  final dynamic strings;
  final dynamic lang;
  final TtsService tts;
  const _AlphabetTab({required this.strings, required this.lang, required this.tts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(strings.tapALetter, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: alphabetData.length,
              itemBuilder: (context, i) {
                final card = alphabetData[i];
                return Material(
                  color: AppColors.sky,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      tts.speak('${card.letter}. ${card.word[lang]}', lang);
                      context.read<AppState>().addStars(1);
                      context.read<AppState>().unlockBadge('alphabet');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(card.letter,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                        const SizedBox(height: 4),
                        Icon(card.icon, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NumbersTab extends StatelessWidget {
  final int spoken;
  final TtsService tts;
  final dynamic lang;
  final String title;
  final ValueChanged<int> onTap;
  const _NumbersTab(
      {required this.spoken,
      required this.tts,
      required this.lang,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: List.generate(
                spoken.clamp(0, 20), (i) => const Icon(Icons.star, color: AppColors.sun, size: 20)),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: numbersData.length,
              itemBuilder: (context, i) {
                final n = numbersData[i];
                return Material(
                  color: AppColors.sun,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => onTap(n),
                    child: Center(
                      child: Text('$n',
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
