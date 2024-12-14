import 'package:flutter/material.dart';
import 'package:m_commerce/app/app_theme_data.dart';
import 'package:m_commerce/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:m_commerce/features/auth/ui/screens/email_verification_screen.dart';
import 'package:m_commerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:m_commerce/features/auth/ui/screens/splash_screens.dart';

class MCommerceApp extends StatelessWidget {
  const MCommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      themeMode: ThemeMode.light,
      routes: <String, WidgetBuilder>{
        "/": (BuildContext context) => const SplashScreens(),
        EmailVerificationScreen.name: (BuildContext context) =>
            const EmailVerificationScreen(),
        OtpVerificationScreen.name: (BuildContext context) =>
            const OtpVerificationScreen(),
        CompleteProfileScreen.name: (BuildContext context) =>
            const CompleteProfileScreen(),
      },
    );
  }
}
