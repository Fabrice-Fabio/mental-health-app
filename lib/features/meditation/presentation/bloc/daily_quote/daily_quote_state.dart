import 'package:mental_health/features/meditation/domain/entities/daily_quote.dart';

abstract class DailyQuoteState {}

class DailyQuoteInitial extends DailyQuoteState{}

class DailyQuoteLoading extends DailyQuoteState{}

class DailyQuoteLoaded extends DailyQuoteState{
  final DailyQuote dailyQuote;

  DailyQuoteLoaded({required this.dailyQuote});
}

class DailyQuoteError extends DailyQuoteState{
  final String message;

  DailyQuoteError({required this.message});
}