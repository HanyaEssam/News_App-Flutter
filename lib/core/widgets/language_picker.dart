import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/locale_provider.dart';
import '../utils/responsive.dart';

class LanguagePicker extends StatelessWidget {
  static Future<void> show(BuildContext context) {
    final theme = Theme.of(context);

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final localeProvider = Provider.of<LocaleProvider>(context);
        final currentLocale = localeProvider.locale?.languageCode ?? 'en';

        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: Responsive.scale(context, 20),
                horizontal: Responsive.scale(context, 8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'CHOOSE LANGUAGE',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                      fontSize: Responsive.scaleText(context, 11),
                    ),
                  ),
                  SizedBox(height: Responsive.scale(context, 16)),
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
                    label: '中文 (Chinese)',
                    code: 'zh',
                    isSelected: currentLocale == 'zh',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  final bool showLabel;
  const LanguagePicker({super.key, this.showLabel = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final code = localeProvider.locale?.languageCode ?? 'en';

    return InkWell(
      onTap: () => LanguagePicker.show(context),
      borderRadius: BorderRadius.circular(Responsive.scale(context, 20)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.scale(context, 12),
          vertical: Responsive.scale(context, 8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.language,
              size: Responsive.scale(context, 18),
              color: theme.colorScheme.onSurface,
            ),
            SizedBox(width: Responsive.scale(context, 6)),
            Text(
              code.toUpperCase(),
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: Responsive.scaleText(context, 11),
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
      title: Text(
        label,
        style: theme.textTheme.titleMedium?.copyWith(
          fontSize: Responsive.scaleText(context, 16),
        ),
      ),
      trailing: isSelected
          ? Icon(
        Icons.check_circle,
        color: theme.colorScheme.primary,
        size: Responsive.scale(context, 22),
      )
          : null,
      onTap: () {
        Provider.of<LocaleProvider>(context, listen: false)
            .setLocale(Locale(code));
        Navigator.pop(context);
      },
    );
  }
}