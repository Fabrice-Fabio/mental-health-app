import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/features/music/domain/usecases/get_all_songs.dart';
import 'package:mental_health/features/music/presentation/bloc/song_event.dart';
import 'package:mental_health/features/music/presentation/bloc/song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final GetAllSongs getAllSongs;

  SongBloc({required this.getAllSongs}) : super(SongInitial()){
    on<FetchSongs>((event, emit) async {
      emit(SongLoading());
      try{
        final songs = await getAllSongs();
        emit(SongLoaded(songs: songs));
      }catch (e){
        emit(SongError(message: e.toString()));
      }
    });
  }
}