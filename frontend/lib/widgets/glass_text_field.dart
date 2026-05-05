import 'package:flutter/material.dart';
import 'package:ratip/widgets/glass_container.dart';

class GlassTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Function(String)? onSubmitted;

  const GlassTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.controller,
    this.suffixIcon,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        GlassContainer(
          borderRadius: 16,
          blur: 10,
          opacity: 0.5,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              icon: Icon(icon, color: Theme.of(context).colorScheme.outline, size: 20),
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                  ),
              border: InputBorder.none,
              suffixIcon: suffixIcon,
            ),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
      ],
    );
  }
}
