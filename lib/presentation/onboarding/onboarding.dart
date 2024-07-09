import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset('assets/onboarding.png',fit: BoxFit.contain,),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 70,
                child: ElevatedButton(
                    onPressed: (){},
                    child: Text(
                        'Let us help you',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).focusColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
