import 'package:flutter/material.dart';
import '../theme/colors.dart';

class SettingsMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool showChevron;
  final VoidCallback onTap;
  final Color? iconColor;

  const SettingsMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.showChevron = false,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width > 640 ? 16.0 : 12.0,
          vertical: MediaQuery.of(context).size.width > 640 ? 12.0 : 10.0,
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(right: 16),
              child: Icon(icon, size: 24, color: iconColor),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize:
                      MediaQuery.of(context).size.width > 640 ? 16.0 : 14.0,
                ),
              ),
            ),
            if (showChevron)
              Icon(Icons.chevron_right, color: AppColors.iconGrey),
          ],
        ),
      ),
    );
  }
}
