import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_state.dart';
import '../services/tts_service.dart';
import '../data/content_data.dart';
import '../theme.dart';

class StoryTimeScreen extends StatelessWidget {
  const StoryTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final s = app.strings;
    final lang = app.language;

    return Scaffold(
      appBar: AppBar(title: Text(s.storyListTitle)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: storyData.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final story = storyData[i];
          return Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => _StoryReaderScreen(story: story))),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: const Border(bottom: BorderSide(color: AppColors.coral, width: 4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.menu_book, color: AppColors.coral, size: 26),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(story.title[lang]!,
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StoryReaderScreen extends StatefulWidget {
  final Story story;
  const _StoryReaderScreen({required this.story});

  @override
  State<_StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends State<_StoryReaderScreen> {
  int _page = 0;
  bool _showQuestion = false;
  String? _selected;
  bool _answered = false;
  final TtsService _tts = TtsService();

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final s = app.strings;
    final lang = app.language;
    final pages = widget.story.pages[lang]!;

    return Scaffold(
      appBar: AppBar(title: Text(widget.story.title[lang]!)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _showQuestion
            ? _questionView(s, lang)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${_page + 1}/${pages.length}',
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Center(
                      child: Text(pages[_page],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20, height: 1.5)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () => _tts.speak(pages[_page], lang),
                        icon: const Icon(Icons.volume_up),
                        label: Text(s.readAloud),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.coral, foregroundColor: Colors.white),
                        onPressed: () {
                          if (_page < pages.length - 1) {
                            setState(() => _page++);
                          } else {
                            setState(() => _showQuestion = true);
                          }
                        },
                        child: Icon(_page < pages.length - 1
                            ? Icons.arrow_forward
                            : Icons.check),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget _questionView(dynamic s, dynamic lang) {
    final story = widget.story;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(s.storyQuestionPrompt, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        const SizedBox(height: 8),
        Text(story.question[lang]!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        const SizedBox(height: 20),
        ...story.options[lang]!.map((opt) {
          Color border = AppColors.coral;
          Color bg = Colors.white;
          if (_answered && opt == _selected) {
            final correct = opt == story.answer[lang];
            bg = correct ? AppColors.leaf : const Color(0xFFF3B8B0);
            border = correct ? AppColors.leaf : AppColors.coral;
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Material(
              color: bg,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: _answered
                    ? null
                    : () {
                        setState(() {
                          _selected = opt;
                          _answered = true;
                        });
                        if (opt == story.answer[lang]) {
                          context.read<AppState>().addStars(3);
                          context.read<AppState>().unlockBadge('storyteller');
                        }
                      },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration:
                      BoxDecoration(border: Border.all(color: border), borderRadius: BorderRadius.circular(12)),
                  child: Text(opt, style: const TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          );
        }),
        if (_answered)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColors.grape, foregroundColor: Colors.white),
              child: Text(s.finishStory),
            ),
          ),
      ],
    );
  }
}
