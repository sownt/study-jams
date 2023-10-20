import 'package:android_studyjams/domain/entity/award.dart';
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
}

class MainState {
  String? query;
  List<Award>? awards;
}