import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/moon_calculator.dart';
import '../utils/app_strings.dart';

class DetailsScreen extends StatefulWidget {
  final DateTime date;
  final MoonPhase moonPhase;

  const DetailsScreen({
    super.key,
    required this.date,
    required this.moonPhase,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String _getString(String key) {
    String languageCode = Localizations.localeOf(context).languageCode;
    Map<String, String> strings = AppStrings.getStrings(languageCode);
    return strings[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    double julianDay = MoonCalculator.dateToJulianDay(widget.date);
    double daysSinceNewMoon =
        (julianDay - MoonCalculator.knownNewMoon) % MoonCalculator.lunarMonth;
    int daysUntilNextFullMoon = (MoonCalculator.lunarMonth ~/ 2 - daysSinceNewMoon).toInt();
    if (daysUntilNextFullMoon < 0) {
      daysUntilNextFullMoon += MoonCalculator.lunarMonth.toInt();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_getString('moonDetails')),
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
              // Date Information
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade900,
                      Colors.indigo.shade900,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getString('selectedDate'),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          DateFormat('EEEE, MMMM d, yyyy').format(widget.date),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.moonPhase.emoji,
                      style: const TextStyle(fontSize: 50),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // Phase Information Section
              _buildDetailSection(
                title: _getString('moonPhaseInformation'),
                children: [
                  _buildDetailItem(
                    label: _getString('phaseName'),
                    value: widget.moonPhase.phase,
                  ),
                  const SizedBox(height: 15),
                  _buildDetailItem(
                    label: _getString('illumination'),
                    value: '${widget.moonPhase.illumination.toStringAsFixed(2)}%',
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Illumination Visualization
              _buildDetailSection(
                title: _getString('illuminationVisualization'),
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade900,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background illumination bar
                        Positioned(
                          left: 0,
                          right: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: widget.moonPhase.illumination / 100,
                              minHeight: 100,
                              backgroundColor: Colors.grey.shade800,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.cyan.shade400,
                              ),
                            ),
                          ),
                        ),
                        // Percentage text
                        Text(
                          '${widget.moonPhase.illumination.toStringAsFixed(1)}%',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Lunar Cycle Information
              _buildDetailSection(
                title: _getString('lunarCycleInformation'),
                children: [
                  _buildDetailItem(
                    label: _getString('daysSinceNewMoon'),
                    value: daysSinceNewMoon.toStringAsFixed(1),
                  ),
                  const SizedBox(height: 15),
                  _buildDetailItem(
                    label: _getString('lunarMonthLength'),
                    value: '${MoonCalculator.lunarMonth.toStringAsFixed(2)} days',
                  ),
                  const SizedBox(height: 15),
                  _buildDetailItem(
                    label: _getString('julianDayNumber'),
                    value: julianDay.toStringAsFixed(2),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Moon Phase Timeline
              _buildDetailSection(
                title: _getString('phaseTimeline'),
                children: [
                  _buildPhaseTimeline(),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue.shade400,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.cyan,
            ),
          ),
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailItem({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPhaseTimeline() {
    final phases = [
      ('🌑', 'newMoon'),
      ('🌒', 'waxingCrescent'),
      ('🌓', 'firstQuarter'),
      ('🌔', 'waxingGibbous'),
      ('🌕', 'fullMoon'),
      ('🌖', 'waningGibbous'),
      ('🌗', 'lastQuarter'),
      ('🌘', 'waningCrescent'),
    ];

    return Column(
      children: phases
          .map(
            (phase) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text(phase.$1, style: const TextStyle(fontSize: 28)),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      _getString(phase.$2),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
