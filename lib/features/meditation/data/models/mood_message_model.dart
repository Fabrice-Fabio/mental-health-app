import 'package:mental_health/features/meditation/domain/entities/mood_message.dart';

class MoodMessageModel extends MoodMessage {
  MoodMessageModel({required String text}) : super(text: text);

  factory MoodMessageModel.fromJson(Map<String, dynamic> json) {
    return MoodMessageModel(text: json['text']);
  }
}