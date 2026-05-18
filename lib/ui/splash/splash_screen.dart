import 'package:flutter/material.dart';
import '../../core/widgets/background_color/app_background.dart';
import 'package:news/ui/auth/login/login_screen.dart';


class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: AppBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// Logo
              Container(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 190,
                  height: 190,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 10),

              /// App Name
              const Text(
                'Insightly',
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Times New Roman',
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 8),

              /// Tagline
              const Text(
                'YOUR WORLD IN ONE PLACE',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 3,
                  color: Colors.white70,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}