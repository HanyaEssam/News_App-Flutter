import 'package:flutter/material.dart';
import '../../../core/models/article_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
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
    _displayText = widget.article.content
        .replaceAll(RegExp(r'\[\+\d+ chars\]|\[-\d+ chars\]'), '...')
        .trim();
    _fetchFullText();
  }

  Future<void> _fetchFullText() async {
    final fullText = await ScraperService.scrapeArticle(widget.article.url);
    if (mounted) {
      setState(() {
        if (fullText != null && fullText.isNotEmpty) {
          _displayText = fullText;
        }
        _isLoadingFullText = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.article.category.toUpperCase(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: widget.article.categoryColor,
                fontSize: Responsive.scaleText(context, 12),
              ),
            ),
            const Spacer(),
            Text(
              "${widget.article.date}  •  ${widget.article.time}",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: Responsive.scaleText(context, 10),
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.scale(context, 8)),
        Text(
          widget.article.source.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontSize: Responsive.scaleText(context, 10),
          ),
        ),
        SizedBox(height: Responsive.scale(context, 24)),
        Text(
          widget.article.title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontSize: Responsive.scaleText(context, 28),
          ),
        ),
        SizedBox(height: Responsive.scale(context, 24)),
        Container(
          height: Responsive.scale(context, 220),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Responsive.scale(context, 20)),
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
              ? Icon(
            Icons.image_not_supported,
            color: Colors.white24,
            size: Responsive.scale(context, 50),
          )
              : null,
        ),
        SizedBox(height: Responsive.scale(context, 24)),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Column(
            key: ValueKey<bool>(_isLoadingFullText),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_isLoadingFullText) ...[
                Row(
                  children: [
                    SizedBox(
                      height: Responsive.scale(context, 16),
                      width: Responsive.scale(context, 16),
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: Responsive.scale(context, 12)),
                    Text(
                      "Extracting full article...",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                        fontSize: Responsive.scaleText(context, 10),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.scale(context, 16)),
              ],
              Text(
                _displayText,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: Responsive.scaleText(context, 16),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Responsive.scale(context, 32)),
      ],
    );
  }
}