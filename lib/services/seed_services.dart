// lib/services/seed_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class SeedService {
  static final _db = FirebaseFirestore.instance;

  static Future<void> seedArticles() async {
    final articles = [
      {
        'title': 'Apple Announces Vision Pro 2 with Major Upgrades',
        'content': 'Apple has unveiled the second generation of its Vision Pro headset, featuring a lighter design, improved battery life, and a new M4 chip. The device is expected to ship in late 2025...',
        'category': 'Technology',
        'source': 'TechCrunch',
        'date': '2025-05-20',
        'time': '09:00 AM',
        'imageUrl': 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800',
        'categoryColorHex': '#2196F3',
        'readtime': '4 min read',
        'isTrending': true,
      },
      {
        'title': 'Global Markets Rally as Inflation Data Improves',
        'content': 'Stock markets around the world surged on Wednesday after new data showed inflation cooling faster than expected. The S&P 500 gained 2.1% while European indices followed suit...',
        'category': 'Business',
        'source': 'Reuters',
        'date': '2025-05-20',
        'time': '11:30 AM',
        'imageUrl': 'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800',
        'categoryColorHex': '#4CAF50',
        'readtime': '3 min read',
        'isTrending': true,
      },
      {
        'title': 'Scientists Discover New Earth-Like Planet',
        'content': 'NASA researchers have identified a potentially habitable planet 40 light-years from Earth. The planet, named Kepler-452c, shares many similarities with Earth including liquid water...',
        'category': 'Science',
        'source': 'NASA',
        'date': '2025-05-19',
        'time': '03:00 PM',
        'imageUrl': 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=800',
        'categoryColorHex': '#9C27B0',
        'readtime': '5 min read',
        'isTrending': true,
      },
      {
        'title': 'Champions League Final: Real Madrid vs. Manchester City',
        'content': 'The highly anticipated Champions League final takes place this weekend in Munich. Real Madrid and Manchester City face off in what experts are calling the match of the decade...',
        'category': 'Sports',
        'source': 'ESPN',
        'date': '2025-05-20',
        'time': '07:00 AM',
        'imageUrl': 'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?w=800',
        'categoryColorHex': '#F44336',
        'readtime': '3 min read',
        'isTrending': false,
      },
      {
        'title': 'New Study Links Mediterranean Diet to Longer Life',
        'content': 'A comprehensive 10-year study following 50,000 participants confirms that the Mediterranean diet significantly reduces risk of heart disease, diabetes, and certain cancers...',
        'category': 'Health',
        'source': 'WHO',
        'date': '2025-05-18',
        'time': '12:00 PM',
        'imageUrl': 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=800',
        'categoryColorHex': '#FF9800',
        'readtime': '6 min read',
        'isTrending': false,
      },
      {
        'title': 'Top 10 Summer Travel Destinations for 2025',
        'content': 'From the pristine beaches of the Maldives to the cultural richness of Kyoto, travel experts have compiled the most sought-after destinations this summer season...',
        'category': 'Travel',
        'source': 'Lonely Planet',
        'date': '2025-05-17',
        'time': '08:00 AM',
        'imageUrl': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
        'categoryColorHex': '#00BCD4',
        'readtime': '7 min read',
        'isTrending': false,
      },
      // Add more articles per category as needed...
    ];

    final batch = _db.batch();
    for (final article in articles) {
      final ref = _db.collection('articles').doc();
      batch.set(ref, article);
    }
    await batch.commit();
    print('✅ Articles seeded successfully');
  }
}