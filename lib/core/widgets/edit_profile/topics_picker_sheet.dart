import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';

class TopicsPickerSheet extends StatefulWidget {
  final List<String> allTopics;
  final List<String> selectedTopics;
  final ValueChanged<List<String>> onTopicsChanged;

  const TopicsPickerSheet({
    super.key,
    required this.allTopics,
    required this.selectedTopics,
    required this.onTopicsChanged,
  });

  static Future<void> show(
    BuildContext context, {
    required List<String> allTopics,
    required List<String> selectedTopics,
    required ValueChanged<List<String>> onTopicsChanged,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Responsive.scale(context, 24)),
        ),
      ),
      builder: (_) => TopicsPickerSheet(
        allTopics: allTopics,
        selectedTopics: selectedTopics,
        onTopicsChanged: onTopicsChanged,
      ),
    );
  }

  @override
  State<TopicsPickerSheet> createState() => _TopicsPickerSheetState();
}

class _TopicsPickerSheetState extends State<TopicsPickerSheet> {
  late List<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.selectedTopics);
  }

  // Translation helper for topic titles
  String _getTranslatedTopic(BuildContext context, String topic) {
    final loc = AppLocalizations.of(context)!;
    switch (topic.toLowerCase()) {
      case 'technology':
        return loc.tech;
      case 'sports':
        return loc.sports;
      case 'politics':
        return loc.politics;
      case 'business':
        return loc.business;
      case 'health':
        return loc.health;
      case 'science':
        return loc.science;
      case 'travel':
        return loc.travel;
      case 'entertainment':
        return loc.entertainment;
      case 'general':
        return loc.general;
      default:
        return topic;
    }
  }

  Future<void> _toggle(String topic) async {
    final isSelected = _selected.contains(topic);
    if (isSelected) {
      _selected.remove(topic);
    } else if (_selected.length < 5) {
      _selected.add(topic);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Max 5 topics allowed')));
      return;
    }
    setState(() {});
    widget.onTopicsChanged(_selected);
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {'selectedTopics': _selected},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // 🔥 Access translations
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Responsive.scale(context, 20),
          horizontal: Responsive.scale(context, 8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              loc.yourTopicsTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ), // 🔥 Translated
            SizedBox(height: Responsive.scale(context, 16)),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.allTopics.length,
                itemBuilder: (context, index) {
                  final topic = widget.allTopics[index];
                  return ListTile(
                    title: Text(
                      _getTranslatedTopic(context, topic),
                    ), // 🔥 Translated
                    trailing: _selected.contains(topic)
                        ? Icon(
                            Icons.check_circle,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : null,
                    onTap: () => _toggle(topic),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
