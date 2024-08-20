import 'dart:io';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;

void main() async {
  // Linux only
  ProcessResult result = await Process.run(
    'curl',
    ['https://developer.android.com/courses/android-basics-compose/course'],
  );

  Document page = parser.parse(result.stdout);
  List<String> pathways = [];
  pathways.addAll(
    page
        .getElementsByClassName('compose-pathway-link')
        .map((e) => e.text.trim().toLowerCase()),
    // .where((e) => e.attributes.containsKey('href'))
    // .map((e) => 'https://developer.android.com${e.attributes['href']}'),
  );

  result = await Process.run(
    'curl',
    ['https://developer.android.com/courses/jetpack-compose/course'],
  );
  page = parser.parse(result.stdout);
  pathways.addAll(
    page.getElementsByClassName('devsite-playlist-summary-title').map(
          (e) => e.text.trim().toLowerCase(),
          // .getElementsByTagName('a')
          // .where((e) => e.attributes.containsKey('href'))
          // .map((e) => e.attributes['href'] ?? '')
          // .first,
        ),
  );

  var content = '{\n  "pathway": [\n';
  for (int i = 0; i < pathways.length; i++) {
    if (i == pathways.length - 1) {
      content = '$content    "${pathways[i]}"\n';
    } else {
      content = '$content    "${pathways[i]}",\n';
    }
  }
  content = '$content  ],\n';
  content =
      '$content  "start": "${DateTime.utc(2023, 7, 14).toIso8601String()}",\n  "end": "${DateTime.utc(2023, 8, 12, 23, 59, 59).toIso8601String()}"\n}';

  await File('${Directory.current.absolute.path}/lib/config/config.json')
      .writeAsString(content);

  var classAsText = 'class Config {\n';
  classAsText = '$classAsText  static List<String> pathway = [\n';
  for (int i = 0; i < pathways.length; i++) {
    classAsText = '$classAsText    "${pathways[i]}",\n';
  }
  classAsText = '$classAsText  ];\n';
  classAsText =
      '$classAsText  static DateTime start = DateTime.utc(2023, 7, 14);\n';
  classAsText =
      '$classAsText  static DateTime end = DateTime.utc(2023, 8, 12, 23, 59, 59);\n';
  classAsText =
      '$classAsText  static bool isValid(dynamic p) {\n    return pathway.contains(p[\'title\']) && DateTime.parse(p[\'earned\']).isAfter(start) && DateTime.parse(p[\'earned\']).isBefore(end);\n  }\n';
  classAsText = '$classAsText}';
  // await File('${Directory.current.absolute.path}/lib/config/config.g.dart')
  //     .writeAsString(classAsText);
}
