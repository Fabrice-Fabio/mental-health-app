abstract class NavigationEvent {}

class NavigateTo extends NavigationEvent {
  final int index;
  NavigateTo({required this.index});
}