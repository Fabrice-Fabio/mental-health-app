import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/core/theme.dart';
import 'package:mental_health/features/meditation/data/datasources/meditation_remote_datasource.dart';
import 'package:mental_health/features/meditation/data/reposiroties/meditation_repository_impl.dart';
import 'package:mental_health/features/meditation/domain/usescases/get_daily_quote.dart';
import 'package:mental_health/features/meditation/domain/usescases/get_mood_message.dart';
import 'package:mental_health/features/meditation/presentation/bloc/daily_quote/daily_quote_bloc.dart';
import 'package:mental_health/features/meditation/presentation/bloc/daily_quote/daily_quote_event.dart';
import 'package:mental_health/features/meditation/presentation/bloc/mood_message/mood_message_bloc.dart';
import 'package:mental_health/features/music/data/datasources/song_remote_datasource.dart';
import 'package:mental_health/features/music/data/repository/song_repository_impl.dart';
import 'package:mental_health/features/music/domain/usecases/get_all_songs.dart';
import 'package:mental_health/features/music/presentation/bloc/song_bloc.dart';
import 'package:mental_health/features/music/presentation/bloc/song_event.dart';
import 'package:mental_health/presentation/bottomNavBar/bloc/navigation_bloc.dart';
import 'package:mental_health/presentation/homePage/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:mental_health/presentation/onboarding/onboarding.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => NavigationBloc(),
          ),
          BlocProvider(
              create: (context) => di.sl<SongBloc>()..add(FetchSongs())
          ),
          BlocProvider(
            create: (context)=> di.sl<DailyQuoteBloc>()..add(FetchDailyQuote()),
          ),
          BlocProvider(
              create: (context)=> di.sl<MoodMessageBloc>()
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          home: OnboardingScreen(),
        )
    );
  }
}
