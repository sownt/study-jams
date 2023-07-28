import 'package:json_annotation/json_annotation.dart';

part 'award.g.dart';

@JsonSerializable()
class Award {
  Award(
    this.createTime,
    this.title,
    this.pathwayUrl,
  );

  final String? createTime;
  final String? title;
  final String? pathwayUrl;

  factory Award.fromJson(Map<String, dynamic> json) => _$AwardFromJson(json);

  Map<String, dynamic> toJson() => _$AwardToJson(this);
}
