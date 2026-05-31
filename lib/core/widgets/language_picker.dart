import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/locale_provider.dart';

class LanguagePicker extends StatelessWidget {
  /// Shows the language picker bottom sheet
  static Future<void> show(BuildContext context) {
    final theme = Theme.of(context);

    return showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final localeProvider = Provider.of<LocaleProvider>(context);
        final currentLocale = localeProvider.locale?.languageCode ?? 'en';

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 8.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'CHOOSE LANGUAGE',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 16),
                _LanguageTile(
                  label: 'English (UK)',
                  code: 'en',
                  isSelected: currentLocale == 'en',
                ),
                _LanguageTile(
                  label: 'العربية (Arabic)',
                  code: 'ar',
                  isSelected: currentLocale == 'ar',
                ),
                _LanguageTile(
                  label: 'Español (Spanish)',
                  code: 'es',
                  isSelected: currentLocale == 'es',
                ),
                _LanguageTile(
                  label: 'Français (French)',
                  code: 'fr',
                  isSelected: currentLocale == 'fr',
                ),
                _LanguageTile(
                  label: 'Chinese (French)',
                  code: 'zh',
                  isSelected: currentLocale == 'zh',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// The compact button to put in the AppBar / top-right
  final bool showLabel;
  const LanguagePicker({super.key, this.showLabel = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final code = localeProvider.locale?.languageCode ?? 'en';

    return InkWell(
      onTap: () => LanguagePicker.show(context),
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.language, size: 18, color: theme.colorScheme.onSurface),
            const SizedBox(width: 6),
            Text(
              code.toUpperCase(),
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final String label;
  final String code;
  final bool isSelected;

  const _LanguageTile({
    required this.label,
    required this.code,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(label, style: theme.textTheme.titleMedium),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: theme.colorScheme.primary)
          : null,
      onTap: () {
        Provider.of<LocaleProvider>(
          context,
          listen: false,
        ).setLocale(Locale(code));
        Navigator.pop(context);
      },
    );
  }
}
