import 'dart:io';

import 'package:android_studyjams/data/remote/default_data_source.dart';
import 'package:android_studyjams/domain/entity/award.dart';
import 'package:android_studyjams/domain/entity/profile.dart';
import 'package:android_studyjams/domain/repository/data_repository.dart';
import 'package:android_studyjams/utils/strings.g.dart';
import 'package:get/get.dart';

class DataRepositoryImpl extends DataRepository {
  DataRepositoryImpl(this.dataSource);

  final DefaultDataSource dataSource;

  @override
  Future<Profile?> getId(String username) async {
    final res = await dataSource.getId(username);
    if (res.statusCode == 200) {
      return res.body;
    }
    throw HttpException(AppStrings.getDataFailed.tr);
  }

  @override
  Future<List<Award>?> getAwards(String id) async {
    final res = await dataSource.getAwards(id);
    if (res.statusCode == 200) {
      return res.body;
    }
    throw HttpException(AppStrings.getDataFailed.tr);
  }

}