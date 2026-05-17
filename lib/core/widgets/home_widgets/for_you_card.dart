import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

// 1. Changed to a StatefulWidget
class ForYouCard extends StatefulWidget {
  final String label;
  final String title;
  final String description;
  final String time;
  final String readTime;
  final String source;

  const ForYouCard({
    super.key,
    required this.label,
    required this.title,
    required this.description,
    required this.time,
    required this.readTime,
    required this.source,
  });

  @override
  State<ForYouCard> createState() => _ForYouCardState();
}

class _ForYouCardState extends State<ForYouCard> {
  // 2. Added a variable to track if this specific article is saved
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Navigate to Article Details Page
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border.withOpacity(0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.lightbulb_outline, size: 16, color: AppColors.blue),
                    const SizedBox(width: 8),
                    Text(
                      widget.label.toUpperCase(), // Note: we use widget.label in a State class
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.blue,
                      ),
                    ),
                  ],
                ),

                // 3. The updated IconButton
                IconButton(
                  // Swap between filled and outlined icons
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                  ),
                  // Highlight the icon with your primary cyan color when saved
                  color: isSaved ? AppColors.primary : AppColors.mutedText,
                  onPressed: () {
                    // Tell Flutter to redraw the widget with the new state
                    setState(() {
                      isSaved = !isSaved; // Toggles between true and false
                    });

                    // Optional: Show a different message based on the state
                    ScaffoldMessenger.of(context).clearSnackBars(); // Clears old popups
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isSaved ? 'Article Saved!' : 'Article Removed from Saved'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),

              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/foryou_img.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(widget.time, style: Theme.of(context).textTheme.bodySmall),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('•', style: TextStyle(color: AppColors.border)),
                ),
                Text(widget.readTime, style: Theme.of(context).textTheme.bodySmall),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('•', style: TextStyle(color: AppColors.border)),
                ),
                Text(
                  widget.source.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}