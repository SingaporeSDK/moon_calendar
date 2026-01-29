import 'package:flutter/material.dart';
import '../utils/moon_calculator.dart';
import '../utils/lunar_festivals.dart';

class CalendarScreen extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final String languageCode;

  const CalendarScreen({
    super.key,
    required this.onDateSelected,
    this.languageCode = 'en',
  });

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime currentMonth;

  @override
  void initState() {
    super.initState();
    currentMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
  }

  void _previousMonth() {
    setState(() {
      if (currentMonth.month == 1) {
        currentMonth = DateTime(currentMonth.year - 1, 12, 1);
      } else {
        currentMonth = DateTime(currentMonth.year, currentMonth.month - 1, 1);
      }
    });
  }

  void _nextMonth() {
    setState(() {
      if (currentMonth.month == 12) {
        currentMonth = DateTime(currentMonth.year + 1, 1, 1);
      } else {
        currentMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth = _getDaysInMonth(currentMonth.year, currentMonth.month);
    int firstWeekday = DateTime(currentMonth.year, currentMonth.month, 1).weekday;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${_monthName(currentMonth.month)} ${currentMonth.year}',
          style: const TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF0a0e27),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Month Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: _previousMonth,
                  ),
                  Text(
                    '${_monthName(currentMonth.month)} ${currentMonth.year}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: _nextMonth,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Weekday Headers
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text('Sun', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Mon', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Tue', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Wed', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Thu', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Fri', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Sat', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              // Calendar Grid
              GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.9,
                children: [
                  // Empty cells for days before the 1st
                  ...List.generate(
                    firstWeekday - 1,
                    (index) => const SizedBox.shrink(),
                  ),
                  // Current month's days
                  ...List.generate(daysInMonth, (index) {
                    int day = index + 1;
                    DateTime date =
                        DateTime(currentMonth.year, currentMonth.month, day);
                    MoonPhase phase = MoonCalculator.calculateMoonPhase(date);
                    bool isToday = _isToday(date);

                    return GestureDetector(
                      onTap: () {
                        widget.onDateSelected(date);
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: isToday
                              ? Border.all(
                                  color: Colors.cyan,
                                  width: 2,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(8),
                          color: isToday
                              ? Colors.cyan.withValues(alpha: 0.2)
                              : Colors.transparent,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              day.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: isToday ? Colors.cyan : Colors.white,
                                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              phase.emoji,
                              style: const TextStyle(fontSize: 16),
                            ),
                            // Check for festival
                            _buildFestivalIndicator(date),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFestivalIndicator(DateTime date) {
    final festival =
        LunarFestivals.getFestivalForDate(widget.languageCode, date.month, date.day);
    if (festival != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: Text(
          festival.emoji,
          style: const TextStyle(fontSize: 12),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  int _getDaysInMonth(int year, int month) {
    if (month == 2) {
      return _isLeapYear(year) ? 29 : 28;
    }
    return [31, 31, 30, 31, 30, 31, 31, 31, 30, 31, 30, 31][month - 1];
  }

  bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  String _monthName(int month) {
    const names = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return names[month - 1];
  }
}
