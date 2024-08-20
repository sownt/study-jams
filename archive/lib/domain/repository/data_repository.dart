import 'package:android_studyjams/domain/entity/award.dart';
import 'package:android_studyjams/domain/entity/profile.dart';

abstract class DataRepository {
  Future<Profile?> getId(String username);
  Future<List<Award>?> getAwards(String id);
}