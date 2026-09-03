import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';

/// One saved parent recording: a label the parent typed (e.g. "Counting
/// to 10") and the file path on the device.
class VoiceNote {
  final String label;
  final String filePath;
  VoiceNote(this.label, this.filePath);
}

/// Handles recording the parent's voice and saving it under the app's
/// local documents folder, and playing recordings back. Everything stays
/// on-device - nothing is uploaded anywhere.
class RecordingService {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();
  final List<VoiceNote> _notes = [];

  List<VoiceNote> get notes => List.unmodifiable(_notes);

  Future<bool> hasPermission() => _recorder.hasPermission();

  Future<void> startRecording() async {
    final dir = await getApplicationDocumentsDirectory();
    final path =
        '${dir.path}/voice_note_${DateTime.now().millisecondsSinceEpoch}.m4a';
    await _recorder.start(const RecordConfig(), path: path);
  }

  /// Stops the current recording and stores it under [label].
  Future<VoiceNote?> stopRecording(String label) async {
    final path = await _recorder.stop();
    if (path == null) return null;
    final note = VoiceNote(label.isEmpty ? 'Voice note' : label, path);
    _notes.add(note);
    return note;
  }

  Future<void> play(VoiceNote note) async {
    await _player.stop();
    await _player.play(DeviceFileSource(note.filePath));
  }

  Future<void> disposeAll() async {
    await _recorder.dispose();
    await _player.dispose();
  }
}
