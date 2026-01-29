import 'package:flutter/material.dart';
import '../utils/moon_calculator.dart';
import '../utils/location_service.dart';
import '../utils/app_localization.dart';
import '../utils/mood_tracker.dart';
import '../widgets/language_switcher.dart';
import 'calendar_screen.dart';
import 'details_screen.dart';
import 'mood_tracking_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime selectedDate;
  late MoonPhase moonPhase;
  String? currentLocation = 'Getting location...';

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    moonPhase = MoonCalculator.calculateMoonPhase(selectedDate);
    _loadLocation();
    _initMoodTracker();
  }

  String _getLanguageCode() {
    final locale = Localizations.localeOf(context);
    return locale.languageCode;
  }

  void _initMoodTracker() async {
    await MoodTrackerService.init();
  }

  void _loadLocation() async {
    final location = await LocationService.getCurrentLocation();
    setState(() {
      currentLocation = location ?? 'Location not available';
    });
  }

  void _updateMoonPhase(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
      moonPhase = MoonCalculator.calculateMoonPhase(selectedDate);
    });
  }

  String _getString(String key) {
    return AppLocalization.getString(_getLanguageCode(), key);
  }

  Widget _buildNextMoonPhaseWidget() {
    final nextPhaseData = MoonCalculator.getDaysUntilNextPhase(selectedDate);
    final phaseName = nextPhaseData['phase'] as String;
    final daysUntil = nextPhaseData['days'] as int;
    
    // Emoji mapping for phases
    final phaseEmojis = {
      'New Moon': '🌑',
      'Full Moon': '🌕',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              phaseEmojis[phaseName] ?? '🌙',
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getString('nextMoonPhase'),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.amber.shade300,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  phaseName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$daysUntil ${_getString('daysUntil')}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.amber,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(_getString('appName')),
            Text(
              currentLocation ?? 'Getting location...',
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF0a0e27),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const LanguageSwitcher(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Next Moon Phase Information (moved from below)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber.shade300, width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.amber.withValues(alpha: 0.08),
                ),
                child: _buildNextMoonPhaseWidget(),
              ),
              const SizedBox(height: 40),

              // Moon Visualization
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.yellow.shade200,
                      Colors.yellow.shade800,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    moonPhase.emoji,
                    style: const TextStyle(fontSize: 100),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Moon Phase Information
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    Text(
                      moonPhase.phase,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Illumination Progress Bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Illumination',
                              style: TextStyle(color: Colors.white70),
                            ),
                            Text(
                              '${moonPhase.illumination.toStringAsFixed(1)}%',
                              style: const TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: moonPhase.illumination / 100,
                            minHeight: 10,
                            backgroundColor: Colors.grey.shade800,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.cyan.shade400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Marketing Text - Mood Tracking Encouragement
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple.shade300, width: 1),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.purple.withValues(alpha: 0.08),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getString('moodTrackingTitle'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _getString('moodTrackingDescription'),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Track Mood Button
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.cyan.shade900,
                      Colors.blue.shade800,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MoodTrackingPage(
                            currentMoonPhase: moonPhase,
                            currentDate: DateTime.now(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.mood, size: 24),
                    label: Text(
                      _getString('trackYourMood'),
                      style: const TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan.shade400,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CalendarScreen(
                            onDateSelected: _updateMoonPhase,
                            languageCode: _getLanguageCode(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.calendar_month),
                    label: Text(_getString('calendar')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            date: selectedDate,
                            moonPhase: moonPhase,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.info),
                    label: Text(_getString('details')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade700,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
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
}
