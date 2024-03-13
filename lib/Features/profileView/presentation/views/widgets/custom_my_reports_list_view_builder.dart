import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'custom_report_find_drop_down.dart';
import 'custom_report_lost_drop_down.dart';

class CustomMyReportsListViewBuilder extends StatelessWidget {
  const CustomMyReportsListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            CustomReportLostDropDown(
              onEdit: () => context.goNamed('editMissingPersonFormView'),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomReportFindDropDown(
              onEdit: () => context.goNamed('editFindPersonFormView'),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}
