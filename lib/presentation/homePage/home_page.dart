import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/features/meditation/presentation/pages/meditation_screen.dart';
import 'package:mental_health/features/music/presentation/pages/playlist_screen.dart';
import 'package:mental_health/presentation/bottomNavBar/bloc/navigation_bloc.dart';
import 'package:mental_health/presentation/bottomNavBar/bloc/navigation_state.dart';
import 'package:mental_health/presentation/bottomNavBar/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<Widget> pages = [
    MeditationScreen(),
    PlaylistScreen()
  ];

  BottomNavigationBarItem createBottomNavItem(
      {required String assetName, required bool isActive, required BuildContext context}){
    return BottomNavigationBarItem(
        icon: Image.asset(
          assetName,
          height: 45,
          color: isActive ? Theme.of(context).focusColor : Theme.of(context).primaryColor,),
        label: ''
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state){
          if(state is NavigationChanged){
            return pages[state.index];
          }
          return pages[0];
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          int currentIndex = 0;
          if(state is NavigationChanged){
            currentIndex = state.index;
          }

          final List<BottomNavigationBarItem> bottomNavItems = [
            createBottomNavItem(
                assetName: 'assets/menu_home.png',
                isActive: currentIndex == 0,
                context: context
            ),
            createBottomNavItem(
                assetName: 'assets/menu_songs.png',
                isActive: currentIndex == 1,
                context: context
            ),
          ];

          return BottomNavBar(
            items: bottomNavItems,
            currentIndex: currentIndex,
          );
        },
      ),
    );
  }
}
