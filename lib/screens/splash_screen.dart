import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'scoop .',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/splash_screen.png'),
                  radius: 100,
                ),
              ),
              Text(
                'All you need',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(10, 10),
                        blurRadius: 7,
                      ),
                    ]),
              ),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
