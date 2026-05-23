import 'package:flutter/material.dart';
import '../../../core/models/article_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../services/scraper_services.dart';

class ArticleContent extends StatefulWidget {
  final ArticleModel article;

  const ArticleContent({super.key, required this.article});

  @override
  State<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  String _displayText = "";
  bool _isLoadingFullText = true;

  @override
  void initState() {
    super.initState();
    // Start with the short summary while we scrape
    _displayText = widget.article.content.replaceAll(RegExp(r'\[\+\d+ chars\]|\[-\d+ chars\]'), '...').trim();

    // Trigger the scraper
    _fetchFullText();
  }

  Future<void> _fetchFullText() async {
    // Attempt to scrape the full article
    final fullText = await ScraperService.scrapeArticle(widget.article.url);

    if (mounted) {
      setState(() {
        if (fullText != null && fullText.isNotEmpty) {
          _displayText = fullText; // Success! Swap summary for the massive full text
        }
        _isLoadingFullText = false; // Turn off the loading spinner
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category, Source, Date and Time Row
        Row(
          children: [
            Text(
              widget.article.category.toUpperCase(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: widget.article.categoryColor),
            ),
            const Spacer(),
            Text(
              "${widget.article.date}  •  ${widget.article.time}",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(widget.article.source.toUpperCase(), style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 24),

        // Main Title
        Text(widget.article.title, style: Theme.of(context).textTheme.displayMedium),
        const SizedBox(height: 24),

        // Article Image
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade900,
            image: widget.article.imageUrl.isNotEmpty
                ? DecorationImage(
              image: widget.article.imageUrl.startsWith('http')
                  ? NetworkImage(widget.article.imageUrl) as ImageProvider
                  : AssetImage(widget.article.imageUrl),
              fit: BoxFit.cover,
            )
                : null,
          ),
          child: widget.article.imageUrl.isEmpty
              ? const Icon(Icons.image_not_supported, color: Colors.white24, size: 50)
              : null,
        ),
        const SizedBox(height: 24),

        // 🔥 THE MAGIC: Show loading spinner or the scraped text!
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Column(
            key: ValueKey<bool>(_isLoadingFullText),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_isLoadingFullText) ...[
                Row(
                  children: [
                    const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                    const SizedBox(width: 12),
                    Text("Extracting full article...", style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.primary)),
                  ],
                ),
                const SizedBox(height: 16),
              ],
              Text(_displayText, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),

        const SizedBox(height: 32),
      ],
    );
  }
}