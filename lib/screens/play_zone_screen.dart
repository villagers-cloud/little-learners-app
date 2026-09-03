import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_state.dart';
import '../data/content_data.dart';
import '../theme.dart';

class PlayZoneScreen extends StatefulWidget {
  const PlayZoneScreen({super.key});

  @override
  State<PlayZoneScreen> createState() => _PlayZoneScreenState();
}

class _PlayZoneScreenState extends State<PlayZoneScreen> {
  String? _level;

  void _pickLevel(String level) {
    setState(() => _level = level);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>().strings;

    return Scaffold(
      appBar: AppBar(title: Text(s.zonePlay)),
      body: _level == null
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.playChooseLevel,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  _LevelButton(label: s.levelEasy, color: AppColors.leaf, onTap: () => _pickLevel('easy')),
                  const SizedBox(height: 12),
                  _LevelButton(label: s.levelMedium, color: AppColors.sun, onTap: () => _pickLevel('medium')),
                  const SizedBox(height: 12),
                  _LevelButton(label: s.levelHard, color: AppColors.coral, onTap: () => _pickLevel('hard')),
                ],
              ),
            )
          : _MemoryGame(level: _level!, onExitLevel: () => setState(() => _level = null)),
    );
  }
}

class _LevelButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _LevelButton({required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: onTap,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
      ),
    );
  }
}

class _MemoryGame extends StatefulWidget {
  final String level;
  final VoidCallback onExitLevel;
  const _MemoryGame({required this.level, required this.onExitLevel});

  @override
  State<_MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<_MemoryGame> {
  late List<IconData> _deck;
  final Set<int> _flipped = {};
  final Set<int> _matched = {};
  int _moves = 0;
  bool _locked = false;

  @override
  void initState() {
    super.initState();
    _buildDeck();
  }

  void _buildDeck() {
    final icons = memoryIconSets[widget.level]!;
    final pairDeck = [...icons, ...icons];
    pairDeck.shuffle(Random());
    _deck = pairDeck;
    _flipped.clear();
    _matched.clear();
    _moves = 0;
  }

  void _tapCard(int index) {
    if (_locked || _flipped.contains(index) || _matched.contains(index)) return;
    setState(() => _flipped.add(index));

    if (_flipped.length == 2) {
      _moves++;
      final indices = _flipped.toList();
      final a = indices[0], b = indices[1];
      if (_deck[a] == _deck[b]) {
        _matched.addAll([a, b]);
        _flipped.clear();
        context.read<AppState>().addStars(2);
        if (_matched.length == _deck.length) {
          context.read<AppState>().unlockBadge('memory');
        }
        setState(() {});
      } else {
        _locked = true;
        Future.delayed(const Duration(milliseconds: 700), () {
          setState(() {
            _flipped.clear();
            _locked = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>().strings;
    final done = _matched.length == _deck.length;
    final cols = _deck.length <= 8 ? 4 : (_deck.length <= 12 ? 4 : 4);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: widget.onExitLevel,
                icon: const Icon(Icons.arrow_back, size: 16),
                label: Text(s.playChooseLevel),
              ),
              Text('${s.moves}: $_moves', style: const TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
          if (done) ...[
            const SizedBox(height: 4),
            Text(s.matched, style: const TextStyle(color: AppColors.leaf, fontWeight: FontWeight.w800)),
          ],
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _deck.length,
              itemBuilder: (context, i) {
                final isUp = _flipped.contains(i) || _matched.contains(i);
                return GestureDetector(
                  onTap: () => _tapCard(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isUp ? Colors.white : AppColors.grape,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: _matched.contains(i) ? AppColors.leaf : AppColors.sky, width: 2),
                    ),
                    child: Center(
                      child: isUp ? Icon(_deck[i], color: AppColors.ink, size: 26) : null,
                    ),
                  ),
                );
              },
            ),
          ),
          if (done)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: ElevatedButton(
                onPressed: () => setState(_buildDeck),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.grape, foregroundColor: Colors.white),
                child: Text(s.playAgain),
              ),
            ),
        ],
      ),
    );
  }
}
