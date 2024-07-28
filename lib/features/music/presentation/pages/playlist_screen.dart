import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/core/theme.dart';
import 'package:mental_health/features/music/data/datasources/song_remote_datasource.dart';
import 'package:mental_health/features/music/presentation/bloc/song_bloc.dart';
import 'package:mental_health/features/music/presentation/bloc/song_state.dart';
import 'package:mental_health/features/music/presentation/pages/music_player_screen.dart';
import 'package:http/http.dart' as http;

class PlaylistScreen extends StatelessWidget {
  PlaylistScreen({Key? key}) : super(key: key);
  final List<Map<String, String>> songs = [
    {
      'title': 'Rain On Glass',
      'artist': 'Rain On Glass',
      'thumbnail': 'assets/child_with_dog.png',
    },
    {
      'title': 'Gentle Breeze',
      'artist': 'Soothing Sounds',
      'thumbnail': 'assets/child_with_dog.png',
    },
    {
      'title': 'Whispering Pines',
      'artist': 'Nature Vibes',
      'thumbnail': 'assets/child_with_dog.png',
    },
    {
      'title': 'Ocean Waves Breeze',
      'artist': 'Soothing Sounds',
      'thumbnail': 'assets/child_with_dog.png',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chill Plalist', style: Theme.of(context).textTheme.titleMedium,),
        backgroundColor: DefaultColors.white,
        elevation: 1,
        centerTitle: false,
      ),
      body: BlocBuilder<SongBloc, SongState>(
        builder: (context, state) {
          if(state is SongLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(state is SongLoaded){
            return Container(
              color: DefaultColors.white,
              child: ListView.builder(
                  itemCount: state.songs.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(songs[index]['thumbnail']!),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 15),
                      title: Text(state.songs[index].title, style: Theme.of(context).textTheme.labelMedium,),
                      subtitle: Text(state.songs[index].author, style: Theme.of(context).textTheme.labelSmall,),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MusicPlayerScreen(song: state.songs[index],)),
                        );
                      },
                    );
                  }
              ),
            );
          }
          else if(state is SongError){
            return Center(child: Text(state.message, style: Theme.of(context).textTheme.labelSmall,),);
          } else {
            return Center(child: Text('No songs found', style: Theme.of(context).textTheme.labelSmall,),);
          }
        },
      ),
    );
  }
}
