import 'package:android_studyjams/config/config.g.dart';
import 'package:android_studyjams/domain/entity/award.dart';
import 'package:android_studyjams/utils/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AwardsTable extends StatelessWidget {
  const AwardsTable({super.key, required this.awards});

  final List<Award> awards;

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      columns: [
        DataColumn(label: Text(AppStrings.name.tr)),
        DataColumn(label: Text(AppStrings.earnedDate.tr)),
        DataColumn(label: Text(AppStrings.valid.tr)),
      ],
      source: AwardSource(awards),
    );
  }
}

class AwardSource extends DataTableSource {
  AwardSource(this.awards);

  final List<Award> awards;

  @override
  DataRow? getRow(int index) {
    final e = awards[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          InkWell(
            onTap: () {
              if (e.pathwayUrl == null || e.pathwayUrl!.isEmpty) return;
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
                color: Config.isValidPathway(e) ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
        DataCell(
          Tooltip(
            message: e.createTime,
            child: Text(
              DateFormat('MMM d, yyyy').format(
                DateTime.parse(e.createTime ?? ""),
              ),
              style: TextStyle(
                color: Config.isValidDate(e) ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
        DataCell(
          Config.isValid(e)
              ? const Icon(Icons.check_circle, color: Colors.green)
              : Tooltip(
                  message: Config.isValidDate(e)
                      ? AppStrings.invalidPathway.tr
                      : Config.isValidPathway(e)
                          ? AppStrings.invalidEarnedDate.tr
                          : AppStrings.invalidBothCases.tr,
                  child: Icon(Icons.check_circle, color: Colors.grey.shade400),
                ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => awards.length;

  @override
  int get selectedRowCount => 0;
}
