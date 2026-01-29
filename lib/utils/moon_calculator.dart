import 'dart:math';

class MoonPhase {
  final double illumination;
  final String phase;
  final String emoji;

  MoonPhase({
    required this.illumination,
    required this.phase,
    required this.emoji,
  });
}

class MoonCalculator {
  // Moon phase calculation based on astronomical algorithms
  // Reference: Astronomical Algorithms by Jean Meeus
  
  static const double knownNewMoon = 2451550.1; // January 6, 2000 18:14 UTC (JD)
  static const double lunarMonth = 29.530588861; // Average lunar month in days

  static double dateToJulianDay(DateTime date) {
    int year = date.year;
    int month = date.month;
    int day = date.day;

    if (month <= 2) {
      year--;
      month += 12;
    }

    int a = year ~/ 100;
    int b = 2 - a + (a ~/ 4);

    double jd = (365.25 * (year + 4716)).floor().toDouble() +
        (30.6001 * (month + 1)).floor().toDouble() +
        day +
        (date.hour + date.minute / 60 + date.second / 3600) / 24.0 +
        b -
        1524.5;

    return jd;
  }

  static MoonPhase calculateMoonPhase(DateTime date) {
    double jd = dateToJulianDay(date);
    
    // Calculate days since known new moon
    double daysSinceNewMoon = jd - knownNewMoon;
    
    // Calculate position in lunar month (0-1)
    double lunarCycle = (daysSinceNewMoon % lunarMonth) / lunarMonth;
    
    // Illumination percentage (0-100%)
    double illumination = (1 - cos(2 * pi * lunarCycle)) / 2 * 100;
    illumination = illumination.clamp(0, 100);

    // Determine moon phase name and emoji
    String phaseName;
    String emoji;

    if (lunarCycle < 0.0625) {
      phaseName = 'New Moon';
      emoji = '🌑';
    } else if (lunarCycle < 0.1875) {
      phaseName = 'Waxing Crescent';
      emoji = '🌒';
    } else if (lunarCycle < 0.3125) {
      phaseName = 'First Quarter';
      emoji = '🌓';
    } else if (lunarCycle < 0.4375) {
      phaseName = 'Waxing Gibbous';
      emoji = '🌔';
    } else if (lunarCycle < 0.5625) {
      phaseName = 'Full Moon';
      emoji = '🌕';
    } else if (lunarCycle < 0.6875) {
      phaseName = 'Waning Gibbous';
      emoji = '🌖';
    } else if (lunarCycle < 0.8125) {
      phaseName = 'Last Quarter';
      emoji = '🌗';
    } else if (lunarCycle < 0.9375) {
      phaseName = 'Waning Crescent';
      emoji = '🌘';
    } else {
      phaseName = 'New Moon';
      emoji = '🌑';
    }

    return MoonPhase(
      illumination: illumination,
      phase: phaseName,
      emoji: emoji,
    );
  }

  static List<MoonPhase> getMoonPhasesForMonth(int year, int month) {
    List<MoonPhase> phases = [];
    int daysInMonth = _getDaysInMonth(year, month);

    for (int day = 1; day <= daysInMonth; day++) {
      DateTime date = DateTime(year, month, day, 12, 0, 0);
      phases.add(calculateMoonPhase(date));
    }

    return phases;
  }

  static int _getDaysInMonth(int year, int month) {
    if (month == 2) {
      return _isLeapYear(year) ? 29 : 28;
    }
    return [31, 31, 30, 31, 30, 31, 31, 31, 30, 31, 30, 31][month - 1];
  }

  static bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  // Calculate days until next Full Moon or New Moon
  static Map<String, dynamic> getDaysUntilNextPhase(DateTime date) {
    double jd = dateToJulianDay(date);
    double daysSinceNewMoon = jd - knownNewMoon;
    double lunarCycle = (daysSinceNewMoon % lunarMonth) / lunarMonth;

    // Full Moon is at 0.5 of the lunar cycle
    double daysUntilFullMoon;
    double daysUntilNewMoon;

    if (lunarCycle < 0.5) {
      // Full moon is ahead
      daysUntilFullMoon = (0.5 - lunarCycle) * lunarMonth;
      daysUntilNewMoon = (1.0 - lunarCycle) * lunarMonth;
    } else {
      // Next full moon is in the next cycle
      daysUntilFullMoon = (1.5 - lunarCycle) * lunarMonth;
      daysUntilNewMoon = (1.0 - lunarCycle) * lunarMonth;
    }

    // Determine which comes first
    String nextPhase;
    int daysUntil;

    if (daysUntilNewMoon < daysUntilFullMoon) {
      nextPhase = 'New Moon';
      daysUntil = daysUntilNewMoon.round();
    } else {
      nextPhase = 'Full Moon';
      daysUntil = daysUntilFullMoon.round();
    }

    return {
      'phase': nextPhase,
      'days': daysUntil,
    };
  }
}
