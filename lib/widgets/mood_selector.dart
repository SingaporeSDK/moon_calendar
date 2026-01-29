import 'package:flutter/material.dart';
import '../utils/app_strings.dart';

class MoodSelector extends StatefulWidget {
  final Function(String) onMoodSelected;

  const MoodSelector({
    super.key,
    required this.onMoodSelected,
  });

  @override
  State<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  String? selectedMood;

  String _getString(String key) {
    String languageCode = Localizations.localeOf(context).languageCode;
    Map<String, String> strings = AppStrings.getStrings(languageCode);
    return strings[key] ?? key;
  }

  late List<Map<String, dynamic>> moods;

  @override
  void initState() {
    super.initState();
    _initializeMoods();
  }

  void _initializeMoods() {
    moods = [
      {'mood': 'excited', 'emoji': '🤩', 'key': 'excited'},
      {'mood': 'calm', 'emoji': '😌', 'key': 'calm'},
      {'mood': 'sad', 'emoji': '😢', 'key': 'sad'},
      {'mood': 'angry', 'emoji': '😠', 'key': 'angry'},
      {'mood': 'anxious', 'emoji': '😰', 'key': 'anxious'},
      {'mood': 'neutral', 'emoji': '😐', 'key': 'neutral'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple.shade400, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '🌙💭 ',
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getString('howAreYouFeeling'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _getString('moonCyclesAffect'),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            _getString('trackMoodMessage'),
            style: TextStyle(
              fontSize: 13,
              color: Colors.purple.shade200,
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.0,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: moods.map((moodData) {
              final mood = moodData['mood'];
              final emoji = moodData['emoji'];
              final key = moodData['key'];
              final label = _getString(key);
              final isSelected = selectedMood == mood;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedMood = mood;
                  });
                  widget.onMoodSelected(mood);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? Colors.purple.shade300 : Colors.grey.shade700,
                      width: isSelected ? 3 : 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: isSelected
                        ? Colors.purple.withValues(alpha: 0.3)
                        : Colors.grey.withValues(alpha: 0.1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        emoji,
                        style: const TextStyle(fontSize: 32),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? Colors.purple.shade300 : Colors.white70,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      if (isSelected)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Icon(
                            Icons.check_circle,
                            size: 14,
                            color: Colors.purple.shade300,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          if (selectedMood != null) ...[
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.purple.shade300, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _getString('moodRecorded'),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.purple.shade300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
