import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

import '../../../core/models/article_model.dart';
import 'package:news/ui/article_details/article_details_screen.dart';


class TrendingCard extends StatelessWidget {
  const TrendingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailsScreen(
              // Passing the hardcoded data from this card into the Model
              article: ArticleModel(
                title: 'The Future of Cryptography in the Quantum Era',
                content: 'As the global race for computational supremacy accelerates, researchers are pioneering a new wave of computing that will redefine cybersecurity...', // Dummy full text
                category: 'Technology',
                categoryColor: AppColors.primary,
                source: 'TechCrunch',
                date: 'Oct 24, 2023', // Dummy date
                time: '12m ago',
                imageUrl: 'assets/images/trending_img.png',
                readtime: '6 min read',
              ),
            ),
          ),

        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.surface, // CHANGED
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // FIX: Replaced the gradient with an actual image!
            Container(
              height: 160,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                image: DecorationImage(
                  // Using a dummy network image for now so you can see it working.
                  // Replace with AssetImage('assets/images/your_pic.png') later!
                  image: AssetImage('assets/images/trending_img.png'),
                  fit: BoxFit.cover, // This makes the image fill the box perfectly
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.15), // CHANGED
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.5), // CHANGED
                          ),                        ),
                        child: Text(
                          'Technology',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text('12m ago', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'The Future of Cryptography in the Quantum Era',
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 16,
                            color: Theme.of(context).textTheme.bodySmall?.color, // CHANGED
                          ),                          const SizedBox(width: 6),
                          Text('TechCrunch', style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                      Text('6 min read', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}