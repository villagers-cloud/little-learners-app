import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/strings.dart';

/// Central, app-wide state: current language, star count, and which
/// badges are unlocked. Backed by SharedPreferences so progress survives
/// closing the app (unlike the earlier web demo, which reset on reload).
///
/// Wrapped around the whole app with a ChangeNotifierProvider in main.dart,
/// so any screen can read it with `context.watch<AppState>()` and any
/// screen can update it with `context.read<AppState>()`.
class AppState extends ChangeNotifier {
  AppLanguage _language = AppLanguage.en; // English is the default/global language.
  int _stars = 0;
  final Set<String> _badges = {};

  static const _prefsLanguageKey = 'language';
  static const _prefsStarsKey = 'stars';
  static const _prefsBadgesKey = 'badges';

  AppLanguage get language => _language;
  AppStrings get strings => AppStrings.all[_language]!;
  int get stars => _stars;
  Set<String> get badges => _badges;

  bool hasBadge(String id) => _badges.contains(id);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString(_prefsLanguageKey);
    if (savedLang == 'hi') _language = AppLanguage.hi;
    _stars = prefs.getInt(_prefsStarsKey) ?? 0;
    _badges.addAll(prefs.getStringList(_prefsBadgesKey) ?? []);
    notifyListeners();
  }

  Future<void> setLanguage(AppLanguage lang) async {
    _language = lang;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsLanguageKey, lang == AppLanguage.hi ? 'hi' : 'en');
  }

  Future<void> addStars(int amount) async {
    _stars += amount;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefsStarsKey, _stars);
  }

  Future<void> unlockBadge(String id) async {
    if (_badges.contains(id)) return;
    _badges.add(id);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsBadgesKey, _badges.toList());
  }
}
