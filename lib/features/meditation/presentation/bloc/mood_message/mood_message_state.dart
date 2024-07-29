import 'package:mental_health/features/meditation/domain/entities/daily_quote.dart';
import 'package:mental_health/features/meditation/domain/entities/mood_message.dart';

abstract class MoodMessageState {}

class MoodMessageInitial extends MoodMessageState{}

class MoodMessageLoading extends MoodMessageState{}

class MoodMessageLoaded extends MoodMessageState{
  final MoodMessage moodMessage;

  MoodMessageLoaded({required this.moodMessage});
}

class MoodMessageError extends MoodMessageState{
  final String message;

  MoodMessageError({required this.message});
}