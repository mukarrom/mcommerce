import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_commerce/app/app_colors.dart';
import 'package:m_commerce/app/app_constants.dart';
import 'package:m_commerce/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:m_commerce/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  static const String name = 'otp-verification';

  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Timer? timer;
  RxInt _remainingSeconds = AppConstants.remainingOtpTime.obs;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        _remainingSeconds--;
        if (_remainingSeconds < 1) {
          timer.cancel();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 134),
                const AppLogoWidget(),
                const SizedBox(height: 28),
                Text(
                  "Enter OTP Code",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  'A 4 digit OTP has been sent',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black54,
                      ),
                ),
                const SizedBox(
                  height: 16,
                ),
                PinCodeTextField(
                  length: 4,
                  obscureText: false,
                  autoDismissKeyboard: true,
                  animationType: AnimationType.fade,
                  mainAxisAlignment: MainAxisAlignment.center,
                  pinTheme: PinTheme(
                    fieldOuterPadding:
                        const EdgeInsets.symmetric(horizontal: 6),
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(6),
                    fieldHeight: 40,
                    fieldWidth: 40,
                    activeFillColor: AppColors.themeColor,
                    inactiveFillColor: Colors.white,
                    inactiveColor: AppColors.themeColor,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  // backgroundColor: Colors.blue.shade50,
                  enableActiveFill: true,

                  // errorAnimationController: errorController,
                  controller: _otpTEController,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    print(value);
                    // setState(() {
                    //   currentText = value;
                    // });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CompleteProfileScreen.name);
                  },
                  child: const Text("Next"),
                ),
                const SizedBox(
                  height: 28,
                ),
                Obx(() {
                  return Visibility(
                    visible: _remainingSeconds.value > 0,
                    child: Text.rich(
                      TextSpan(text: "This code will expire in ", children: [
                        TextSpan(
                          text: "${_remainingSeconds.value}s",
                          style: const TextStyle(
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                    ),
                  );
                }),
                Obx(
                  () => Visibility(
                    visible: _remainingSeconds.value < 1,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Resend Code",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }
}