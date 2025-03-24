import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';
import '../theme/colors.dart';

class CustomFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomFAB({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ResponsiveHelper.getAdaptiveValue(
        context: context,
        desktop: 24.0,
        mobile: 16.0,
      ),
      right: ResponsiveHelper.getAdaptiveValue(
        context: context,
        desktop: 24.0,
        mobile: 16.0,
      ),
      child: Container(
        width: ResponsiveHelper.getAdaptiveValue(
          context: context,
          desktop: 56.0,
          mobile: 48.0,
        ),
        height: ResponsiveHelper.getAdaptiveValue(
          context: context,
          desktop: 56.0,
          mobile: 48.0,
        ),
        decoration: BoxDecoration(
          color: AppColors.fabGreen,
          borderRadius: BorderRadius.circular(28.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(51),
              blurRadius: 5.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(28.0),
            onTap: onPressed,
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: ResponsiveHelper.getAdaptiveValue(
                  context: context,
                  desktop: 24.0,
                  mobile: 20.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
