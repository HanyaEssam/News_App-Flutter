import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import '../auth_widgets/auth_widgets.dart';

class NameEditorSection extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onUpdate;

  const NameEditorSection({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthTextField(
          label: 'FULL NAME',
          hintText: 'Your name',
          controller: controller,
        ),
        SizedBox(height: Responsive.scale(context, 12)),
        Align(
          alignment: Alignment.centerRight,
          child: FilledButton(
            onPressed: isLoading ? null : onUpdate,
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.scale(context, 24),
                vertical: Responsive.scale(context, 12),
              ),
            ),
            child: isLoading
                ? SizedBox(
              height: Responsive.scale(context, 16),
              width: Responsive.scale(context, 16),
              child: const CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2,
              ),
            )
                : Text(
              'UPDATE NAME',
              style: TextStyle(
                fontSize: Responsive.scaleText(context, 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}