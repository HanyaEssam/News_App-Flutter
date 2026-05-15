import 'package:flutter/material.dart';
import '../../core/widgets/background_color/app_background.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'INSIGHTLY',
                    style: textTheme.headlineLarge,
                  ),
                ),

                const SizedBox(height: 30),

                Text('displayLarge - DESIGN YOUR DAILY', style: textTheme.displayLarge),
                const SizedBox(height: 12),

                Text('displayMedium - Big Article Title', style: textTheme.displayMedium),
                const SizedBox(height: 12),

                Text('displaySmall - Profile Page Title', style: textTheme.displaySmall),
                const SizedBox(height: 20),

                Text('headlineMedium - Section Title', style: textTheme.headlineMedium),
                const SizedBox(height: 12),

                Text('headlineSmall - Article/Card Title', style: textTheme.headlineSmall),
                const SizedBox(height: 20),

                Text('titleLarge - JOIN INSIGHTLY', style: textTheme.titleLarge),
                const SizedBox(height: 12),

                Text('titleMedium - Settings Title / Chip', style: textTheme.titleMedium),
                const SizedBox(height: 12),

                Text('titleSmall - TECHNOLOGY / Category', style: textTheme.titleSmall),
                const SizedBox(height: 20),

                Text(
                  'bodyLarge - This is a long article paragraph. It should look readable and clean for the article details screen.',
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: 12),

                Text(
                  'bodyMedium - Subtitle or description text.',
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),

                Text('bodySmall - 12m ago • 6 min read', style: textTheme.bodySmall),
                const SizedBox(height: 20),

                Text('labelLarge - BUTTON TEXT', style: textTheme.labelLarge),
                const SizedBox(height: 12),

                Text('labelMedium - EMAIL ADDRESS', style: textTheme.labelMedium),
                const SizedBox(height: 12),

                Text('labelSmall - HOME SEARCH SAVED PROFILE', style: textTheme.labelSmall),
                const SizedBox(height: 30),

                const TextField(
                  decoration: InputDecoration(
                    labelText: 'EMAIL ADDRESS',
                    hintText: 'farida@gmail.com',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),

                const SizedBox(height: 16),

                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    hintText: 'Enter password',
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: Icon(Icons.visibility_off_outlined),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text('FilledButton - Sign In'),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('LOGOUT SESSION'),
                  ),
                ),

                const SizedBox(height: 16),

                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('TextButton - Create Account'),
                  ),
                ),

                const SizedBox(height: 16),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MINUTES SAVED',
                          style: textTheme.labelMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '452 m',
                          style: textTheme.displayMedium,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {},
                            child: const Text('CARD BUTTON'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}