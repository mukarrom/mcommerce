import 'package:flutter/material.dart';
import 'package:m_commerce/app/app_colors.dart';

class CenterProgressIndicator extends StatelessWidget {
  const CenterProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.themeColor),
    );
  }
}
