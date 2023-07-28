// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'award.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Award _$AwardFromJson(Map<String, dynamic> json) => Award(
      json['createTime'] as String?,
      json['title'] as String?,
      json['pathwayUrl'] as String?,
    );

Map<String, dynamic> _$AwardToJson(Award instance) => <String, dynamic>{
      'createTime': instance.createTime,
      'title': instance.title,
      'pathwayUrl': instance.pathwayUrl,
    };
