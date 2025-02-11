import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:learnara/app/constants/api_endpoint.dart';
import 'package:learnara/features/Activitytype/domain/entity/audio/audio_entity.dart';
import 'package:learnara/features/Activitytype/presentation/view_model/activity/activity_bloc.dart';

class AudioLearningPage extends StatelessWidget {
  const AudioLearningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Learning',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600
          ),),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocBuilder<ActivityBloc, ActivityState>(
        builder: (context, state) {
          if (state.audioActivitiesStatus == ActivityStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.audioActivitiesStatus == ActivityStatus.error) {
            return Center(
              child: Text(
                'Error loading audio lessons: ${state.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (state.audioActivities.isEmpty) {
            return const Center(child: Text('No audio lessons available'));
          }
          return ListView.builder(
            itemCount: state.audioActivities.length,
            itemBuilder: (context, index) {
              return AudioLessonCard(audioLesson: state.audioActivities[index]);
            },
          );
        },
      ),
    );
  }
}

class AudioLessonCard extends StatefulWidget {
  final AudioEntity audioLesson;

  const AudioLessonCard({Key? key, required this.audioLesson}) : super(key: key);

  @override
  _AudioLessonCardState createState() => _AudioLessonCardState();
}

class _AudioLessonCardState extends State<AudioLessonCard> {
  late AudioPlayer _audioPlayer;
  Duration? _totalDuration;
  Duration _currentPosition = Duration.zero;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initializeAudio();

    // Listen for audio completion
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          _isCompleted = true;
        });
      }
    });
  }

  Future<void> _initializeAudio() async {
    try {
      final audioUrl = _getFullAudioUrl(widget.audioLesson.audio);
      final duration = await _audioPlayer.setUrl(audioUrl);
      if (duration != null) {
        setState(() {
          _totalDuration = duration;
        });
      }
      _audioPlayer.positionStream.listen((position) {
        setState(() {
          _currentPosition = position;
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading audio: $e'), backgroundColor: Colors.red),
      );
    }
  }

  void _restartAudio() {
    _audioPlayer.seek(Duration.zero);
    _audioPlayer.play();
    setState(() {
      _isCompleted = false;
    });
  }

  String _getFullAudioUrl(String audioPath) {
    return audioPath.startsWith('http') ? audioPath : '${ApiEndpoints.baseUrl}$audioPath';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalSeconds = _totalDuration?.inSeconds ?? widget.audioLesson.duration;
    final progress = totalSeconds > 0 ? _currentPosition.inSeconds / totalSeconds : 0.0;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.audioLesson.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(widget.audioLesson.description, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Lesson Preview:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(widget.audioLesson.transcript ?? 'No transcript available',
                      maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isCompleted
                    ? IconButton(
                  icon: const Icon(Icons.replay, size: 64, color: Colors.blue),
                  onPressed: _restartAudio,
                )
                    : StreamBuilder<PlayerState>(
                  stream: _audioPlayer.playerStateStream,
                  builder: (context, snapshot) {
                    final playing = snapshot.data?.playing ?? false;
                    return IconButton(
                      icon: Icon(playing ? Icons.pause_circle_filled : Icons.play_circle_fill, size: 64, color: Colors.blue),
                      onPressed: playing ? _audioPlayer.pause : _audioPlayer.play,
                    );
                  },
                ),
              ],
            ),
            Slider(
              min: 0.0,
              max: totalSeconds.toDouble(),
              value: _isCompleted ? totalSeconds.toDouble() : (progress * totalSeconds),
              onChanged: (value) => _audioPlayer.seek(Duration(seconds: value.toInt())),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Duration: ${_formatDuration(Duration(seconds: totalSeconds))}', style: const TextStyle(fontSize: 12)),
                Text('Completion: ${_isCompleted ? '100.0' : (progress * 100).toStringAsFixed(1)}%', style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    return '${duration.inMinutes}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }
}