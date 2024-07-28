import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mental_health/core/theme.dart';
import 'package:mental_health/features/music/domain/entities/song.dart';

class MusicPlayerScreen extends StatefulWidget {
  final Song song;
  MusicPlayerScreen({Key? key, required this.song}) : super(key: key);

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool isLooping = false;

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.setUrl(widget.song.songLink);
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    if(_audioPlayer.playing){
      _audioPlayer.pause();
    }else{
      _audioPlayer.play();
    }
  }

  void seekBackward(){
    final currentPosition = _audioPlayer.position;
    final newPosition = currentPosition - Duration(seconds: 10);
    _audioPlayer.seek(newPosition >= Duration.zero ? newPosition : Duration.zero);
  }

  void seekForward(){
    final currentPosition = _audioPlayer.position;
    final newPosition = currentPosition + Duration(seconds: 10);
    _audioPlayer.seek(newPosition);
  }

  void seekRestart(){
    _audioPlayer.seek(Duration.zero);
  }

  void toggleLoop(){
    setState(() {
      isLooping = !isLooping;
      _audioPlayer.setLoopMode(isLooping ? LoopMode.one : LoopMode.off);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: Image.asset('assets/down_arrow.png'),
          onTap: (){
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Image.asset('assets/transcript_icon.png'),
          const SizedBox(width: 16,)
        ],
      ),
      backgroundColor: DefaultColors.white,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // artwork
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/child_with_dog.png',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16,),
            Text(widget.song.title, style: Theme.of(context).textTheme.labelLarge,),
            Text('By : ${widget.song.author}', style: Theme.of(context).textTheme.labelSmall,),
            const Spacer(),
            StreamBuilder<Duration>(
              stream: _audioPlayer.positionStream,
              builder: (context, snapshot){
                final position = snapshot.data ?? Duration.zero;
                final total = _audioPlayer.duration ?? Duration.zero;
                return ProgressBar(
                    progress: position,
                    total: total,
                    baseBarColor: DefaultColors.lightpink,
                    thumbColor: DefaultColors.pink,
                    progressBarColor: DefaultColors.pink,
                    onSeek: (duration) {
                      _audioPlayer.seek(duration);
                    },
                  );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.shuffle, color: DefaultColors.pink,)
                ),
                IconButton(
                  onPressed: seekBackward,
                  icon: Icon(Icons.skip_previous, color: DefaultColors.pink,)
                ),
                StreamBuilder(
                    stream: _audioPlayer.playerStateStream,
                    builder: (context, snapshot){
                      final playerState = snapshot.data;
                      final processingState = playerState?.processingState ?? ProcessingState.idle;
                      final playing = playerState?.playing ?? false;

                      if(processingState == ProcessingState.loading || processingState == ProcessingState.buffering){
                        return Container(
                          margin: EdgeInsets.all(8),
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(color: DefaultColors.pink,),
                        );
                      }
                      else if(!playing){
                        return IconButton(
                            iconSize: 80,
                            onPressed: togglePlayPause,
                            icon: Icon(Icons.play_circle_filled, color: DefaultColors.pink,)
                        );
                      }else if(processingState != ProcessingState.completed){
                        return IconButton(
                            iconSize: 80,
                            onPressed: togglePlayPause,
                            icon: Icon(Icons.pause_circle_filled, color: DefaultColors.pink,)
                        );
                      } else {
                        return IconButton(
                            iconSize: 80,
                            onPressed: seekRestart,
                            icon: Icon(Icons.replay_circle_filled, color: DefaultColors.pink,)
                        );
                      }
                    }
                ),
                IconButton(
                  onPressed: seekForward,
                  icon: Icon(Icons.skip_next, color: DefaultColors.pink,)
                ),
                IconButton(
                  onPressed: toggleLoop,
                  icon: Icon(isLooping ? Icons.repeat_one : Icons.repeat, color: DefaultColors.pink,)
                )
              ],
            )
          ],
        )
      ),
    );
  }
}
