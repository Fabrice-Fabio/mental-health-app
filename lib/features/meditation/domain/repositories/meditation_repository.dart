import 'package:mental_health/features/meditation/domain/entities/daily_quote.dart';
import 'package:mental_health/features/meditation/domain/entities/mood_message.dart';

abstract class MeditationRepository{
  Future<DailyQuote> getDailyQuote();
  Future<MoodMessage> getMoodMessage(String mood);
}