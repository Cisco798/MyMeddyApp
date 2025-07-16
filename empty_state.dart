import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final double iconSize;
  final Color iconColor;
  final double messageFontSize;
  final EdgeInsets padding;

  const EmptyState({
    Key? key,
    required this.message,
    this.icon = Icons.inbox,
    this.actionLabel,
    this.onActionPressed,
    this.iconSize = 64.0,
    this.iconColor = Colors.grey,
    this.messageFontSize = 16.0,
    this.padding = const EdgeInsets.all(32.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),
            const SizedBox(height: 16.0),
            Text(
              message,
              style: TextStyle(
                fontSize: messageFontSize,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onActionPressed != null) ...[
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: onActionPressed,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 12.0,
                  ),
                ),
                child: Text(
                  actionLabel!,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}