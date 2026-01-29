class LunarFestival {
  final String name;
  final String nameInLocal;
  final String description;
  final String emoji;
  final String lunarMonth;
  final String lunarDay;

  LunarFestival({
    required this.name,
    required this.nameInLocal,
    required this.description,
    required this.emoji,
    required this.lunarMonth,
    required this.lunarDay,
  });
}

class LunarFestivals {
  // Japanese Festivals (日本)
  static final List<LunarFestival> japanesefestivals = [
    LunarFestival(
      name: 'Otsukimi (Moon Viewing)',
      nameInLocal: 'お月見（十五夜）',
      description: 'Autumn moon viewing festival celebrating the harvest',
      emoji: '🎑',
      lunarMonth: '8',
      lunarDay: '15',
    ),
    LunarFestival(
      name: 'Yoi no Kugure (Thirteenth Moon)',
      nameInLocal: '十三夜',
      description: 'Second autumn moon viewing festival',
      emoji: '🌙',
      lunarMonth: '9',
      lunarDay: '13',
    ),
    LunarFestival(
      name: 'New Year Festival',
      nameInLocal: 'お正月',
      description: 'Japanese New Year celebrations',
      emoji: '🎊',
      lunarMonth: '1',
      lunarDay: '1',
    ),
  ];

  // Korean Festivals (한국)
  static final List<LunarFestival> koreanFestivals = [
    LunarFestival(
      name: 'Chuseok',
      nameInLocal: '추석',
      description: 'Korean harvest festival and autumn celebration',
      emoji: '🌾',
      lunarMonth: '8',
      lunarDay: '15',
    ),
    LunarFestival(
      name: 'Lunar New Year',
      nameInLocal: '설날',
      description: 'Korean Lunar New Year celebration',
      emoji: '🎆',
      lunarMonth: '1',
      lunarDay: '1',
    ),
    LunarFestival(
      name: 'Dano Festival',
      nameInLocal: '단오',
      description: 'Spring festival celebrating life and renewal',
      emoji: '🌸',
      lunarMonth: '5',
      lunarDay: '5',
    ),
  ];

  // Chinese Festivals (中国)
  static final List<LunarFestival> chineseFestivals = [
    LunarFestival(
      name: 'Mid-Autumn Festival',
      nameInLocal: '中秋节',
      description: 'Family reunion and moon viewing festival',
      emoji: '🎆',
      lunarMonth: '8',
      lunarDay: '15',
    ),
    LunarFestival(
      name: 'Lunar New Year',
      nameInLocal: '春节',
      description: 'Chinese New Year - Year of renewal',
      emoji: '🧧',
      lunarMonth: '1',
      lunarDay: '1',
    ),
    LunarFestival(
      name: 'Dragon Boat Festival',
      nameInLocal: '端午节',
      description: 'Festival commemorating Qu Yuan',
      emoji: '🐉',
      lunarMonth: '5',
      lunarDay: '5',
    ),
    LunarFestival(
      name: 'Qingming Festival',
      nameInLocal: '清明节',
      description: 'Tomb Sweeping Day - honoring ancestors',
      emoji: '🌿',
      lunarMonth: '3',
      lunarDay: '3',
    ),
  ];

  // Indian Festivals (भारत)
  static final List<LunarFestival> indianFestivals = [
    LunarFestival(
      name: 'Holi',
      nameInLocal: 'होली',
      description: 'Festival of colors and spring renewal',
      emoji: '🎨',
      lunarMonth: '3',
      lunarDay: '1',
    ),
    LunarFestival(
      name: 'Diwali',
      nameInLocal: 'दिवाली',
      description: 'Festival of lights - victory over darkness',
      emoji: '🪔',
      lunarMonth: '10',
      lunarDay: '15',
    ),
    LunarFestival(
      name: 'Full Moon (Purnima)',
      nameInLocal: 'पूर्णिमा',
      description: 'Auspicious full moon day in Hindu calendar',
      emoji: '🌕',
      lunarMonth: '12',
      lunarDay: '15',
    ),
    LunarFestival(
      name: 'Navratri',
      nameInLocal: 'नवरात्रि',
      description: 'Nine nights festival celebrating Goddess Durga',
      emoji: '🙏',
      lunarMonth: '7',
      lunarDay: '1',
    ),
  ];

  static List<LunarFestival> getFestivalsByCountry(String countryCode) {
    switch (countryCode) {
      case 'ja':
        return japanesefestivals;
      case 'ko':
        return koreanFestivals;
      case 'zh':
        return chineseFestivals;
      case 'hi':
        return indianFestivals;
      default:
        return [];
    }
  }

  static LunarFestival? getFestivalForDate(
    String countryCode,
    int month,
    int day,
  ) {
    final festivals = getFestivalsByCountry(countryCode);
    for (final festival in festivals) {
      if (int.parse(festival.lunarMonth) == month &&
          int.parse(festival.lunarDay) == day) {
        return festival;
      }
    }
    return null;
  }
}
