import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_state.dart';
import '../data/content_data.dart';
import '../theme.dart';

const List<Color> _palette = [
  AppColors.coral,
  AppColors.sky,
  AppColors.sun,
  AppColors.grape,
  AppColors.leaf,
  Color(0xFFFF9EC4),
];

class CreativeZoneScreen extends StatefulWidget {
  const CreativeZoneScreen({super.key});

  @override
  State<CreativeZoneScreen> createState() => _CreativeZoneScreenState();
}

class _CreativeZoneScreenState extends State<CreativeZoneScreen> {
  int _pageIndex = 0;
  Color _selectedColor = _palette[0];

  // pageId -> regionId -> chosen color
  final Map<String, Map<String, Color>> _fills = {};

  Color _colorFor(String pageId, String regionId, Color fallback) {
    return _fills[pageId]?[regionId] ?? fallback;
  }

  void _fill(String pageId, String regionId) {
    _fills.putIfAbsent(pageId, () => {});
    setState(() => _fills[pageId]![regionId] = _selectedColor);
    context.read<AppState>().addStars(1);
    context.read<AppState>().unlockBadge('artist');
  }

  void _clearPage(String pageId) {
    setState(() => _fills[pageId] = {});
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final s = app.strings;
    final lang = app.language;
    final page = coloringPages[_pageIndex];

    return Scaffold(
      appBar: AppBar(title: Text(s.coloringTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  tooltip: s.previousPicture,
                  onPressed: _pageIndex > 0 ? () => setState(() => _pageIndex--) : null,
                ),
                Text(page.name[lang]!,
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  tooltip: s.nextPicture,
                  onPressed: _pageIndex < coloringPages.length - 1
                      ? () => setState(() => _pageIndex++)
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: _palette.map((c) {
                final selected = c == _selectedColor;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = c),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: c,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: selected ? AppColors.ink : Colors.transparent, width: 3),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: _ColoringCanvas(
                  page: page,
                  colorFor: _colorFor,
                  onTapRegion: _fill,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () => _clearPage(page.id),
              icon: const Icon(Icons.refresh, color: AppColors.coral),
              label: Text(s.clear, style: const TextStyle(color: AppColors.coral)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Renders one coloring page as tappable shape regions. Shapes are simple
/// geometric stand-ins (see README) - swap for real line-art SVGs later,
/// keeping the same pageId/regionId tap contract.
class _ColoringCanvas extends StatelessWidget {
  final ColoringPage page;
  final Color Function(String pageId, String regionId, Color fallback) colorFor;
  final void Function(String pageId, String regionId) onTapRegion;

  const _ColoringCanvas({required this.page, required this.colorFor, required this.onTapRegion});

  Widget _region(String regionId, Widget shape) {
    return GestureDetector(
      onTap: () => onTapRegion(page.id, regionId),
      child: shape,
    );
  }

  @override
  Widget build(BuildContext context) {
    const outline = Colors.black26;
    switch (page.id) {
      case 'sun':
        return _region(
          'body',
          Icon(Icons.wb_sunny, size: 180, color: colorFor(page.id, 'body', outline)),
        );
      case 'heart':
        return _region(
          'body',
          Icon(Icons.favorite, size: 180, color: colorFor(page.id, 'body', outline)),
        );
      case 'flower':
        return SizedBox(
          width: 200,
          height: 200,
          child: Stack(alignment: Alignment.center, children: [
            _region('petals',
                Icon(Icons.local_florist, size: 190, color: colorFor(page.id, 'petals', outline))),
            _region(
                'center',
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                      color: colorFor(page.id, 'center', outline), shape: BoxShape.circle),
                )),
          ]),
        );
      case 'fish':
        return SizedBox(
          width: 220,
          height: 160,
          child: Stack(alignment: Alignment.center, children: [
            _region('body',
                Icon(Icons.set_meal, size: 180, color: colorFor(page.id, 'body', outline))),
            Positioned(
              right: 10,
              child: _region(
                'tail',
                Icon(Icons.play_arrow, size: 40, color: colorFor(page.id, 'tail', outline)),
              ),
            ),
          ]),
        );
      case 'house':
        return SizedBox(
          width: 200,
          height: 200,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            _region('roof',
                Icon(Icons.change_history, size: 90, color: colorFor(page.id, 'roof', outline))),
            SizedBox(
              width: 140,
              height: 100,
              child: Stack(alignment: Alignment.center, children: [
                _region(
                    'wall',
                    Container(
                        color: colorFor(page.id, 'wall', const Color(0xFFF3F0E8)),
                        width: 140,
                        height: 100)),
                _region(
                    'door',
                    Container(
                        width: 30,
                        height: 50,
                        color: colorFor(page.id, 'door', outline))),
              ]),
            ),
          ]),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
