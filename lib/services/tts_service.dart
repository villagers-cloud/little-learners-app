import 'package:flutter_tts/flutter_tts.dart';
import '../l10n/strings.dart';

/// Thin wrapper around flutter_tts so screens don't repeat setup code.
///
/// NOTE for production: flutter_tts uses the phone's built-in speech
/// engine, which works offline once its language pack is downloaded, but
/// it will sound synthetic. For a polished release, record real audio
/// (a parent/voice artist reading each letter, number, and story) as
/// .mp3 files under assets/audio/, and swap the calls below for
/// audioplayers playback keyed by the same ids used here. The rest of
/// the app (screens, navigation, progress) does not need to change.
class TtsService {
  final FlutterTts _tts = FlutterTts();

  Future<void> speak(String text, AppLanguage lang) async {
    await _tts.stop();
    await _tts.setLanguage(lang == AppLanguage.hi ? 'hi-IN' : 'en-US');
    await _tts.setSpeechRate(0.42); // slower pace, easier for young kids to follow
    await _tts.setPitch(1.1);
    await _tts.speak(text);
  }

  Future<void> stop() => _tts.stop();
}
