abstract class MoodMessageEvent{}

class FetchMoodMessage extends MoodMessageEvent{
  final String mood;

  FetchMoodMessage(this.mood);
}

class ResetMoodMessage extends MoodMessageEvent{}

