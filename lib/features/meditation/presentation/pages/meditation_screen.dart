import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/core/theme.dart';
import 'package:mental_health/features/meditation/presentation/bloc/meditation_bloc.dart';
import 'package:mental_health/features/meditation/presentation/bloc/meditation_event.dart';
import 'package:mental_health/features/meditation/presentation/bloc/meditation_state.dart';
import 'package:mental_health/features/meditation/presentation/widgets/feeling_button.dart';
import 'package:mental_health/features/meditation/presentation/widgets/task_card.dart';

class MeditationScreen extends StatelessWidget {
  const MeditationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DefaultColors.white,
        elevation: 0,
        leading: Image.asset('assets/menu_burger.png'),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile.png'),
          ),
          SizedBox(width: 16,)
        ],
      ),
      backgroundColor: DefaultColors.white,
      body: BlocBuilder<MeditationBloc, MeditationState>(
        builder: (context, state) {
          if(state is MeditationLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          else if (state is DailyQuoteLoaded) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Welcome back, Sabrina!',
                        style: Theme.of(context).textTheme.titleLarge
                    ),
                    SizedBox(height: 32,),
                    Text(
                      'How are you feeling today ?',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FeelingButton(label: 'Happy', image: 'assets/happy.png', color: DefaultColors.pink,
                            onTap: (){
                              context.read<MeditationBloc>().add(FetchMoodMessage('Today i am happy'));
                            }),
                        FeelingButton(label: 'Calm', image: 'assets/calm.png', color: DefaultColors.purple,
                            onTap: (){
                              context.read<MeditationBloc>().add(FetchMoodMessage('Today i am calm'));
                            }),
                        FeelingButton(label: 'Relax', image: 'assets/relax.png', color: DefaultColors.orange,
                            onTap: (){
                              context.read<MeditationBloc>().add(FetchMoodMessage('Today i am relax'));
                            }),
                        FeelingButton(label: 'Focus', image: 'assets/focus.png', color: DefaultColors.lightteal,
                            onTap: (){
                              context.read<MeditationBloc>().add(FetchMoodMessage('Today i need to be focus but feel like i am missing something'));
                            })
                      ],
                    ),
                    SizedBox(height: 24,),
                    Text(
                      'Today\'s Task',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 16,),
                    TaskCard(
                      title: 'Morning',
                      description: state.dailyQuote.morningQuote,
                      color: DefaultColors.task1,
                    ),
                    SizedBox(height: 16,),
                    TaskCard(
                      title: 'Noon',
                      description: state.dailyQuote.noonQuote,
                      color: DefaultColors.task2,
                    ),
                    SizedBox(height: 16,),
                    TaskCard(
                      title: 'Evening',
                      description: state.dailyQuote.eveningQuote,
                      color: DefaultColors.task3,
                    )
                  ],
                ),
              ),
            );
          }
          else if(state is MoodMessageLoaded) {
            showDialog(context: context,
                builder: (context)=>AlertDialog(
                  title: Text('My message for you : ', style: Theme.of(context).textTheme.labelSmall,),
                  content: Text(state.moodMessage.text),
                  actions: [
                    TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Ok', style: Theme.of(context).textTheme.labelSmall,))
                  ],
                ));
            return Container();
          }
          else if(state is MeditationError) {
            return Center(child: Text(state.message, style: Theme.of(context).textTheme.labelSmall,),);
          }
          else {
            return Center(child: Text('No data found', style: Theme.of(context).textTheme.labelSmall,),);
          }
        },
      ),
    );
  }
}
