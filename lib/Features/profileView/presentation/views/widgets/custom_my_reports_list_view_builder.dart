import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_return/Features/homeView/data/models/get_find_form_model/get_find_form_model.dart';
import 'package:safe_return/Features/homeView/presentation/manager/forms_cubit/forms_cubit.dart';
import 'package:safe_return/core/utils/functions/custom_snack_bar.dart';
import '../../../../homeView/data/models/get_missing_form_model/get_missing_form_model.dart';
import 'custom_report_find_drop_down.dart';
import 'custom_report_lost_drop_down.dart';

class CustomMyReportsListViewBuilder extends StatefulWidget {
  const CustomMyReportsListViewBuilder(
      {super.key, this.findFormModel, this.missingFormModel});
  final GetFindFormModel? findFormModel;
  final GetMissingFormModel? missingFormModel;

  @override
  State<CustomMyReportsListViewBuilder> createState() =>
      _CustomMyReportsListViewBuilderState();
}

class _CustomMyReportsListViewBuilderState
    extends State<CustomMyReportsListViewBuilder> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // if (findFormModel?.reports == null || findFormModel!.reports!.isEmpty) {
    //   return Column(
    //     children: [
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           const Text(
    //             "There are no reports made by you!",
    //             style: Styles.textStyleSemi16,
    //           ),
    //           const SizedBox(
    //             width: 5,
    //           ),
    //           SvgPicture.asset('assets/myReportsPhotos/loading.svg'),
    //         ],
    //       ),
    //     ],
    //   );
    // }

    return BlocConsumer<FormsCubit, FormsState>(
      listener: (context, state) {
        if (state is DeleteFindFormLoading) {
          isLoading = true;
        } else if (state is DeleteFindFormSuccess) {
          SnackBarManager.showSnackBar(
            context,
            'Report Deleted Successfully',
          );
          isLoading = false;
        } else if (state is DeleteFindFormFailure) {
          for (var errorMessage in state.errorMessages) {
            SnackBarManager.showSnackBar(
              context,
              errorMessage['message'].toString(),
            );
          }
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ListView.builder(
          itemCount: 1,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                CustomReportLostDropDown(
                  missingFormModel: widget.missingFormModel?.reports?[index],
                  onEdit: () => context.goNamed('editMissingPersonFormView'),
                  onDelete: () {},
                  currentIndex: index,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomReportFindDropDown(
                  findFormModel: widget.findFormModel?.reports?[3],
                  onEdit: () => context.goNamed('editFindPersonFormView'),
                  onDelete: () async {
                    BlocProvider.of<FormsCubit>(context).deleteFindForm();
                  },
                  currentIndex: 3,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
