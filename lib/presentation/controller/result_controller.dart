import 'dart:io';

import 'package:android_studyjams/config/config.g.dart';
import 'package:android_studyjams/domain/entity/award.dart';
import 'package:android_studyjams/domain/repository/data_repository.dart';
import 'package:android_studyjams/locator.dart';
import 'package:android_studyjams/utils/strings.g.dart';
import 'package:get/get.dart';

class ResultController extends GetxController with StateMixin<List<Award>?> {
  int valid = 0;

  ResultController() {
    change(null, status: RxStatus.empty());
  }

  int count(List<Award> awards) {
    int count = 0;
    for (var element in awards) {
      if (Config.isValid(element)) {
        count++;
      }
    }
    return count;
  }

  Future<void> load(String? id) async {
    if (id == null || id.isEmpty) {
      change(null, status: RxStatus.error('Missing username.'));
      return;
    }
    try {
      change(null, status: RxStatus.loading());
      final awards = await locator<DataRepository>().getAwards(id);
      if (awards != null) {
        valid = count(awards);
      }
      change(
        awards,
        status: awards == null || awards.isEmpty
            ? RxStatus.empty()
            : RxStatus.success(),
      );
    } on HttpException catch (e) {
      change([], status: RxStatus.error(e.message));
    } catch (_) {
      change([], status: RxStatus.error(AppStrings.errorOccurred.tr));
    }
  }
}
