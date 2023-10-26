import 'dart:io';

import 'package:android_studyjams/domain/entity/award.dart';
import 'package:android_studyjams/domain/repository/data_repository.dart';
import 'package:android_studyjams/locator.dart';
import 'package:android_studyjams/utils/strings.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainController extends GetxController with StateMixin<MainState> {
  MainController() {
    searchController = TextEditingController();
    searchController.addListener(onSearchChanged);
  }

  late final TextEditingController searchController;
  bool selected = false;

  void onSearchChanged() {

  }

  // Future<void> getId(String? username) async {
  //   if (username == null || username.isEmpty) {
  //     change(null, status: RxStatus.empty());
  //     return;
  //   }
  //   change(null, status: RxStatus.loading());
  //   try {
  //     final id = (await locator<DataRepository>().getId(username))?.profileId
  //     as String;
  //     change(id, status: RxStatus.success());
  //   } on HttpException catch (e) {
  //     change(null, status: RxStatus.error(e.message));
  //   } catch (_) {
  //     change(null, status: RxStatus.error(AppStrings.errorOccurred.tr));
  //   }
  // }
  //
  // Future<void> load(String? id) async {
  //   if (id == null || id.isEmpty) {
  //     change(null, status: RxStatus.error('Missing username.'));
  //     return;
  //   }
  //   try {
  //     change(null, status: RxStatus.loading());
  //     final awards = await locator<DataRepository>().getAwards(id);
  //     if (awards != null) {
  //       valid = count(awards);
  //     }
  //     change(
  //       awards,
  //       status: awards == null || awards.isEmpty
  //           ? RxStatus.empty()
  //           : RxStatus.success(),
  //     );
  //   } on HttpException catch (e) {
  //     change([], status: RxStatus.error(e.message));
  //   } catch (_) {
  //     change([], status: RxStatus.error(AppStrings.errorOccurred.tr));
  //   }
  // }

}

class MainState {
  String? query;
  List<Award>? awards;
}