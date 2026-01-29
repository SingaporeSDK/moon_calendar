import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MoodEntry {
  final DateTime timestamp;
  final String mood; // excited, calm, sad, angry, anxious, neutral
  final String? energy; // energetic, normal, tired, lethargic
  final String? productivity; // excited_finish, focused, procrastinating, delayed, not_working
  final String moonPhase;
  final double illumination;
  final String? notes;

  MoodEntry({
    required this.timestamp,
    required this.mood,
    required this.moonPhase,
    required this.illumination,
    this.energy,
    this.productivity,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'mood': mood,
      'energy': energy,
      'productivity': productivity,
      'moonPhase': moonPhase,
      'illumination': illumination,
      'notes': notes,
    };
  }

  factory MoodEntry.fromJson(Map<String, dynamic> json) {
    return MoodEntry(
      timestamp: DateTime.parse(json['timestamp']),
      mood: json['mood'],
      energy: json['energy'],
      productivity: json['productivity'],
      moonPhase: json['moonPhase'],
      illumination: json['illumination'],
      notes: json['notes'],
    );
  }
}

class MoodTrackerService {
  static const String _storageKey = 'mood_entries';
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveMoodEntry(MoodEntry entry) async {
    final entries = await getMoodEntries();
    entries.add(entry);
    
    final jsonList = entries.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs.setStringList(_storageKey, jsonList);
  }

  static Future<List<MoodEntry>> getMoodEntries() async {
    final jsonList = _prefs.getStringList(_storageKey) ?? [];
    return jsonList.map((json) => MoodEntry.fromJson(jsonDecode(json))).toList();
  }

  static Future<List<MoodEntry>> getMoodEntriesForLast7Days() async {
    final entries = await getMoodEntries();
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    return entries.where((e) => e.timestamp.isAfter(sevenDaysAgo)).toList();
  }

  static Future<MoodEntry?> getLastMoodEntry() async {
    final entries = await getMoodEntries();
    if (entries.isEmpty) return null;
    return entries.last;
  }

  static Future<Map<String, int>> getMoodStats() async {
    final entries = await getMoodEntries();
    final stats = <String, int>{};
    
    for (final entry in entries) {
      stats[entry.mood] = (stats[entry.mood] ?? 0) + 1;
    }
    
    return stats;
  }

  static Future<String?> getMostCommonMoodDuringPhase(String moonPhase) async {
    final entries = await getMoodEntries();
    final phaseEntries = entries.where((e) => e.moonPhase == moonPhase).toList();
    
    if (phaseEntries.isEmpty) return null;
    
    final moodCounts = <String, int>{};
    for (final entry in phaseEntries) {
      moodCounts[entry.mood] = (moodCounts[entry.mood] ?? 0) + 1;
    }
    
    var maxCount = 0;
    String? mostCommon;
    moodCounts.forEach((mood, count) {
      if (count > maxCount) {
        maxCount = count;
        mostCommon = mood;
      }
    });
    
    return mostCommon;
  }
}
