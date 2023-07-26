import 'package:android_studyjams/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SeedingDialog extends AlertDialog {
  SeedingDialog({super.key})
      : super(
          title: Text('Love it?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    await launchUrl(Uri.parse(AppConstants.githubRepo));
                  },
                  icon: const Icon(Icons.star),
                  label: const Text('Star this project'),
                ),
                TextButton.icon(
                  onPressed: () async {
                    await launchUrl(Uri.parse(AppConstants.githubProfile));
                  },
                  icon: Icon(Icons.rss_feed),
                  label: Text('Follow me on GitHub'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Not yet!'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
}

Future<void> seeding() async {
  if (Get.context == null) return;
  return showDialog<void>(
    context: Get.context!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return SeedingDialog();
    },
  );
}
