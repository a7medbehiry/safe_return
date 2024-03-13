import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_return/Features/homeView/data/models/get_find_form_model/get_find_form_model.dart';
import 'package:safe_return/core/utils/styles.dart';
import 'custom_report_find_drop_down.dart';

class CustomMyReportsListViewBuilder extends StatelessWidget {
  const CustomMyReportsListViewBuilder({super.key, this.findFormModel});
  final GetFindFormModel? findFormModel;

  @override
  Widget build(BuildContext context) {
    if (findFormModel?.reports == null || findFormModel!.reports!.isEmpty) {
      return Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "There are no reports made by you!",
                style: Styles.textStyleSemi16,
              ),
              const SizedBox(
                width: 5,
              ),
              SvgPicture.asset('assets/myReportsPhotos/loading.svg'),
            ],
          ),
        ],
      );
    }

    return ListView.builder(
      itemCount: 1,
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          children: [
            //  CustomReportLostDropDown(
            //    onEdit: () => context.goNamed('editMissingPersonFormView'),
            //   onDelete: () {},
            // ),
            CustomReportFindDropDown(
              findFormModel: findFormModel?.reports?[index],
              onEdit: () => context.goNamed('editFindPersonFormView'),
              onDelete: () {},
              currentIndex: index,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}
