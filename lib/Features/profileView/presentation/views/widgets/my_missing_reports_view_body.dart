import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_return/Features/profileView/presentation/views/widgets/custom_my_missing_reports_list_view_builder.dart';
import 'package:safe_return/core/utils/widgets/custom_app_bar.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/functions/custom_snack_bar.dart';
import '../../../../homeView/data/models/get_missing_form_model/get_missing_form_model.dart';
import '../../../../homeView/data/models/get_missing_form_model/missing_report.dart';
import '../../../../homeView/presentation/manager/forms_cubit/forms_cubit.dart';

class MyMissingReportsViewBody extends StatefulWidget {
  const MyMissingReportsViewBody({super.key});

  @override
  State<MyMissingReportsViewBody> createState() =>
      _MyMissingReportsViewBodyState();
}

class _MyMissingReportsViewBodyState extends State<MyMissingReportsViewBody> {
  GetMissingFormModel? missingFormModel;
  List<MissingReport>? reports;
  bool isLoading = false;

  late Future<void> initialization;

  @override
  void initState() {
    super.initState();
    initialization = initializeData();
  }

  Future<void> initializeData() async {
    missingFormModel =
        GetMissingFormModel(message: 'initial message', reports: reports);
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
      },
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ModalProgressHUD(
            progressIndicator: const Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ),
            inAsyncCall: isLoading,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customAppBar(
                    context,
                    title: 'My Missing Reports',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Expanded(
                    child: CustomMyMissingReportsListViewBuilder(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
