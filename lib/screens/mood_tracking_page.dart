import 'package:flutter/material.dart';
import '../utils/moon_calculator.dart';
import '../utils/mood_tracker.dart';
import '../utils/app_strings.dart';

class MoodTrackingPage extends StatefulWidget {
  final MoonPhase? currentMoonPhase;
  final DateTime? currentDate;

  const MoodTrackingPage({
    super.key,
    this.currentMoonPhase,
    this.currentDate,
  });

  @override
  State<MoodTrackingPage> createState() => _MoodTrackingPageState();
}

class _MoodTrackingPageState extends State<MoodTrackingPage> {
  int _currentStep = 0;
  String? _selectedEmotion;
  String? _selectedEnergy;
  String? _selectedProductivity;

  String _getString(String key) {
    String languageCode = Localizations.localeOf(context).languageCode;
    Map<String, String> strings = AppStrings.getStrings(languageCode);
    return strings[key] ?? key;
  }

  final List<Map<String, dynamic>> emotions = [
    {'key': 'excited', 'emoji': '🤩'},
    {'key': 'calm', 'emoji': '😌'},
    {'key': 'sad', 'emoji': '😢'},
    {'key': 'angry', 'emoji': '😠'},
    {'key': 'anxious', 'emoji': '😰'},
    {'key': 'neutral', 'emoji': '😐'},
  ];

  final List<Map<String, dynamic>> energyLevels = [
    {'key': 'energetic', 'emoji': '⚡', 'value': 'energetic'},
    {'key': 'normal', 'emoji': '😊', 'value': 'normal'},
    {'key': 'tired', 'emoji': '😴', 'value': 'tired'},
    {'key': 'lethargic', 'emoji': '🪫', 'value': 'lethargic'},
  ];

  final List<Map<String, dynamic>> productivityModes = [
    {'key': 'excited_finish', 'emoji': '🚀', 'value': 'excited_finish'},
    {'key': 'focused', 'emoji': '🎯', 'value': 'focused'},
    {'key': 'procrastinating', 'emoji': '⏳', 'value': 'procrastinating'},
    {'key': 'delayed', 'emoji': '😒', 'value': 'delayed'},
    {'key': 'not_working', 'emoji': '🏖️', 'value': 'not_working'},
  ];

  void _saveMood() async {
    if (_selectedEmotion == null || _selectedEnergy == null || _selectedProductivity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_getString('pleaseSelectAll'))),
      );
      return;
    }

    final date = widget.currentDate ?? DateTime.now();
    final phase = widget.currentMoonPhase;
    
    if (phase == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_getString('errorLoadingMoonData'))),
      );
      return;
    }

    final entry = MoodEntry(
      timestamp: date,
      mood: _selectedEmotion!,
      energy: _selectedEnergy!,
      productivity: _selectedProductivity!,
      moonPhase: phase.phase,
      illumination: phase.illumination,
    );

    await MoodTrackerService.saveMoodEntry(entry);

    if (!mounted) return;
    Navigator.pop(context);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_getString('moodSavedSuccess')),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getString('trackYourMood')),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF0a0e27),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step Indicator
              _buildStepIndicator(),
              const SizedBox(height: 30),

              // Step Content
              if (_currentStep == 0) _buildEmotionStep(),
              if (_currentStep == 1) _buildEnergyStep(),
              if (_currentStep == 2) _buildProductivityStep(),

              const SizedBox(height: 30),

              // Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_currentStep > 0)
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() => _currentStep--);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: Text(_getString('back')),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade700,
                      ),
                    ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_currentStep < 2) {
                        setState(() => _currentStep++);
                      } else {
                        _saveMood();
                      }
                    },
                    icon: Icon(_currentStep < 2 ? Icons.arrow_forward : Icons.check),
                    label: Text(_currentStep < 2 ? _getString('next') : _getString('save')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${_getString('step')} ${_currentStep + 1}/3',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: (_currentStep + 1) / 3,
            minHeight: 6,
            backgroundColor: Colors.grey.shade800,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.purple.shade400),
          ),
        ),
      ],
    );
  }

  Widget _buildEmotionStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getString('howAreYouFeeling'),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 1.1,
          children: emotions.map((emotion) {
            final key = emotion['key'];
            final emoji = emotion['emoji'];
            final label = _getString(key);
            final isSelected = _selectedEmotion == key;

            return GestureDetector(
              onTap: () {
                setState(() => _selectedEmotion = key);
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
                    const SizedBox(height: 8),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: isSelected ? Colors.purple.shade300 : Colors.white70,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildEnergyStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getString('yourEnergyLevel'),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 1.3,
          children: energyLevels.map((energy) {
            final key = energy['key'];
            final emoji = energy['emoji'];
            final label = _getString(key);
            final isSelected = _selectedEnergy == key;

            return GestureDetector(
              onTap: () {
                setState(() => _selectedEnergy = key);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.blue.shade300 : Colors.grey.shade700,
                    width: isSelected ? 3 : 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected
                      ? Colors.blue.withValues(alpha: 0.3)
                      : Colors.grey.withValues(alpha: 0.1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      emoji,
                      style: const TextStyle(fontSize: 36),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.blue.shade300 : Colors.white70,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildProductivityStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getString('workProductivityStatus'),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: productivityModes.map((mode) {
            final key = mode['key'];
            final emoji = mode['emoji'];
            final label = _getString(key);
            final isSelected = _selectedProductivity == key;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: GestureDetector(
                onTap: () {
                  setState(() => _selectedProductivity = key);
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? Colors.green.shade300 : Colors.grey.shade700,
                      width: isSelected ? 3 : 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: isSelected
                        ? Colors.green.withValues(alpha: 0.2)
                        : Colors.grey.withValues(alpha: 0.05),
                  ),
                  child: Row(
                    children: [
                      Text(
                        emoji,
                        style: const TextStyle(fontSize: 32),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected ? Colors.green.shade300 : Colors.white70,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: Colors.green.shade300,
                          size: 24,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
