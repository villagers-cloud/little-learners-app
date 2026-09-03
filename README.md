# Little Learners — Flutter app

A bilingual (English / Hindi) offline kids' learning app with four zones —
Learning, Play, Creative, and Co-play mode — matching the structure and
diagrams discussed earlier in this chat.

## What's included (real, working code)

- Full navigation across Home → Learning zone (A–Z alphabet + 1–100
  numbers) → Play zone (memory game, 3 difficulty levels) → Creative
  zone (5 tap-to-fill coloring pages) → Co-play mode (Team Challenge
  quiz, Story Time with 2 stories, Voice Notes recorder) → Rewards
  (stars + 5 badges).
- English/Hindi language toggle, English as the default. All UI text
  lives in `lib/l10n/strings.dart` — add a third language there.
- Progress (stars, badges, chosen language) is saved on-device with
  `shared_preferences`, so it survives closing the app.
- Offline voice via `flutter_tts` (the phone's built-in speech engine —
  works without internet once the language pack is on the device).
- A real microphone recorder for the parent's-voice feature
  (`record` + `audioplayers` + `path_provider`), fully wired up.

## What you still need to add before a store release

This is architecture and logic, not finished art or audio. Two things
no code can generate for you:

1. **Real illustrations.** Every letter, coloring page, and icon
   currently uses Flutter's built-in Material icons as placeholders
   (see `lib/data/content_data.dart`). Commission an illustrator (or
   use a licensed kids' icon pack) and swap the `IconData` fields for
   `Image.asset(...)` widgets pointing at your art.
2. **Real recorded voice.** `TtsService` (`lib/services/tts_service.dart`)
   uses the phone's synthetic voice so the app is usable right now, but
   it sounds robotic. For release quality, record a voice artist reading
   each letter/number/story line, bundle the files under `assets/audio/`,
   and swap `TtsService.speak()` calls for `audioplayers` playback keyed
   by the same id. No screen code needs to change.

Everything else — more letters (already full A–Z), more quiz questions,
more stories, more coloring pages — is just adding entries to the lists
in `lib/data/content_data.dart`; the screens read from those lists
automatically.

## Running it

You'll need the Flutter SDK installed first (see the step-by-step setup
guide from earlier in this chat: flutter.dev/docs/get-started/install).

```bash
cd little_learners

# This project ships lib/ and pubspec.yaml only. Run this once to let
# Flutter generate the android/ and ios/ platform folders for your machine:
flutter create .

flutter pub get
flutter run
```

### Microphone permission (for Voice Notes)

After `flutter create .` generates the platform folders, add:

- **Android** (`android/app/src/main/AndroidManifest.xml`), inside `<manifest>`:
  ```xml
  <uses-permission android:name="android.permission.RECORD_AUDIO" />
  ```
- **iOS** (`ios/Runner/Info.plist`), inside the top-level `<dict>`:
  ```xml
  <key>NSMicrophoneUsageDescription</key>
  <string>Little Learners uses the microphone so parents can record voice notes for their child.</string>
  ```

## Project structure

```
lib/
  main.dart                 # app entry point
  theme.dart                 # colors and theme
  l10n/strings.dart          # all EN/HI text in one place
  data/content_data.dart     # letters, numbers, quiz bank, stories, coloring pages
  services/
    app_state.dart           # language, stars, badges - persisted
    tts_service.dart         # offline text-to-speech
    recording_service.dart   # parent voice recording/playback
  widgets/                   # shared UI pieces (zone card, star bar, badge tile)
  screens/                   # one file per screen
```
