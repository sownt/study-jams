import 'package:android_studyjams/domain/entity/award.dart';

class Config {
  static List<String> pathway = [
    "introduction to programming in kotlin", // "introduction to kotlin",
    "set up android studio", // "setup android studio",
    "build a basic layout",
    "kotlin fundamentals",
    "add a button to an app",
    "interacting with ui and state",
    "more kotlin fundamentals",
    "build a scrollable list",
    "add theme and animation", // "build beautiful apps",
    "architecture components",
    "navigation in jetpack compose",
    "adaptive layouts", // "adapt for different screen sizes",
    "get data from the internet",
    "load and display images from the internet",
    "introduction to sql",
    "use room for data persistence",
    "store and access data using keys with datastore",
    "schedule tasks with workmanager",
    "android views and compose in views",
    "views in compose",
    "compose essentials",
    "layouts, theming, and animation",
    "architecture and state",
    "accessibility, testing, and performance",
    "form factors",
  ];
  static DateTime start = DateTime.utc(2023, 7, 14);
  static DateTime end = DateTime.utc(2023, 8, 12, 23, 59, 59);
  static bool isValidPathway(Award a) {
    return pathway.contains(a.title?.toLowerCase());
  }
  static bool isValidDate(Award a) {
    return DateTime.parse(a.createTime!).isAfter(start) && DateTime.parse(a.createTime!).isBefore(end);
  }
  static bool isValid(Award a) {
    if (a.title == null || a.createTime == null) return false;
    return isValidPathway(a) && isValidDate(a);
  }
}