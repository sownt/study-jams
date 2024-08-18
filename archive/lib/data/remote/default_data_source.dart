import 'package:android_studyjams/domain/entity/award.dart';
import 'package:android_studyjams/domain/entity/profile.dart';
import 'package:android_studyjams/utils/constants.dart';
import 'package:get/get.dart';

class DefaultDataSource extends GetConnect {
  Profile? profileDecoder(data) {
    final profile = Profile.fromJson(data);
    if (profile.profileId == null) {
      return null;
    }
    return profile;
  }

  List<Award>? awardsDecoder(data) {
    try {
      final awards = data as List;
      return awards
          .map(
            (e) => Award.fromJson(e),
          )
          .toList();
    } catch (_) {
      return null;
    }
  }

  Future<Response<Profile?>> getId(String username) => get(
        '${AppConstants.baseUrl}/id',
        decoder: profileDecoder,
        query: {
          'username': username,
        },
      );

  Future<Response<List<Award>?>> getAwards(String id) => get(
        '${AppConstants.baseUrl}/awards',
        decoder: awardsDecoder,
        query: {
          'id': id,
        },
      );
}
