import 'package:mental_health/features/meditation/domain/entities/daily_quote.dart';
import 'package:mental_health/features/meditation/domain/entities/mood_message.dart';

abstract class MeditationState {}

class MeditationInitial extends MeditationState {}

class MeditationLoading extends MeditationState {}

class MeditationError extends MeditationState {
  final String message;

  MeditationError({required this.message});
}

class DailyQuoteLoaded extends MeditationState{
  final DailyQuote dailyQuote;

  DailyQuoteLoaded({required this.dailyQuote});
}

class MoodMessageLoaded extends MeditationState {
  final MoodMessage moodMessage;

  MoodMessageLoaded({required this.moodMessage});
}