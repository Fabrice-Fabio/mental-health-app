import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mental_health/features/music/data/models/SongModel.dart';

abstract class SongRemoteDataSource {
  Future<List<SongModel>> getAllSongs();
}

class SongRemoteDataSourceImpl implements SongRemoteDataSource {
  final http.Client client;
  
  SongRemoteDataSourceImpl({required this.client});
  
  @override
  Future<List<SongModel>> getAllSongs() async {
    final response = await client.get(Uri.parse('http://localhost:6000/songs/all'));

    if(response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((song) => SongModel.fromJson(song)).toList();
    } else {
      throw Exception('Failed to load songs');
    }
  }
  
}