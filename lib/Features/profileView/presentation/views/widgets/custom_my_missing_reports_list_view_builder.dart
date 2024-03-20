import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_return/Features/homeView/data/models/get_missing_form_model/missing_report.dart';
import 'package:safe_return/Features/homeView/presentation/manager/forms_cubit/forms_cubit.dart';
import 'package:safe_return/core/utils/functions/custom_snack_bar.dart';
import 'package:safe_return/core/utils/styles.dart';
import '../../../../homeView/data/models/get_missing_form_model/get_missing_form_model.dart';
import 'custom_report_lost_drop_down.dart';

class CustomMyMissingReportsListViewBuilder extends StatefulWidget {
  const CustomMyMissingReportsListViewBuilder({
    super.key,
  });

  @override
  State<CustomMyMissingReportsListViewBuilder> createState() =>
      _CustomMyMissingReportsListViewBuilderState();
}

class _CustomMyMissingReportsListViewBuilderState
    extends State<CustomMyMissingReportsListViewBuilder> {
  bool isLoading = false;

  GetMissingFormModel? missingFormModel;
  List<MissingReport>? missingReports;

  late Future<void> initialization;

  @override
  void initState() {
    super.initState();
    initialization = initializeData();
  }

  Future<void> initializeData() async {
    missingFormModel = GetMissingFormModel(
        message: 'initial message', reports: missingReports);
    await BlocProvider.of<FormsCubit>(context)
        .getMissingForm(missingFormModel!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormsCubit, FormsState>(
      listener: (context, state) {
        if (state is GetMissingFormLoading) {
          isLoading = true;
        } else if (state is GetMissingFormSuccess) {
          missingFormModel =
              GetMissingFormModel(message: 'success', reports: state.report);
          isLoading = false;
        } else if (state is GetFindFormFailure) {
          for (var errorMessage in state.errorMessages) {
            SnackBarManager.showSnackBar(
              context,
              errorMessage['message'].toString(),
            );
          }
          isLoading = false;
        }

        if (state is DeleteMissingLoading) {
          isLoading = true;
        } else if (state is DeleteMissingSuccess) {
          SnackBarManager.showSnackBar(
            context,
            'Report Deleted Successfully',
          );
          setState(() {
            missingFormModel?.reports?.removeAt(state.index);
          });
          isLoading = false;
        } else if (state is DeleteMissingFailure) {
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
        if (missingFormModel?.reports?.isEmpty == true) {
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
          itemCount: missingFormModel?.reports?.length,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                CustomReportLostDropDown(
                  missingFormModel: missingFormModel?.reports?[index],
                  onEdit: () {
                    String? id = missingFormModel?.reports?[index].id;
                    context.goNamed('editMissingPersonFormView',
                        pathParameters: {'_id': id as String});
                  },
                  onDelete: () {
                    BlocProvider.of<FormsCubit>(context).deleteMissingReport(
                      id: missingFormModel?.reports?[index].id,
                      index: index,
                    );
                  },
                  currentIndex: index,
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
