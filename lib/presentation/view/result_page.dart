import 'package:android_studyjams/config/config.g.dart';
import 'package:android_studyjams/domain/entity/award.dart';
import 'package:android_studyjams/presentation/controller/result_controller.dart';
import 'package:android_studyjams/presentation/widget/awards_table.dart';
import 'package:android_studyjams/presentation/widget/custom_scaffold.dart';
import 'package:android_studyjams/presentation/widget/languages_dialog.dart';
import 'package:android_studyjams/presentation/widget/process_bar.dart';
import 'package:android_studyjams/utils/constants.dart';
import 'package:android_studyjams/utils/dimensions.dart';
import 'package:android_studyjams/utils/routes.dart';
import 'package:android_studyjams/utils/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultPage extends GetResponsiveView<ResultController> {
  ResultPage({super.key}) {
    final id = Get.parameters['id'];
    controller.load(id);
  }

  String _buildHeaderString(int value) {
    if (value == 0) {
      return AppStrings.letsStart.trParams({
        'num': Config.end.difference(DateTime.now().toUtc()).inDays.toString(),
      });
    }
    if (value < 12) {
      return AppStrings.keepFighting.trParams({
        'num': (12 - value).toString(),
      });
    }
    if (value >= 12 && value < 20) {
      return AppStrings.congratulations.trParams({
        'tier': '1',
      });
    }
    return AppStrings.congratulations.trParams({
      'tier': '2',
    });
  }

  @override
  Widget? desktop() {
    return CustomScaffold(
      body: controller.obx(
        (state) => LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.l,
                      ).copyWith(
                        bottom: Dimensions.m,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: constraints.maxWidth / 2,
                          ),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.l,
                                horizontal: Dimensions.m,
                              ),
                              child: Column(
                                children: [
                                  Center(
                                    child: SizedBox(
                                      width: constraints.maxWidth / 3,
                                      child: Flexible(
                                        child: Text(
                                          _buildHeaderString(controller.valid),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Center(
                                    child: ProcessBar(
                                      value: controller.valid,
                                      total: 20,
                                      width: constraints.maxWidth / 3,
                                      label: controller.valid >= 20
                                          ? AppStrings.tier.trParams({
                                              'tier': '1',
                                            })
                                          : controller.valid >= 12
                                              ? AppStrings.tier.trParams({
                                                  'tier': '1',
                                                })
                                              : '${controller.valid}/20',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.l,
                      ).copyWith(
                        bottom: Dimensions.m,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: constraints.maxWidth / 2,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    AwardsTable(
                                      awards: state ?? [],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.l,
                      ).copyWith(
                        bottom: Dimensions.m,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: constraints.maxWidth / 2,
                          ),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.l,
                                horizontal: Dimensions.m,
                              ),
                              child: Wrap(
                                direction: Axis.horizontal,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(AppStrings.seeding.tr),
                                  TextButton.icon(
                                    onPressed: () async {
                                      await launchUrl(
                                          Uri.parse(AppConstants.githubRepo));
                                    },
                                    icon: const Icon(Icons.star),
                                    label:
                                    Text(AppStrings.starThisProject.tr),
                                  ),
                                  TextButton.icon(
                                    onPressed: () async {
                                      await launchUrl(Uri.parse(
                                          AppConstants.githubProfile));
                                    },
                                    icon: const Icon(Icons.rss_feed),
                                    label:
                                    Text(AppStrings.followMeOnGithub.tr),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      Get.offAndToNamed(AppRoutes.home);
                                    },
                                    icon: const Icon(Icons.home),
                                    label: Text(AppStrings.homePage.tr),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        onLoading: const Center(
          child: CircularProgressIndicator(),
        ),
        onError: (error) => Center(
          child: Text(error ?? 'Error occurs.'),
        ),
        onEmpty: const Center(
          child: Text('Empty.'),
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: showLanguagesDialog,
        child: Icon(Icons.language),
      ),
    );
  }

  @override
  Widget? phone() {
    return Scaffold(
      body: controller.obx(
        (state) => LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: ProcessBar(
                          value: controller.valid,
                          total: 20,
                          width: constraints.maxWidth,
                          label: controller.valid >= 20
                              ? 'Tier 2'
                              : controller.valid >= 12
                                  ? 'Tier 1'
                                  : '${controller.valid}/20',
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final e = state?[index] as Award;
                      return ListTile(
                        leading: Icon(
                          Icons.check_circle,
                          color: Config.isValid(e)
                              ? Colors.green
                              : Colors.grey.shade400,
                        ),
                        title: InkWell(
                          onTap: () {
                            if (e.pathwayUrl == null || e.pathwayUrl!.isEmpty)
                              return;
                            try {
                              final link = Uri.parse(e.pathwayUrl!);
                              launchUrl(link);
                            } catch (e) {
                              return;
                            }
                          },
                          child: Text(
                            e.title ?? '',
                            style: TextStyle(
                              color: Config.isValidPathway(e)
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        trailing: Tooltip(
                          message: e.createTime,
                          child: Text(
                            DateFormat('MMM d, yyyy').format(
                              DateTime.parse(e.createTime ?? ""),
                            ),
                            style: TextStyle(
                              color: Config.isValidDate(e)
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }, childCount: state?.length ?? 0),
                  ),
                  const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
                ],
              ),
            );
          },
        ),
        onLoading: const Center(
          child: CircularProgressIndicator(),
        ),
        onError: (error) => Center(
          child: Text(error ?? 'Error occurs.'),
        ),
        onEmpty: const Center(
          child: Text('Empty.'),
        ),
      ),
    );
  }
}
