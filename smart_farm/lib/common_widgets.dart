import 'package:flutter/material.dart';
import 'styles.dart';

class InfoTag extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const InfoTag({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withAlpha((0.1 * 255).round()),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  final Widget child;
  final bool? isDark;
  final EdgeInsetsGeometry padding;

  const AppCard({
    super.key,
    required this.child,
    this.isDark,
    this.padding = const EdgeInsets.all(15),
  });

  @override
  Widget build(BuildContext context) {
    final bool dark = isDark ?? isDarkMode(context);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF121625) : Colors.white,
        borderRadius: BorderRadius.circular(kCardRadius),
        boxShadow: kCardShadows,
        border: Border.all(color: dark ? Colors.grey[800]! : Colors.grey[300]!),
      ),
      child: child,
    );
  }
}

class SensorControl extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget control;

  const SensorControl({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.control,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          control,
        ],
      ),
    );
  }
}
