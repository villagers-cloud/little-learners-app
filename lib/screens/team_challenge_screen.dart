import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_state.dart';
import '../data/content_data.dart';
import '../theme.dart';

class TeamChallengeScreen extends StatefulWidget {
  const TeamChallengeScreen({super.key});

  @override
  State<TeamChallengeScreen> createState() => _TeamChallengeScreenState();
}

class _TeamChallengeScreenState extends State<TeamChallengeScreen> {
  int _index = 0;
  String? _selected;
  bool _isCorrect = false;
  bool _answered = false;

  void _answer(String option, String correct) {
    setState(() {
      _selected = option;
      _isCorrect = option == correct;
      _answered = true;
    });
    if (_isCorrect) {
      context.read<AppState>().addStars(3);
      context.read<AppState>().unlockBadge('family');
    }
  }

  void _next() {
    setState(() {
      _index = (_index + 1) % quizBank.length;
      _selected = null;
      _answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final s = app.strings;
    final lang = app.language;
    final q = quizBank[_index];

    return Scaffold(
      appBar: AppBar(title: Text(s.coplayTeamChallenge)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1EC),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.teamChallengeInstructions, style: const TextStyle(fontSize: 13)),
                  const SizedBox(height: 8),
                  Text('${s.questionOf} ${_index + 1}/${quizBank.length}',
                      style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(q.question[lang]!,
                style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.4,
              children: q.options[lang]!.map((opt) {
                Color bg = Colors.white;
                Color border = AppColors.coral;
                if (_answered && opt == _selected) {
                  bg = _isCorrect ? AppColors.leaf : const Color(0xFFF3B8B0);
                  border = _isCorrect ? AppColors.leaf : AppColors.coral;
                }
                return Material(
                  color: bg,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: _answered ? null : () => _answer(opt, q.answer[lang]!),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: border, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(opt,
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 14),
            if (_answered)
              Text(_isCorrect ? s.correctAnswer : s.wrongAnswer,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: _isCorrect ? AppColors.leaf : AppColors.coral)),
            const Spacer(),
            if (_answered)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.grape, foregroundColor: Colors.white),
                  child: Text(s.nextQuestion),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
