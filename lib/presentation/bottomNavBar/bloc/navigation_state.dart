abstract class NavigationState {}

class NavigationChanged extends NavigationState {
  final int index;
  NavigationChanged({required this.index});
}