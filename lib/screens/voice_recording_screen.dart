import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_state.dart';
import '../services/recording_service.dart';
import '../theme.dart';

class VoiceRecordingScreen extends StatefulWidget {
  const VoiceRecordingScreen({super.key});

  @override
  State<VoiceRecordingScreen> createState() => _VoiceRecordingScreenState();
}

class _VoiceRecordingScreenState extends State<VoiceRecordingScreen> {
  final RecordingService _service = RecordingService();
  final TextEditingController _labelController = TextEditingController();
  bool _isRecording = false;
  String? _error;

  @override
  void dispose() {
    _service.disposeAll();
    _labelController.dispose();
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await _service.stopRecording(
          _labelController.text.isEmpty ? 'Voice note' : _labelController.text);
      setState(() {
        _isRecording = false;
        _labelController.clear();
      });
    } else {
      final granted = await _service.hasPermission();
      if (!granted) {
        setState(() => _error = 'Microphone permission is needed to record.');
        return;
      }
      await _service.startRecording();
      setState(() {
        _isRecording = true;
        _error = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppState>().strings;

    return Scaffold(
      appBar: AppBar(title: Text(s.voiceRecordingTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(s.voiceRecordingHint, style: const TextStyle(fontSize: 13, color: Colors.grey)),
            const SizedBox(height: 16),
            TextField(
              controller: _labelController,
              enabled: !_isRecording,
              decoration: InputDecoration(
                hintText: 'e.g. Counting to 10',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: AppColors.coral, fontSize: 12)),
            Center(
              child: GestureDetector(
                onTap: _toggleRecording,
                child: Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: _isRecording ? AppColors.coral : AppColors.grape,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(_isRecording ? Icons.stop : Icons.mic,
                      color: Colors.white, size: 34),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(_isRecording ? s.stopButton : s.recordButton,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _service.notes.isEmpty
                  ? Center(
                      child: Text(s.noRecordingsYet,
                          style: const TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      itemCount: _service.notes.length,
                      itemBuilder: (context, i) {
                        final note = _service.notes[i];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.graphic_eq, color: AppColors.grape),
                            title: Text(note.label),
                            trailing: IconButton(
                              icon: const Icon(Icons.play_arrow),
                              onPressed: () => _service.play(note),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
