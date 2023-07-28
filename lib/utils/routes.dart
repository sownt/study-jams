import 'package:android_studyjams/presentation/controller/home_controller.dart';
import 'package:android_studyjams/presentation/controller/result_controller.dart';
import 'package:android_studyjams/presentation/view/home_page.dart';
import 'package:android_studyjams/presentation/view/mock.dart';
import 'package:android_studyjams/presentation/view/not_found.dart';
import 'package:android_studyjams/presentation/view/result_page.dart';
import 'package:android_studyjams/utils/strings.g.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._();

  static const mock = '/mock';
  static const notFound = '/not_found';
  static const home = '/home';
  static const result = '/result/:id';

  static final fallback = GetPage(
    name: notFound,
    page: () => const NotFound(),
  );

  static final List<GetPage> pages = [
    GetPage(
      name: mock,
      page: () => const Mock(),
    ),
    GetPage(
      name: home,
      page: () => HomePage(),
      binding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: result,
      page: () => ResultPage(),
      binding: BindingsBuilder(() {
        Get.put(ResultController());
      }),
      transition: Transition.noTransition,
    ),
  ];

  static String onGenerateTitle(context) {
    if (Get.currentRoute == AppRoutes.home) {
      return AppStrings.homePage.tr;
    } else if (Get.currentRoute == AppRoutes.result) {
      return AppStrings.result.tr;
    } else if (Get.currentRoute == AppRoutes.notFound) {
      return AppStrings.pageNotFound.tr;
    }
    return AppStrings.appTitle.tr;
  }
}
