import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> _toggle(String topic) async {
    final isSelected = _selected.contains(topic);

    if (isSelected) {
      _selected.remove(topic);
    } else {
      if (_selected.length < 5) {
        _selected.add(topic);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Max 5 topics allowed')),
        );
        return;
      }
    }

    setState(() {});
    widget.onTopicsChanged(_selected);

    // Update Firestore
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'selectedTopics': _selected});
    }
  }

  @override
  Widget build(BuildContext context) {
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
              'YOUR TOPICS',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontSize: Responsive.scaleText(context, 12),
              ),
            ),
            SizedBox(height: Responsive.scale(context, 16)),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.allTopics.length,
                itemBuilder: (context, index) {
                  final topic = widget.allTopics[index];
                  final isSelected = _selected.contains(topic);

                  return ListTile(
                    title: Text(
                      topic,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: Responsive.scaleText(context, 16),
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary,
                      size: Responsive.scale(context, 24),
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