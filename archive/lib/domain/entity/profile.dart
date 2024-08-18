import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile(
    this.profileId,
    this.username,
  );

  @JsonKey(name: 'obfuscatedProfileId')
  final String? profileId;
  @JsonKey(name: 'vanityId')
  final String? username;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
