import 'dart:io';

import 'package:android_studyjams/domain/repository/data_repository.dart';
import 'package:android_studyjams/locator.dart';
import 'package:android_studyjams/utils/strings.g.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin<String?> {
  HomeController() {
    change(null, status: RxStatus.empty());
  }

  Future<void> getId(String? username) async {
    if (username == null || username.isEmpty) {
      change(null, status: RxStatus.empty());
      return;
    }
    change(null, status: RxStatus.loading());
    try {
      final id = (await locator<DataRepository>().getId(username))?.profileId
          as String;
      change(id, status: RxStatus.success());
    } on HttpException catch (e) {
      change(null, status: RxStatus.error(e.message));
    } catch (_) {
      change(null, status: RxStatus.error(AppStrings.errorOccurred.tr));
    }
  }
}
