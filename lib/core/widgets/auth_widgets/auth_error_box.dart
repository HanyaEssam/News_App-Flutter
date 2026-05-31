import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';

class AuthErrorBox extends StatelessWidget {
  final String message;
  const AuthErrorBox({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(Responsive.scale(context, 12)),
      decoration: BoxDecoration(
        color: theme.colorScheme.error.withOpacity(0.12),
        borderRadius: BorderRadius.circular(Responsive.scale(context, 8)),
        border: Border.all(
          color: theme.colorScheme.error.withOpacity(0.5),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: theme.colorScheme.error,
            size: Responsive.scale(context, 18),
          ),
          SizedBox(width: Responsive.scale(context, 8)),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: theme.colorScheme.error,
                fontSize: Responsive.scaleText(context, 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}