import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_return/Features/homeView/data/models/get_find_form_model/get_find_form_model.dart';
import 'package:safe_return/Features/homeView/presentation/manager/forms_cubit/forms_cubit.dart';
import 'package:safe_return/core/utils/functions/custom_snack_bar.dart';
import 'package:safe_return/core/utils/styles.dart';
import '../../../../homeView/data/models/get_find_form_model/find_report.dart';
import 'custom_report_find_drop_down.dart';

class CustomMyFindReportsListViewBuilder extends StatefulWidget {
  const CustomMyFindReportsListViewBuilder({
    super.key,
  });

  @override
  State<CustomMyFindReportsListViewBuilder> createState() =>
      _CustomMyFindReportsListViewBuilderState();
}

class _CustomMyFindReportsListViewBuilderState
    extends State<CustomMyFindReportsListViewBuilder> {
  bool isLoading = false;
  GetFindFormModel? findFormModel;
  List<FindReport>? findReports;

  late Future<void> initialization;

  @override
  void initState() {
    super.initState();
    initialization = initializeData();
  }

  Future<void> initializeData() async {
    findFormModel =
        GetFindFormModel(message: 'initial message', reports: findReports);
    await BlocProvider.of<FormsCubit>(context).getFindForm(findFormModel!);
  }

  Future<void> _refresh() {
    setState(() {
      initializeData();
    });
    return Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormsCubit, FormsState>(
      listener: (context, state) {
        if (state is GetFindFormLoading) {
          isLoading = true;
        } else if (state is GetFindFormSuccess) {
          findFormModel =
              GetFindFormModel(message: 'success', reports: state.findReport);

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

        if (state is DeleteFindFormLoading) {
          isLoading = true;
        } else if (state is DeleteFindFormSuccess) {
          SnackBarManager.showSnackBar(
            context,
            'Report Deleted Successfully',
          );
          setState(() {
            findFormModel?.reports?.removeAt(state.index);
          });
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
        if (findFormModel?.reports?.isEmpty == true) {
          return RefreshIndicator(
            onRefresh: _refresh,
            child: Column(
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
                    GestureDetector(
                      onTap: _refresh,
                      child: SvgPicture.asset(
                          'assets/myReportsPhotos/loading.svg'),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
            itemCount: findFormModel?.reports?.length,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  CustomReportFindDropDown(
                    findFormModel: findFormModel?.reports?[index],
                    onEdit: () {
                      String? id = findFormModel?.reports?[index].id;
                      context.goNamed('editFindPersonFormView',
                          pathParameters: {'_id': id as String});
                    },
                    onDelete: () async {
                      BlocProvider.of<FormsCubit>(context).deleteFindForm(
                        id: findFormModel?.reports?[index].id,
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
          ),
        );
      },
    );
  }
}
