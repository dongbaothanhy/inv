import 'package:flutter/material.dart';

class SettingsMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool showChevron;
  final VoidCallback onTap;
  final Color? iconColor;
  final bool isSelected;

  const SettingsMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.showChevron = false,
    required this.onTap,
    this.iconColor,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color:
            isSelected
                ? iconColor?.withAlpha(25) ?? Colors.blue.withAlpha(25)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border:
            isSelected
                ? Border.all(color: iconColor ?? Colors.blue, width: 1)
                : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                Icon(icon, color: iconColor ?? Colors.blue, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color:
                          isSelected
                              ? iconColor ?? Colors.blue
                              : Colors.black87,
                    ),
                  ),
                ),
                if (showChevron)
                  Icon(
                    Icons.keyboard_arrow_down,
                    color:
                        isSelected ? iconColor ?? Colors.blue : Colors.black54,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
