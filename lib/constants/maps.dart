import 'package:flutter/material.dart';

import 'enums.dart';

const Map<Language, String> mapAppLanguageToDescription = {
  Language.zh: "中文",
  Language.en: "英文",
};

const Map<Language, Locale> mapAppLanguageToLocal = {
  Language.zh: Locale('zh', 'TW'),
  Language.en: Locale('en', ''),
};

const Map<int, String> mapBottomNavIndexToScreenName = {
  0: 'home',
  1: 'courseSchedual',
  2: 'schoolEvents',
  3: 'schoolTour',
  4: 'eeclass',
  5: 'setting',
};

const Map<String, String> mapClassromCodeToDescription = {
  'A': '文學一館',
  'C2': '文學二館',
  'E': '工程一館',
  'E1': '工程二館',
  'E2': '機械館',
  'E3': '環工化工館',
  'E4': '機電實驗室',
  'E5': '大型力學實驗室',
  'E6': '工程五館大樓',
  'H2': '理學院教學館',
  'HK': '客家學院大樓',
  'I': '志希館',
  'I1': '管理二館',
  'IL': '國鼎光電大樓',
  'L3': '國鼎圖書資料館',
  'LS': '人文社會科學大樓',
  'M': '鴻經館',
  'O': '綜教館',
  'R2': '太空及遙測研究中心',
  'R3': '研究中心大樓二期',
  'S': '科學一館',
  'S1': '科學二館',
  'S2': '科學三館',
  'S4': '健雄管',
  'S5': '科學五館',
  'TR': '教學研究綜合大樓暨大禮堂',
  'YH': '依仁堂'
};

const Map<String, String> mapCourseSectionToTime = {
  'one': '8:',
  'two': '9:',
  'three': '10:',
  'four': '11:',
  'Z': '12:',
  'five': '13:',
  'six': '14:',
  'seven': '15:',
  'eight': '16:',
  'nine': '17:',
  'A': '18:',
  'B': '19:',
  'C': '20:',
  'D': '21:',
  'E': '22:',
  'F': '23:'
};

const Map<String, Color> mapEventCategoryToColor = {
  '行政': Color.fromARGB(255, 100, 193, 236),
  '活動': Color.fromARGB(255, 191, 244, 130),
  '徵才': Color.fromARGB(255, 241, 184, 251),
  '演講': Color.fromARGB(255, 244, 189, 108),
  '施工': Color.fromARGB(255, 255, 152, 186)
};

const Map<int, String> mapIndexToSection = {
  0: 'one',
  1: 'two',
  2: 'three',
  3: 'four',
  5: 'Z',
  6: 'five',
  7: 'six',
  8: 'seven',
  9: 'eight',
  10: 'nine',
  11: 'A',
  12: 'B',
  13: 'C',
  14: 'D',
  15: 'E',
  16: 'F'
};

const Map<int, String> mapIndexToWeekday = {
  0: 'monday',
  1: 'tuesday',
  2: 'wednesday',
  3: 'thursday',
  4: 'friday',
  5: 'saturday',
  6: 'sunday',
};

const Map<ThemeMode, String> mapThememodeToDescription = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
