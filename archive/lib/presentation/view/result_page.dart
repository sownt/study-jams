import 'package:android_studyjams/config/config.g.dart';
import 'package:android_studyjams/domain/entity/award.dart';
import 'package:android_studyjams/presentation/controller/result_controller.dart';
import 'package:android_studyjams/presentation/widget/awards_table.dart';
import 'package:android_studyjams/presentation/widget/custom_scaffold.dart';
import 'package:android_studyjams/presentation/widget/process_bar.dart';
import 'package:android_studyjams/utils/constants.dart';
import 'package:android_studyjams/utils/dimensions.dart';
import 'package:android_studyjams/utils/routes.dart';
import 'package:android_studyjams/utils/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultPage extends GetResponsiveView<ResultController> {
  ResultPage({super.key}) {
    final id = Get.parameters['id'];
    controller.load(id);
  }

  String _buildHeaderString(int value) {
    if (value == 0) {
      return '${AppStrings.letsStart.trParams({
            'num':
                Config.end.difference(DateTime.now().toUtc()).inDays.toString(),
          })} (0/20)';
    }
    if (value < 12) {
      return '${AppStrings.keepFighting.trParams({
            'num': (12 - value).toString(),
          })} ($value/20)';
    }
    if (value >= 12 && value < 20) {
      return '${AppStrings.congratulations.trParams({
            'tier': '1',
          })} ($value/20)';
    }
    return '${AppStrings.congratulations.trParams({
          'tier': '2',
        })} ($value/20)';
  }

  SliverToBoxAdapter _header(context, constraints) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.l,
        ).copyWith(
          top: Dimensions.m,
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
                  horizontal: Dimensions.l,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _buildHeaderString(controller.valid),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.m,
                    ),
                    ProcessBar(
                      value: controller.valid,
                      total: 20,
                      width: constraints.maxWidth / 2.5,
                      label: controller.valid >= 20
                          ? 'Tier 2'
                          : controller.valid >= 12
                          ? 'Tier 1'
                          : '${controller.valid}/20',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _bottom(context, constraints) {
    return SliverToBoxAdapter(
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
                child: Center(
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.spaceEvenly,
                    children: [
                      Text(AppStrings.seeding.tr),
                      TextButton.icon(
                        onPressed: () async {
                          await launchUrl(
                            Uri.parse(AppConstants.githubRepo),
                          );
                        },
                        icon: const Icon(Icons.star),
                        label: Text(AppStrings.starThisProject.tr),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          await launchUrl(
                            Uri.parse(AppConstants.githubProfile),
                          );
                        },
                        icon: const Icon(Icons.rss_feed),
                        label: Text(AppStrings.followMeOnGithub.tr),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
                  _header(context, constraints),
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
                  _bottom(context, constraints),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.offAndToNamed(AppRoutes.home);
        },
        child: const Icon(Icons.home),
      ),
    );
  }

  @override
  Widget? phone() {
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
                        top: Dimensions.m,
                        bottom: Dimensions.m,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: constraints.maxWidth - 32,
                          ),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.l,
                                horizontal: Dimensions.l,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _buildHeaderString(controller.valid),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: Dimensions.m,
                                  ),
                                  ProcessBar(
                                    value: controller.valid,
                                    total: 20,
                                    width: constraints.maxWidth - 64,
                                    label: controller.valid >= 20
                                        ? 'Tier 2'
                                        : controller.valid >= 12
                                            ? 'Tier 1'
                                            : '${controller.valid}/20',
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
                            maxWidth: constraints.maxWidth - 32,
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
                            maxWidth: constraints.maxWidth - 32,
                          ),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.l,
                                horizontal: Dimensions.m,
                              ),
                              child: Center(
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  runAlignment: WrapAlignment.spaceEvenly,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    Text(AppStrings.seeding.tr),
                                    TextButton.icon(
                                      onPressed: () async {
                                        await launchUrl(
                                          Uri.parse(AppConstants.githubRepo),
                                        );
                                      },
                                      icon: const Icon(Icons.star),
                                      label:
                                          Text(AppStrings.starThisProject.tr),
                                    ),
                                    TextButton.icon(
                                      onPressed: () async {
                                        await launchUrl(
                                          Uri.parse(AppConstants.githubProfile),
                                        );
                                      },
                                      icon: const Icon(Icons.rss_feed),
                                      label:
                                          Text(AppStrings.followMeOnGithub.tr),
                                    ),
                                  ],
                                ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.offAndToNamed(AppRoutes.home);
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}
