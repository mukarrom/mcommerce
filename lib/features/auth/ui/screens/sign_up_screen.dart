import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_commerce/app/app_colors.dart';
import 'package:m_commerce/features/auth/ui/controllers/sign_up_controller.dart';
import 'package:m_commerce/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:m_commerce/features/auth/ui/widgets/app_logo_widget.dart';
import 'package:m_commerce/features/common/ui/widgets/snack_bar_message.dart';

class SignUpScreen extends StatefulWidget {
  static const String name = 'complete-profile';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // {
  // "first_name": "Mukarrom",
  // "last_name": "Hosain",
  // "email": "test1@yopmail.com",
  // "password": "123456",
  // "phone": "01754658781",
  // "city": "Dhaka"
  // }
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const AppLogoWidget(
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 28),
              Text(
                "Sign Up",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'Get started with us with your details',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                    ),
              ),
              const SizedBox(height: 16),
              _buildForm(),
              const SizedBox(height: 16),
              GetBuilder<SignUpController>(builder: (controller) {
                if (controller.isLoading) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () => _signUp(),
                  child: const Text("Signup"),
                );
              }),
              const SizedBox(height: 16),
              _buildSignInSection(Theme.of(context).textTheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // First Name
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _firstNameTEController,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return "Please enter your first name";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "First Name",
            ),
          ),
          const SizedBox(height: 16),

          // Last Name
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _lastNameTEController,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return "Please enter your last name";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Last Name",
            ),
          ),
          const SizedBox(height: 16),

          // email address
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _emailTEController,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return "Please enter your email address";
              }
              if (EmailValidator.validate(value!) == false) {
                return "Please Enter your valid email";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Email",
            ),
          ),
          const SizedBox(height: 16),

          // password
          TextFormField(
            obscureText: true,
            obscuringCharacter: '*',
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _passwordTEController,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return "Please enter your city name";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Password",
            ),
          ),
          const SizedBox(height: 16),

          // phone
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _phoneTEController,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return "Please enter your phone number";
              }
              if (RegExp(r'^(?:\+88|88)?(01[3-9]\d{8})$').hasMatch(value!) ==
                  false) {
                return "Please Enter your valid phone number";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Phone",
            ),
          ),
          const SizedBox(height: 16),

          // City
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _cityTEController,
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return "Please enter your city name";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "City",
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> body = {
        "first_name": _firstNameTEController.text.trim(),
        "last_name": _lastNameTEController.text.trim(),
        "email": _emailTEController.text.trim(),
        "password": _passwordTEController.text.trim(),
        "phone": _phoneTEController.text.trim(),
        "city": _cityTEController.text.trim(),
      };
      bool isSuccess = await Get.find<SignUpController>().signUp(body);
      if (mounted) {
        if (isSuccess) {
          Navigator.pushNamed(
            context,
            OtpVerificationScreen.name,
            arguments: _emailTEController.text.trim(),
          );
        } else {
          showSnackBarMessage(context, "Something went wrong", true);
        }
      }
    }
  }

  Widget _buildSignInSection(TextTheme textTheme) {
    return Center(
      child: Column(
        children: [
          // TextButton(
          //   onPressed: () => Get.toNamed(SignInScreen.name),
          //   child: const Text(
          //     'Forgot Password?',
          //     style: TextStyle(
          //       color: Colors.grey,
          //     ),
          //   ),
          // ),
          RichText(
            text: TextSpan(
              text: 'Already have an account? ',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: ' Login',
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppColors.themeColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _phoneTEController.dispose();
    _cityTEController.dispose();
    super.dispose();
  }
}
