import 'package:flutter/material.dart';
import 'package:m_commerce/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:m_commerce/features/common/ui/screens/main_layout.dart';

class SplashScreens extends StatefulWidget {
  static const String name = "/";

  const SplashScreens({super.key});

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  void initState() {
    _goToNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              AppLogoWidget(),
              Spacer(),
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacementNamed(context, MainLayout.name);
    }
  }
}
