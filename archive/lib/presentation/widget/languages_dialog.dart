import 'package:android_studyjams/utils/localization.g.dart';
import 'package:android_studyjams/utils/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageDialog extends AlertDialog {
  LanguageDialog({super.key})
      : super(
          icon: const Icon(Icons.language),
          title: Text(AppStrings.languages.tr),
          content: SingleChildScrollView(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  3,
                  (c) => Flexible(
                    child: Column(
                      children: List.generate(
                        3,
                        (r) => TextButton(
                          onPressed: Get.locale?.languageCode ==
                                  Localization.supportedLanguages[r * 3 + c]
                              ? null
                              : () async {
                                  await Get.updateLocale(
                                    Locale(
                                      Localization.supportedLanguages[r * 3 + c],
                                    ),
                                  );
                                },
                          child: Text(
                            Localization.supportedLanguages[r * 3 + c].tr,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
}

Future<void> showLanguagesDialog() async {
  if (Get.context == null) return;
  return showDialog<void>(
    context: Get.context!,
    builder: (BuildContext context) {
      return LanguageDialog();
    },
  );
}
